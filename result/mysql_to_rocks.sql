CREATE TABLE IF NOT EXISTS sdi_db.sdi_aggregate_account (
  `account_id` int(10)  NOT NULL  COMMENT '账号唯一标识',
  `account_name` VARCHAR(65533) NOT NULL COMMENT '账号名：手机号 邮箱等，目前都是手机号',
  `password` char(40) NOT NULL COMMENT '密码',
  `owner_mobile` VARCHAR(65533) DEFAULT NULL COMMENT '本人手机号',
  `owner_mobile_operator_code` smallint(5)  DEFAULT NULL COMMENT '本人手机号运营商',
  `fee_mobile` VARCHAR(65533) DEFAULT NULL COMMENT '付费手机号',
  `fee_mobile_operator_code` smallint(5)  DEFAULT NULL COMMENT '付费手机号运营商',
  `status` tinyint(3)  NOT NULL COMMENT '状态（1使用中，0已注销）',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_date` datetime NOT NULL COMMENT '修改时间 新增时同创建时间'
) ENGINE=MYSQL
 COMMENT "账号表"
PROPERTIES (
"host" = "192.168.9.232",
"port" = "3315",
"user" = "hadoop",
"password" = "TaixuVeepoh7",
"database" = "aggregate",
"table" = "account");
CREATE TABLE IF NOT EXISTS sdi_db.sdi_aggregate_account_mapping (
  `mapping_id` int(10)  NOT NULL  COMMENT '唯一标识  主键，自增',
  `web_id` int(10)  NOT NULL COMMENT '老平台账号标识',
  `user_id` int(10)  DEFAULT NULL COMMENT '老平台账号对应的用户标识',
  `user_type` tinyint(3)  DEFAULT NULL COMMENT '老平台账号对应的用户类型 0老师 2家长',
  `org_id` int(10)  DEFAULT NULL COMMENT '老平台学校标识',
  `platform` VARCHAR(65533) NOT NULL COMMENT '老平台标识 hnjxlx：河南家校互动， nmjxlx：内蒙家校联系，  hnzxjx：河南众享家校，hbjxt：河北家校通，hnybt：河南优蓓通，xinzx：统一新平台',
  `account_id` int(10)  NOT NULL COMMENT '新平台账号标识',
  `status` tinyint(3)  NOT NULL COMMENT '状态 0 删除 1 正常',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_date` datetime NOT NULL COMMENT '修改时间 新增时同创建时间',
  `old_student_id` int(10) DEFAULT NULL COMMENT '220117老平台学生id，家长账号时有',
  `unit_id` int(10)  DEFAULT NULL COMMENT '老平台学生所在班级id',
  `new_user_id` int(10)  DEFAULT NULL COMMENT '新平台用户id:user_parent.parent_id或teacher.teacher_id',
  `new_user_type` tinyint(3)  DEFAULT NULL COMMENT '新平台用类型: 0老师 2家长',
  `new_student_id` int(10)  DEFAULT NULL COMMENT '新平台学生标识',
  `class_id` int(10)  DEFAULT NULL COMMENT '新平台班级标识',
  `school_id` int(10) DEFAULT NULL COMMENT '新平台学校标识'
) ENGINE=MYSQL
 COMMENT "MYSQL"
PROPERTIES (
"host" = "192.168.9.232",
"port" = "3315",
"user" = "hadoop",
"password" = "TaixuVeepoh7",
"database" = "aggregate",
"table" = "account_mapping");
CREATE TABLE IF NOT EXISTS sdi_db.sdi_aggregate_business_resource (
  `business_resource_id` int(11) NOT NULL  COMMENT '主键',
  `business_id` int(11) NOT NULL COMMENT '业务标识',
  `resource_type` int(11) NOT NULL COMMENT '资源类型 资源类型  1：课程  2 ： 讲  3 天天练  4 单元测试卷  5定制化资源  6定制化试卷 7高考王者 8定制化试卷（新）',
  `resource_id` int(11) DEFAULT NULL COMMENT '资源标识',
  `resource_name` VARCHAR(65533) NOT NULL COMMENT '资源名称',
  `create_date` datetime NOT NULL,
  `update_date` datetime DEFAULT NULL,
  `resource_code` VARCHAR(65533) DEFAULT NULL COMMENT '资源编码  目前只有高考王者用'
) ENGINE=MYSQL
 COMMENT "MYSQL"
