CREATE TABLE IF NOT EXISTS sdi_db.sdi_oms_new_order_product_instance (
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
"port" = "3314",
"user" = "hadoop",
"password" = "hadoopIN2323314",
"database" = "oms_new",
"table" = "order_product_instance");
CREATE TABLE IF NOT EXISTS sdi_db.sdi_oms_new_order_form (
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
"port" = "3314",
"user" = "hadoop",
"password" = "hadoopIN2323314",
"database" = "oms_new",
"table" = "order_form");
CREATE TABLE IF NOT EXISTS sdi_db.sdi_oms_new_order_instance_user (
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
"port" = "3314",
"user" = "hadoop",
"password" = "hadoopIN2323314",
"database" = "oms_new",
"table" = "order_instance_user");
CREATE TABLE IF NOT EXISTS sdi_db.sdi_pcs_new_product (
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
"port" = "3314",
"user" = "hadoop",
"password" = "hadoopIN2323314",
"database" = "pcs_new",
"table" = "product");
