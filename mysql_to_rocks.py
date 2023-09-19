# -*- coding: UTF-8 -*-
import os
import re

mysql_host = "192.168.9.232"
mysql_port = "3317"
mysql_user = "hadoop"
mysql_password = "DHzg3XRsw9vwh"


def transform_table_struct(path):
    with open(path, 'r+') as f:
        s = f.read()

        # 删除 AUTO_INCREMENT 关键字
        s = s.replace('AUTO_INCREMENT', '')

        # 删除字符集与排序规则相关的参数
        charset_pattern = r'CHARACTER SET\s+\S+\s+COLLATE\s+\S+'
        s = re.sub(charset_pattern, '', s)

        # 将 timestamp 数据类型转换为 datetime
        s = re.sub('\bTIMESTAMP\b', 'DATETIME', s, flags=re.I)

        # 将指定长度的字符串、文本、二进制等数据类型转换为 varchar(65533)
        varchar_pattern = (
            r'(TINY|MEDIUM|LONG)?(TEXT|BLOB|STRING|BINARY|VARBINARY)\s*(\(\s*\d+\s*\))?'
        )
        s = re.sub(varchar_pattern, 'VARCHAR(65533)', s, flags=re.IGNORECASE)

        # 将 enum 数据类型转换为 varchar(65533)
        enum_pattern = r'ENUM\s*\([^)]*\)'
        s = re.sub(enum_pattern, 'VARCHAR(65533)', s, flags=re.IGNORECASE)

        # 将 set 数据类型转换为 varchar(65533)
        s = s.replace('SET', 'VARCHAR(65533)')

        # 将 set 数据类型转换为 varchar(65533)
        s = s.replace('mediumint', 'int')

        # 将 bit 数据类型转换为 varchar(65533)
        s = s.replace('BIT', 'VARCHAR(65533)')

        # 将 decimal 数据类型转换为 double
        decimal_pattern = r'DECIMAL\s*\([^)]*\)'
        s = re.sub(decimal_pattern, 'DOUBLE', s, flags=re.IGNORECASE)

        # 替换double
        s = re.sub('double\(\d,\d\)', 'DOUBLE', s, flags=re.I)

        # 删除 unsigned 和 zerofill 关键字
        s = re.sub('UNSIGNED', '', s, flags=re.I)
        s = re.sub('ZEROFILL', '', s, flags=re.I)

        # 将 json 数据类型转换为 varchar(65533)
        s = s.replace('JSON', 'VARCHAR(65533)')

        # 将所有varchar替换为varchar(65533)
        s = re.sub('VARCHAR\(\d*\)', 'VARCHAR(65533)', s, flags=re.I)

        # 将所有current_timestamp()替换为current_timestamp
        s = re.sub('current_timestamp\(\)', 'CURRENT_TIMESTAMP', s, flags=re.I)

        # 将default值增加上引号
        s = re.sub('(DEFAULT\s+)(\d+)', '\\1\'\\2\'', s, flags=re.I)

        # 删除结尾的逗号
        end_comma_pattern = re.compile(r',\s*([\n]?\s*\))')
        s = re.sub(end_comma_pattern, '\n\\1', s)

        # 写回文件中
        f.seek(0)
        f.write(s)
        f.truncate()


def transform_tables():
    # create result directory if not exists
    if not os.path.exists("result"):
        os.makedirs("result")

    # set default sql file path to ../result/mysql_to_rocks.sql
    path = "result/mysql_to_rocks.sql"

    # delete sql file if it exists
    if os.path.exists(path):
        os.remove(path)

    # get create table sql for mysql
    with open("mysql_tables") as f:
        tables_list = [t.strip() for t in f.readlines() if not t.startswith('#')]

    with open(path, "w") as f:
        for table in tables_list:
            cmd = f"echo 'show create table {table};' | mysql -h{mysql_host} -u{mysql_user} -p{mysql_password} -P{mysql_port}"
            table_sql = os.popen(cmd).read()
            f.write(table_sql)

    # adjust sql
    with open("result/tmp111.sql", "w") as f1, open(path) as f2:
        lines = f2.readlines()
        for i in range(1, len(lines), 2):
            f1.write((lines[i].split('\t')[1] + ";\n").replace('\\n', '\n'))

    with open("result/tmp222.sql", "w") as f1, open("result/tmp111.sql") as f2:
        lines = f2.readlines()
        i = 0
        while i < len(lines):
            if lines[i].startswith('CREATE TABLE'):
                f1.write(lines[i])
                j = i + 1
                while not lines[j].startswith(') ENGINE='):
                    f1.write(lines[j])
                    j += 1
                if lines[j].find('COMMENT=') != -1:
                    comment = lines[j][lines[j].find('COMMENT=') + 9 : -2]
                else:
                    comment = 'MYSQL'
                f1.write(
                    f') ENGINE=MYSQL\n COMMENT "{comment}"\nPROPERTIES (\n"host" = "rocksHostIp",\n'
                    '"port" = "rocksHostPort",\n"user" = "rocksHostUser",\n"password" = "rocksHostPassword",\n'
                    '"database" = "rocksDataBases",\n"table" = "rocksTables");\n'
                )
                i = j + 1
            else:
                i += 1

    # delete tables special struct
    with open(path, "w") as f1, open("result/tmp222.sql") as f2:
        for line in f2:
            if not (line.startswith('  KEY') or line.startswith('  CON')):
                f1.write(line)

    os.remove("result/tmp111.sql")
    os.remove("result/tmp222.sql")

    # start transform tables struct
    with open(path, 'r') as f:
        lines = f.readlines()

    # 删除匹配行
    with open(path, 'w') as f:
        for line in lines:
            if not re.search('PRIMARY KEY|UNIQUE KEY', line):
                f.write(line)

    # replace mysql password, database, table, host
    with open(path) as f:
        content = f.read()
        for t_name in tables_list:
            d, t = t_name.split('.')
            content = content.replace("rocksHostIp", mysql_host, 1)
            content = content.replace("rocksHostPort", mysql_port, 1)
            content = content.replace("rocksHostUser", mysql_user, 1)
            content = content.replace("rocksHostPassword", mysql_password, 1)
            content = content.replace("rocksDataBases", d, 1)
            content = content.replace("rocksTables", t, 1)
        with open(path, "w") as fp:
            fp.write(content)

    # transform tables struct from mysql to rocks external
    transform_table_struct(path)

    # generate an orderly table name and add if not exists statement
    # rocks_tables_list = [
    #     t.strip()
    #     for t in open("/opt/module/mysqlToRocks/conf/rocks_tables")
    #     if not t.startswith('#')
    # ]
    with open(path, 'r+') as f:
        content = f.read()
        for i, table in enumerate(tables_list):
            d_t = tables_list[i].split('.')[1]
            new_name = "sdi_db.sdi_" + tables_list[i].split('.')[0] + "_" + d_t
            content = content.replace(
                f'TABLE `{d_t}`', f'TABLE IF NOT EXISTS {new_name}'
            )
        f.seek(0)
        f.write(content)

    # create database
    # with open(path, 'r+') as f:
    #     content = f.read()
    #     databases_list = set([t.split('.')[0] for t in rocks_tables_list])
    #     for d in databases_list:
    #         f.seek(0)
    #         f.write(f'CREATE DATABASE IF NOT EXISTS {d};\n')
    #         f.write(content)


transform_tables()
