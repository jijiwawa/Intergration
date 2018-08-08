# 目录功能文件作用
1. java\
存放java源码\
1.1 domain\
实体类\
1.2 dao\
持久层\
1.3 service\
service层

2. resource\
maven创建的目录\
2.1 mapper\
Mybatis映射器\
2.2 applicationContext.xml\
Spring属性配置,因为 application.xml 是系统级别的上下文，所以它的初始化需要放到 web.xml 中的<context-param>标签中，同时其他的类似定时任务的配置文件等等都是放在这个标签下进行初始化的。\
2.3 jdbc.properties\
数据库账户\
2.4 log4j.properties\
日志配置\
2.5 mybatis-config.xml\
Mybatis属性配置\


3. webapp\
存放web资源\
3.1 static\
js,css,images资源\
3.2 WEB-INF\
jsp和web配置\
3.2.1 jsp\
jsp资源\
3.2.2 web.xml\
web配置\
3.2.3 main-servlet.xml\
因为spring-servlet.xml只是 controller 级别的上下文，说白了就是 servlet 级别的初始化，它不涉及到除了转发之外的任何实体，所以它的作用范围仅仅限制在 servlet 级别，所以它的初始化应该是跟spring 的 DispatcherServlet 初始化在一起，所以就是在 <servlet> 表情中初始化的。它有一个默认值就是【/WEB-INF/remoting-servlet.xml 】，注意配置文件的对应的名称是【 servlet-name】-servlet.xml，所以如果你没有给servlet 制定配置文件的位置，并且在默认位置下也没有配置文件，那么系统启动的时候就会报错。\

# 强制UTF-8传输
web.xml中使用filter
```aidl
<filter-class>org.springframework.web.filter.CharacterEncodingFilter</filter-class>
        <init-param>
            <param-name>encoding</param-name>
            <param-value>UTF-8</param-value>
        </init-param>
```

# git
Preference->VersionControl->Git设置Path to Git executable:/usr/local/bin/git

Preference->VersionControl->GitHub:点击Create API Token输入用户名和密码，点击Test测试账户


