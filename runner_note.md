#流程
1、发单，发单人paymoney更改，发单人发单信息中状态为等待接单中
2、显示订单状态为0的订单在主界面（默认最新时间排序）
3、点接单，订单状态改为1，订单接单人以及时间更新，接单人接单信息出现订单所有信息包括取货信息，发单人订单信息中更改状态为已被接单，接单人为。。并显示确认收货按钮


#sping mvc
①在web.xml 中配置前端控制器（已配置，在公共web.xml中）
②创建Controller类
③创建spring mvc 配置文件，配置控制器映射信息springmvc-config.xml


#数据类型mysql对应java类型
Ⅰ Date 只保存日期，不保存时分秒 
Ⅱ DateTime在你需要同时包含日期和时间信息的值时,支持的范围是'1000-01-01 00:00:00'到'9999-12-31 23:59:59'
Ⅲ TimeStamp列类型，提供一种类型，你可以使用它自动地用当前的日期和时间标记insert和update的操作如果有多个列，则只有第一个会自动更新

#Integer与int
当查询不到结果时，若使用Integer则会返回null，使用int会出现异常情况

#count(*)与*
当想判断是否有该记录是最好使用select count(*) from e where a=#{a}来查询是否存在
若使用select * from e where a=#{a},则会返回空值null与实际所想得到的值int不符