PROPERTIES (
"host" = "192.168.9.232",
"port" = "3315",
"user" = "hadoop",
"password" = "TaixuVeepoh7",
"database" = "aggregate",
"table" = "business_resource");
CREATE TABLE IF NOT EXISTS sdi_db.sdi_aggregate_grade_group (
  `grade_group_id` int(10)  NOT NULL  COMMENT '年级固定群组标识',
  `grade_id` int(10)  NOT NULL COMMENT '年级标识',
  `school_id` int(10)  NOT NULL COMMENT '学校标识',
  `grade_group_name` VARCHAR(65533) NOT NULL COMMENT '年级固定群组名称',
  `grade_group_sequence` smallint(5)  NOT NULL COMMENT '展示次序',
  `grade_group_type` tinyint(3)  NOT NULL COMMENT '群组类型:1：班级（学生群组），2：教师群组',
  `class_type` tinyint(3)  NOT NULL COMMENT '群组类型为「1：班级」时表示班级类型，群组类型为「2：教师群组」时固定填 1。1：学校班级（默认），2：线下班级，3：线上班级',
  `cloud_address` VARCHAR(65533) DEFAULT NULL COMMENT '云地址',
  `status` tinyint(3)  NOT NULL COMMENT '状态: 0：禁用，1：正常',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_date` datetime NOT NULL COMMENT '修改时间 新增时同创建时间'
) ENGINE=MYSQL
 COMMENT "年级固定群组表"
PROPERTIES (
"host" = "192.168.9.232",
"port" = "3315",
"user" = "hadoop",
"password" = "TaixuVeepoh7",
"database" = "aggregate",
"table" = "grade_group");
CREATE TABLE IF NOT EXISTS sdi_db.sdi_aggregate_order_form (
  `order_id` int(11)  NOT NULL  COMMENT '订单唯一标识',
  `order_number` VARCHAR(65533) NOT NULL COMMENT '订单编号',
  `order_name` VARCHAR(65533) NOT NULL COMMENT '订单名称 订购时根据规则自动生成',
  `account_id` int(11)  DEFAULT NULL COMMENT '账号标识',
  `user_id` int(11)  DEFAULT NULL COMMENT '用户id  教师身份为教师id 学生身份为学生id',
  `user_type` tinyint(4) DEFAULT NULL COMMENT '用户类型  1学生2家长0教师 ',
  `mobile` VARCHAR(65533) DEFAULT NULL COMMENT '手机号码',
  `orig_price` DOUBLE NOT NULL COMMENT '原价',
  `discount_amount` DOUBLE DEFAULT NULL COMMENT '优惠金额',
  `payable_amount` DOUBLE NOT NULL COMMENT '应付金额 原件优惠之后的金额',
  `coupoun_amount` DOUBLE DEFAULT NULL COMMENT '优惠券抵用金额',
  `ese_coin_amount` DOUBLE DEFAULT NULL COMMENT '众享币抵用金额',
  `actually_amount` DOUBLE NOT NULL COMMENT '实际支付金额 =原价-优惠额-众享币-优惠券',
  `receipt_flag` tinyint(4)  NOT NULL COMMENT '是否要发票 1是 0否',
  `status` tinyint(4)  NOT NULL COMMENT '状态：1 有效;0无效; ',
  `pay_status` tinyint(4)  NOT NULL COMMENT '支付状态：0待支付 1 支付成功 2 支付失败 3待支付 4取消支付\\r\
 5 订单关闭（超时未支付成功） 6退款申请中  7 退款审核中 8退订中 9已退订（包含退费和退订） 10已到期 11预订单（到时间更新为0）',
  `enterprise_code` VARCHAR(65533) NOT NULL COMMENT '支付商户：ZX--众享 LX-乐学 JXT-家校通 NM-内蒙 YB-优蓓',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `confirm_date` datetime DEFAULT NULL COMMENT '确认时间',
  `cancel_date` datetime DEFAULT NULL COMMENT '取消时间',
  `paid_date` datetime DEFAULT NULL COMMENT '支付时间',
  `period_charge_id` int(11)  DEFAULT NULL COMMENT '自动续费标识',
  `source_type` tinyint(4)  DEFAULT NULL COMMENT '订单来源：1:文件批量导入订购/退订;2:用户自主上行订购/退订(我方通道);3:手机上行订购/退订（运营商通道）;\\r\
\t5:H5订购6:客户端APP订购7:移动公司外呼订购;8：系统批量写入(群发再触发)；9：一键触发；10：单个添加',
  `marketing_type` tinyint(4)  DEFAULT NULL COMMENT '来源渠道  1 用户自行购买  2 公众号 3市场推广 4客服推广 ',
  `host_id` tinyint(4)  DEFAULT NULL COMMENT ' 客户端/页面类型 1-河南校讯通（安卓） 2-河南众享圈（安卓）9-河北家校通（安卓）12-众享教育（安卓）18-和校园学生（安卓）\\r\
\t20-和校园教师（安卓）24-骨碌碌教师（安卓）25-骨碌碌学生（安卓）',
  `web_id` int(10)  DEFAULT NULL COMMENT '用户webId',
  `student_id` int(10)  DEFAULT NULL COMMENT '学生id',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `order_type` tinyint(4)  NOT NULL DEFAULT '1' COMMENT '订单类型 1 个付订单   3 预存订单 4 统付订单'
) ENGINE=MYSQL
 COMMENT "存储第三方支付订购的订单相关信息"
PROPERTIES (
"host" = "192.168.9.232",
"port" = "3315",
"user" = "hadoop",
"password" = "TaixuVeepoh7",
"database" = "aggregate",
"table" = "order_form");
CREATE TABLE IF NOT EXISTS sdi_db.sdi_aggregate_order_instance_user (
  `inst_user_id` int(11)  NOT NULL  COMMENT '主键',
  `order_id` int(11)  NOT NULL COMMENT '订单标识',
  `account_id` int(11)  DEFAULT NULL COMMENT '账号标识',
  `mobile` VARCHAR(65533) DEFAULT NULL COMMENT '手机号码',
  `user_id` int(11) DEFAULT NULL COMMENT '用户id  教师身份为教师id 学生身份为学生id',
  `user_name` VARCHAR(65533) DEFAULT NULL COMMENT '姓名',
  `user_type` tinyint(4) DEFAULT NULL COMMENT '用户类型  1学生2家长0教师 ',
  `province_id` int(11) DEFAULT NULL COMMENT '省份   1河南 2内蒙 5河北',
  `area_id` int(11) DEFAULT NULL COMMENT '地市',
  `sub_area_id` int(11) DEFAULT NULL COMMENT '县区',
  `org_id` int(11) DEFAULT NULL COMMENT '学校id',
  `grade_code` int(11) DEFAULT NULL COMMENT '适用年级 0不限 对应登录获取的年级i \t 21--一年级 22--二年级 23--三年级 24--四年级 25--五年级 26--六年级 31--七年级 32--八年级 33--九年级 41--高一 42--高二 43--高三',
  `unit_id` int(11) DEFAULT NULL COMMENT '班级id',
  `unit_name` VARCHAR(65533) DEFAULT NULL COMMENT '班级',
  `verison_id` int(11) DEFAULT NULL COMMENT ' 版本  ',
  `platform` VARCHAR(65533) DEFAULT NULL COMMENT 'hnjxlx 河南家校互动  hnzxjy 河南众享家校 xinzx 新平台',
  `create_date` datetime NOT NULL,
  `update_date` datetime DEFAULT NULL COMMENT '最后一次修改时间',
  `web_id` int(10)  DEFAULT NULL COMMENT '用户webId',
  `student_id` int(10)  DEFAULT NULL COMMENT '学生id',
  `record_id` int(10)  DEFAULT NULL COMMENT '用户自主加入资料唯一标识（资料库user_self_administered_record表主键）'
) ENGINE=MYSQL
 COMMENT "订购实例对应的用户身份相关信息"
PROPERTIES (
"host" = "192.168.9.232",
"port" = "3315",
"user" = "hadoop",
"password" = "TaixuVeepoh7",
"database" = "aggregate",
"table" = "order_instance_user");
CREATE TABLE IF NOT EXISTS sdi_db.sdi_aggregate_order_product_instance (
  `prod_inst_id` int(11)  NOT NULL  COMMENT '主键',
  `order_id` int(11)  NOT NULL COMMENT '订单标识',
  `product_id` int(11)  NOT NULL COMMENT '产品标识',
  `account_id` int(11)  DEFAULT NULL COMMENT '账号标识',
  `user_id` int(11)  DEFAULT NULL COMMENT '用户id  教师身份为教师id 学生身份为学生id',
  `user_type` tinyint(4) DEFAULT NULL COMMENT '用户类型  1学生2家长0教师 ',
  `mobile` VARCHAR(65533) DEFAULT NULL COMMENT '手机号码',
  `orig_price` DOUBLE NOT NULL COMMENT '原价',
  `actually_amount` DOUBLE NOT NULL COMMENT '实际支付金额 ',
  `authorize_type` tinyint(2) NOT NULL COMMENT ' 授权类型 1个人，支持个人购买;2集团，支持学校统付;3团购，支持拼团;4自动续费',
  `effective_date` datetime NOT NULL COMMENT '生效时间 从服务的生效时间里得到',
  `expire_date` datetime DEFAULT NULL COMMENT '失效时间 从服务的失效时间里得到',
  `status` tinyint(4)  NOT NULL COMMENT '状态：1已支付 6退款申请中 7 退款审核中 8退订中   9已退订 10已到期',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_date` datetime DEFAULT NULL COMMENT '最后一次修改时间',
  `web_id` int(10)  DEFAULT NULL COMMENT '用户webId',
  `student_id` int(10)  DEFAULT NULL COMMENT '学生id'
) ENGINE=MYSQL
 COMMENT "产品订购实例"
PROPERTIES (
"host" = "192.168.9.232",
"port" = "3315",
"user" = "hadoop",
"password" = "TaixuVeepoh7",
"database" = "aggregate",
"table" = "order_product_instance");
CREATE TABLE IF NOT EXISTS sdi_db.sdi_aggregate_order_service_instance (
  `service_instance_id` int(11)  NOT NULL  COMMENT '主键',
  `order_id` int(11)  NOT NULL COMMENT '订单标识',
  `product_id` int(11)  NOT NULL COMMENT '产品标识',
  `service_id` int(11)  NOT NULL COMMENT '服务标识',
  `business_id` int(11) NOT NULL COMMENT '业务标识',
  `business_code` VARCHAR(65533) NOT NULL DEFAULT '' COMMENT '业务编码',
  `account_id` int(11)  DEFAULT NULL COMMENT '账号标识',
  `user_id` int(11)  DEFAULT NULL COMMENT '用户id  教师身份为教师id 学生身份为学生id',
  `user_type` tinyint(4) DEFAULT NULL COMMENT '用户类型  1学生2家长0教师 ',
  `mobile` VARCHAR(65533) DEFAULT NULL COMMENT '手机号码',
  `business_calc_method` VARCHAR(65533) NOT NULL COMMENT '业务量计算方法 AMOUNT-计量 STATUS-计状态 VALID_PERIDO--有效期 AMOUNT+VP计量且有效期',
  `calc_unit` VARCHAR(65533) DEFAULT NULL COMMENT '计量单位  次 小时 天 月 分钟',
  `service_amount` int(11) DEFAULT NULL COMMENT '服务量',
  `authorize_type` tinyint(2) NOT NULL COMMENT ' 授权类型 1个人，支持个人购买;2集团，支持学校统付;3团购，支持拼团;4自动续费',
  `effective_date` datetime NOT NULL COMMENT '生效时间',
  `expire_date` datetime DEFAULT NULL COMMENT '失效时间',
  `status` tinyint(4)  NOT NULL COMMENT '状态：1已支付 6退款申请中 7 退款审核中 8退订中   9已退订 10已到期',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_date` datetime DEFAULT NULL COMMENT '最后一次修改时间',
  `web_id` int(10)  DEFAULT NULL COMMENT '用户webId',
  `student_id` int(10)  DEFAULT NULL COMMENT '学生id',
  `service_freq` int(11) DEFAULT NULL COMMENT '服务频率',
  `freq_unit` VARCHAR(65533) DEFAULT NULL COMMENT '服务频率单位：日、月、自然月',
  `consume_amount` int(11) DEFAULT NULL COMMENT '消费量',
  `remain_amount` int(11) DEFAULT NULL COMMENT '剩余量',
  `remain_flag` int(11) DEFAULT NULL COMMENT '是否还有剩余 1是 0否',
  `current_freq_date` datetime DEFAULT NULL COMMENT '本次频率周期结束时间'
) ENGINE=MYSQL
 COMMENT "服务订购实例"
PROPERTIES (
"host" = "192.168.9.232",
"port" = "3315",
"user" = "hadoop",
"password" = "TaixuVeepoh7",
"database" = "aggregate",
"table" = "order_service_instance");
CREATE TABLE IF NOT EXISTS sdi_db.sdi_aggregate_product (
  `product_id` int(11) NOT NULL  COMMENT '主键',
  `product_name` VARCHAR(65533) NOT NULL COMMENT '产品名称',
  `description` VARCHAR(65533) DEFAULT NULL COMMENT '产品描述',
  `product_type` VARCHAR(65533) NOT NULL COMMENT '产品类型 KCNR课程 KCBY包月',
  `user_visible` tinyint(2) NOT NULL COMMENT '是否对用户可见1是0否',
  `create_date` datetime NOT NULL,
  `update_date` datetime DEFAULT NULL COMMENT '最后一次修改时间',
  `effective_date` datetime NOT NULL COMMENT '生效时间',
  `expire_date` datetime DEFAULT NULL COMMENT '失效时间',
  `settle_type` tinyint(2) DEFAULT NULL COMMENT '结算方式 1.第三方支付；2.苹果商店支付；3.运营商扣费；4.银联转账；5.现金',
  `status` tinyint(2) NOT NULL COMMENT '状态1 有效;0无效 查询加状态条件',
  `price_type` tinyint(2) NOT NULL COMMENT '定价方式 1按产品定价 2按服务定价',
  `tariff` DOUBLE NOT NULL COMMENT '资费 产品定价这里就是实际的资费 服务定价 这里填写不同的服务策略的最小价格 页面展示“**起”',
  `authorize_type` tinyint(2) NOT NULL COMMENT ' 授权类型 1个人，支持个人购买;2集团，支持学校统付;3团购，支持拼团;4自动续费',
  `prod_detail` VARCHAR(65533) DEFAULT NULL COMMENT '详情，存储产品介绍的页面',
  `enterprise_code` VARCHAR(65533) NOT NULL COMMENT '归属商户：ZX--众享 LX-乐学 JXT-家校通 NM-内蒙 HN_YB-河南移动优蓓 HN_XXT-河南移动校信通 HN_ZXKC-河南移动在线课程 HN_DZSC河南移动定制手册',
  `max_num` int(11) DEFAULT NULL COMMENT '支持购买的人数 为空则不限',
  `multiple_flag` tinyint(2) NOT NULL COMMENT '是否可重复购买 1允许 0不允许',
  `new_product_name` VARCHAR(65533) DEFAULT NULL COMMENT '新产品名称',
  `new_product_name_suffix` VARCHAR(65533) DEFAULT NULL COMMENT '新产品名称后缀',
  `sub_product_type` VARCHAR(65533) DEFAULT NULL COMMENT '子产品类型',
  `auth_type` tinyint(4) DEFAULT NULL COMMENT '鉴权类型1.  手机号鉴权(mobile) 2. 身份鉴权（webId）3. 学生鉴权（stuId）'
) ENGINE=MYSQL
 COMMENT "描述产品相关信息"
PROPERTIES (
"host" = "192.168.9.232",
"port" = "3315",
"user" = "hadoop",
"password" = "TaixuVeepoh7",
"database" = "aggregate",
"table" = "product");
CREATE TABLE IF NOT EXISTS sdi_db.sdi_aggregate_school (
  `school_id` int(10)  NOT NULL  COMMENT '学校标识',
  `school_name` VARCHAR(65533) NOT NULL COMMENT '学校名称',
  `school_short_name` VARCHAR(65533) NOT NULL COMMENT '学校简称',
  `school_type` smallint(5)  NOT NULL COMMENT '学校类型:111：幼儿园，211：小学，311：初中，321：九年一贯制学校，341：完全中学，342：高级中学，345：十二年一贯制学校，0：其他',
  `school_nature` tinyint(3)  NOT NULL COMMENT '单位性质:1：公办学校，2：民办学校，3：政府机构，4：事业单位，5：培训机构',
  `province_code` tinyint(3)  NOT NULL COMMENT '省份编码',
  `city_code` smallint(5)  NOT NULL COMMENT '城市编码',
  `county_code` int(8)  NOT NULL COMMENT '县区编码',
  `province_name` VARCHAR(65533) NOT NULL COMMENT '省份名称',
  `city_name` VARCHAR(65533) NOT NULL COMMENT '城市名称',
  `county_name` VARCHAR(65533) NOT NULL COMMENT '县区名称',
  `teacher_num` int(10)  DEFAULT NULL COMMENT '教师人数',
  `student_num` int(10)  DEFAULT NULL COMMENT '学生人数',
  `cloud_address` VARCHAR(65533) DEFAULT NULL COMMENT '云地址',
  `status` tinyint(3)  NOT NULL COMMENT '状态 0：禁用，1：正常',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_date` datetime NOT NULL COMMENT '修改时间 新建时同创建时间'
) ENGINE=MYSQL
 COMMENT "学校表"
