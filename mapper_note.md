# namespace 表明命名空间
<mapper namespace="com.runner.dao.OrderFormDao">

# 查询语句
<select id="getUserByUserName" resultType="com.mainpage.domain.User" parameterType="java.lang.String">
        select * from dbe.user where user_name=#{username}
</select>

#解决TimeStamp数据类型查出来不是null
url=jdbc:mysql://www.dengrong.xin:3307/dbe?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull