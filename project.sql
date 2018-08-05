create table user
(
  id int(11) not null auto_increment comment '用户唯一ID',
  phone_number char(11) not null comment '电话号码',
  user_name varchar(20)  not null comment '用户名',
  is_male  tinyint not null comment '性别:0表示男，1表示女',
  property decimal default 20.0 comment '资产',
  head_sculpture varchar(100) default null comment '头像url',
  type tinyint not null default 0 comment '用户类型:0表示普通用户，1表示管理员，2表示社团管理人',
  password varchar(50) not null comment '密码',
  credit decimal default 100.0 comment '信誉度',
  primary key(id)
)engine =InnoDB auto_increment=12 default charset =utf8;
