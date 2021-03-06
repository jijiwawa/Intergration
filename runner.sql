alter table orderform add client_grade int(3) comment '发单者打分'
alter table orderform add client_comment varchar(50) comment '发单者评价'
alter table orderform add trustee_grade int(3) comment '接单者为发单者打分'
alter table orderform add trustee_comment varchar(50) comment '接单者对发单者的评价'

create table orderform
(
  id int(11) not null auto_increment comment '订单唯一id',
  order_num varchar(15) not null comment '快递单号',
  express_company varchar(10) not null comment '快递公司',
  pickup_ads varchar(50) not null comment '取货地点',
  latest_time varchar(5) not null comment '最晚取货时间',
  goods_size varchar(5) not null comment '货物大小',
  paymoney decimal not null comment '支付金额',
  client_id int(11) not null comment '委托人id',
  remark varchar(100) comment '备注（货物描述）',
  depute_time  timestamp default current_timestamp comment '委托时间',
  trustee_id int(11) default null comment '受托人id',
  take_time timestamp default null comment '接单时间',
  pick_code varchar(10) comment '取货码',
  pick_phonenum char(11) comment '取货手机号码',
  pick_name varchar comment '取货所需姓名',
  order_state int default 0 comment '订单状态0待接单，1被接单，运送中，2已收货，3废弃或者暂时不用'
  primary key(id),
  foreign key(client_id) references user,
  foreign key(trustee_id) references user
)engine =InnoDB auto_increment=1 default charset =utf8;

create table assess_runner
(
  id int(11) not null auto_increment comment '争对某订单的评价',
  orderform_id int(11) not null comment '订单id',
  client_grade int(3) comment '发单者打分',
  client_comment varchar(50) comment '发单者评价',
  trustee_grade int(3) comment '接单者为发单者打分',
  trustee_comment varchar(50) comment '接单者对发单者的评价',
  primary key(id),
  foreign key(client_id) references user,
  foreign key(trustee_id) references user
)engine =InnoDB auto_increment=1 default charset =utf8;