PROPERTIES (
"host" = "192.168.9.232",
"port" = "3315",
"user" = "hadoop",
"password" = "TaixuVeepoh7",
"database" = "aggregate",
"table" = "school");
CREATE TABLE IF NOT EXISTS sdi_db.sdi_aggregate_school_branch (
  `school_branch_id` int(10)  NOT NULL  COMMENT '主键、唯一标识，分校id',
  `school_id` int(10)  NOT NULL COMMENT '总校id',
  `branch_name` VARCHAR(65533) NOT NULL COMMENT '分校全称',
  `short_name` VARCHAR(65533) NOT NULL COMMENT '分校简称',
  `order_seq` int(10)  NOT NULL COMMENT '分校排序',
  `status` tinyint(3)  NOT NULL COMMENT '状态。0：删除；1：正常',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_date` datetime NOT NULL COMMENT '修改时间'
) ENGINE=MYSQL
 COMMENT "分校"
PROPERTIES (
"host" = "192.168.9.232",
"port" = "3315",
"user" = "hadoop",
"password" = "TaixuVeepoh7",
"database" = "aggregate",
"table" = "school_branch");
CREATE TABLE IF NOT EXISTS sdi_db.sdi_aggregate_school_grade (
  `grade_id` int(10)  NOT NULL  COMMENT '年级标识',
  `school_id` int(10)  NOT NULL COMMENT '学校标识',
  `school_branch_id` int(10) NOT NULL DEFAULT '0' COMMENT '分校id，0表示本校',
  `grade_name` VARCHAR(65533) NOT NULL COMMENT '年级名称',
  `grade_phase` smallint(5)  DEFAULT NULL COMMENT '学段  111：幼儿园，211：小学，311：初中 342：高中 0：其他',
  `year_length` tinyint(3)  DEFAULT NULL COMMENT '年制  使用具体的数字表示，如：3 表示 3 年制，6 表示 6 年制',
  `graduation_year` smallint(5)  NOT NULL COMMENT '毕业年份(届)',
  `student_num` smallint(5)  DEFAULT NULL COMMENT '学生人数',
  `cloud_address` VARCHAR(65533) DEFAULT NULL COMMENT '云地址',
  `status` tinyint(3)  NOT NULL COMMENT '状态: 0：禁用，1：正常',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_date` datetime NOT NULL COMMENT '修改时间 新增时同创建时间',
  `grade_sequence` smallint(5)  DEFAULT NULL COMMENT '展示次序'
) ENGINE=MYSQL
 COMMENT "学校年级表"
