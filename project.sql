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

create table topic
(
  id int(11) not null auto_increment comment '帖子ID',
  user_id int(11) not null comment '发帖人ID',
  create_time timestamp null default null comment '创建时间',
  update_time timestamp null default current_timestamp on update current_timestamp comment '最后更改时间',
  title varchar(200) not null comment '标题',
  content text not null COMMENT '内容',
  click int(11) not null default 0 comment '点击量',
  primary key (id)
)engine =InnoDB auto_increment=12 default charset =utf8;

create table reply
(
  id bigint(20) not null auto_increment comment '回复ID',
  topic_id int(11) not null comment '主题ID',
  reply_user_id int(11) not null comment '回复用户ID',
  content text not null comment '回复内容',
  create_time timestamp null default null comment '创建时间',
  primary key(id)
)engine =InnoDB auto_increment=12 default charset =utf8;