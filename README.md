### jfinal-admin 后台框架 
jfinal-admin 是基于JFinal的后台管理系统，采用了简洁强大的JFinal作为web框架，模板引擎用的是beetl，数据库用mysql，前端bootstrap框架。

### 特性
1. 内置用户和权限系统
2. mysql、oracle等多数据库支持
3. 支持引入第三方前端库
4. 基于jfinal_cms深度精简

### 其他
jfinal_cms深度精简，不再依赖jflyfox_base，jflyfox_jfinal。

### 效果截图
![输入图片说明](http://static.oschina.net/uploads/img/201601/28091447_rQtD.gif "在这里输入图片标题")
### 配置说明
- 数据库连接配置 修改pom.xml
```
<profiles>

        <profile>

            <id>develop</id>

            <activation>

                <activeByDefault>true</activeByDefault>

            </activation>

            <properties>

                <jdbc-url>
                    <![CDATA[jdbc:mysql://127.0.0.1:3306/jfinal_job?useUnicode=true&characterEncoding=utf-8&zeroDateTimeBehavior=convertToNull]]></jdbc-url>

                <jdbc-username>root</jdbc-username>

                <jdbc-password>123456</jdbc-password>

            </properties>

        </profile>

    </profiles>
```
- 登录系统账号 admin/123456

### 鸣谢
- [JFinal](http://www.oschina.net/p/jfinal)

- [beetl](http://ibeetl.com/)

- [flyfox](http://git.oschina.net/flyfox)

### 关于作者
- IT小香猪



    