PROPERTIES (
"host" = "192.168.9.232",
"port" = "3315",
"user" = "hadoop",
"password" = "TaixuVeepoh7",
"database" = "aggregate",
"table" = "school_grade");
CREATE TABLE IF NOT EXISTS sdi_db.sdi_aggregate_school_group_member (
  `school_group_id` int(10)  NOT NULL COMMENT '学校固定群组标识',
  `school_id` int(10)  NOT NULL COMMENT '学校标识',
  `school_group_member_id` int(10)  NOT NULL COMMENT '学校固定群组成员标识',
  `school_group_member_name` VARCHAR(65533) NOT NULL COMMENT '学校固定群组成员姓名',
  `school_group_member_type` smallint(4)  NOT NULL COMMENT '学校固定群组成员类型（角色）',
  `STATUS` tinyint(1)  NOT NULL COMMENT '状态',
  `start_time` DATETIME NOT NULL COMMENT '起始时间',
  `end_time` DATETIME NULL DEFAULT NULL COMMENT '终止时间',
  `create_time` DATETIME NOT NULL COMMENT '创建时间',
  `update_time` DATETIME NULL DEFAULT NULL COMMENT '修改时间'
) ENGINE=MYSQL
 COMMENT "学校固定群组成员表"
PROPERTIES (
"host" = "192.168.9.232",
"port" = "3315",
"user" = "hadoop",
"password" = "TaixuVeepoh7",
"database" = "aggregate",
"table" = "school_group_member");
CREATE TABLE IF NOT EXISTS sdi_db.sdi_aggregate_school_mapping (
  `mapping_id` int(10)  NOT NULL  COMMENT '唯一标识，自增序列',
  `org_id` int(10)  NOT NULL COMMENT '老平台学校标识',
  `platform` VARCHAR(65533) NOT NULL COMMENT '老平台标识 `hnjxlx`：河南家校互动， `nmjxlx`：内蒙家校联系，  `hnzxjx`：河南众享家校，`hbjxt`：河北家校通，`hnybt`：河南优蓓通，`xinzx`：统一新平台',
  `school_id` int(10)  NOT NULL COMMENT '新平台学校标识',
  `status` tinyint(3)  NOT NULL COMMENT '状态 0 删除 1 正常',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_date` datetime NOT NULL COMMENT '修改时间 新增时同创建时间'
) ENGINE=MYSQL
 COMMENT "MYSQL"
PROPERTIES (
"host" = "192.168.9.232",
"port" = "3315",
"user" = "hadoop",
"password" = "TaixuVeepoh7",
"database" = "aggregate",
"table" = "school_mapping");
CREATE TABLE IF NOT EXISTS sdi_db.sdi_aggregate_school_xinzx (
  `school_id` int(10)  NOT NULL COMMENT '学校标示',
  `org_id` int(11) DEFAULT NULL COMMENT '老学校标记',
  `platform` VARCHAR(65533) DEFAULT NULL COMMENT '平台标识',
  `status` tinyint(3)  DEFAULT NULL COMMENT '状态：1正常 0删除',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间'
) ENGINE=MYSQL
 COMMENT "使用新平台的学校记录表"
PROPERTIES (
"host" = "192.168.9.232",
"port" = "3315",
"user" = "hadoop",
"password" = "TaixuVeepoh7",
"database" = "aggregate",
"table" = "school_xinzx");
CREATE TABLE IF NOT EXISTS sdi_db.sdi_aggregate_student (
  `student_id` int(10)  NOT NULL  COMMENT '学生标识',
  `account_id` int(10)  NOT NULL COMMENT '账号标识',
  `student_name` VARCHAR(65533) NOT NULL COMMENT '学生姓名',
  `gender` tinyint(3)  DEFAULT NULL COMMENT '性别 0：未知的性别 1 男 2女',
  `owner_mobile` VARCHAR(65533) DEFAULT NULL COMMENT '本人手机号',
  `owner_mobile_operator_code` smallint(5)  DEFAULT NULL COMMENT '本人手机号运营商',
  `first_contact_mobile` VARCHAR(65533) DEFAULT NULL COMMENT '第一联系人',
  `first_contact_mobile_operator_code` smallint(5)  DEFAULT NULL COMMENT '第一联系人运营商',
  `second_contact_mobile` VARCHAR(65533) DEFAULT NULL COMMENT '第二联系人',
  `second_contact_mobile_operator_code` smallint(5)  DEFAULT NULL COMMENT '第二联系人运营商',
  `primary_year` smallint(6) DEFAULT NULL COMMENT '小学一年级入学时间（年份）',
  `student_status` VARCHAR(65533) DEFAULT NULL COMMENT '学籍号',
  `student_number` VARCHAR(65533) DEFAULT NULL COMMENT '学号',
  `admission_number` VARCHAR(65533) DEFAULT NULL COMMENT '准考证号',
  `cloud_address` VARCHAR(65533) DEFAULT NULL COMMENT '云地址',
  `status` tinyint(3)  NOT NULL COMMENT '状态（0 删除 1正常） ',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_date` datetime NOT NULL COMMENT '修改时间 新增时同创建时间'
) ENGINE=MYSQL
 COMMENT "MYSQL"
PROPERTIES (
"host" = "192.168.9.232",
"port" = "3315",
"user" = "hadoop",
"password" = "TaixuVeepoh7",
"database" = "aggregate",
"table" = "student");
CREATE TABLE IF NOT EXISTS sdi_db.sdi_aggregate_teacher (
  `teacher_id` int(10)  NOT NULL  COMMENT '老师标识',
  `account_id` int(10)  NOT NULL COMMENT '账号标识',
  `teacher_name` VARCHAR(65533) NOT NULL COMMENT '老师姓名',
  `owner_mobile` VARCHAR(65533) NOT NULL COMMENT '本人手机号',
  `owner_mobile_operator_code` smallint(5)  NOT NULL COMMENT '本人手机号运营商',
  `mobile` VARCHAR(65533) DEFAULT NULL COMMENT '联系方式',
  `mobile_operator_code` smallint(5)  DEFAULT NULL COMMENT '联系方式运营商',
  `cloud_address` VARCHAR(65533) DEFAULT NULL COMMENT '云地址',
  `status` tinyint(3)  NOT NULL COMMENT '状态（1正常 0删除）',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_date` datetime NOT NULL COMMENT '修改时间 新建时同创建时间'
) ENGINE=MYSQL
 COMMENT "老师表"
PROPERTIES (
"host" = "192.168.9.232",
"port" = "3315",
"user" = "hadoop",
"password" = "TaixuVeepoh7",
"database" = "aggregate",
"table" = "teacher");
CREATE TABLE IF NOT EXISTS sdi_db.sdi_aggregate_user_parent (
  `parent_id` int(10)  NOT NULL  COMMENT '家长标识',
  `account_id` int(10)  NOT NULL COMMENT '账号标识',
  `parent_name` VARCHAR(65533) NOT NULL COMMENT '家长姓名',
  `owner_mobile` VARCHAR(65533) NOT NULL COMMENT '本人手机号',
  `owner_mobile_operator_code` smallint(5)  NOT NULL COMMENT '本人手机号运营商',
  `status` tinyint(3)  NOT NULL COMMENT '状态(0删除 1正常)',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_date` datetime NOT NULL COMMENT '修改时间 新增时同创建时间'
) ENGINE=MYSQL
 COMMENT "家长表"
PROPERTIES (
"host" = "192.168.9.232",
"port" = "3315",
"user" = "hadoop",
"password" = "TaixuVeepoh7",
"database" = "aggregate",
"table" = "user_parent");
