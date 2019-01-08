# RailsChat 

RailsChat是一款由Rails开发的实时Web聊天室，在[Render_sync](https://github.com/chrismccord/render_sync)的基础上完成，有需要即时通讯的应用可以考虑这个Example

## Online Demo

请点击[这里](http://140.143.79.172:3000/)访问Demo，测试用户登陆账号格式为：

```
username: user<number>@test.com
password: password
```

* 其中number为1到100，代表100个用户，例如使用`user1@test.com`和`password`能登陆用户1，以此类推

Note：请用两个浏览器分别登陆不同的用户来测试消息的即使推送，注意这两个用户需要互为好友

## 目前功能

* 聊天室消息即时推送
* 支持查找，添加，删除好友
* 创建私人聊天，也支持多人聊天
* 房主可以拉人，踢人
* 房主能转移房屋权限
* 机器人聊天
* 用户资料查看与修改
* 新建用户

## Todo

1. 现在的即时推送只限于聊天的消息，其他的推送比如未读信息提醒（包括声音）等还未涉及
2. 添加好友需要对方同意，现在是单方面添加
3. UI界面修改（类似WeChat）
4. 管理后台开发

## Usage 

下面是Rails和Ruby的相关博客，用于快速上手这个项目：

[Ruby快速建站入门---Rails基础](http://blog.leanote.com/post/454858191@qq.com/Ruby%E5%BF%AB%E9%80%9F%E5%BB%BA%E7%AB%99%E5%85%A5%E9%97%A8-Rails%E5%9F%BA%E7%A1%80)

[Ruby快速建站入门---Ruby基础](http://blog.leanote.com/post/454858191@qq.com/Ruby%E5%BF%AB%E9%80%9F%E5%85%A5%E9%97%A8)

1. Fork项目

```shell
git clone https://github.com/your_user_name/RailsChat
```

2. 搭建环境

```shell
cd RailsChat

# 安装依赖
bundle install

# 初始化数据库
./init_db.sh
```

3. 运行网页服务器

```shell
rails server
```

4. 然后再打开另外一个终端，运行以下命令启动另外一个server来监听聊天室的用户并实时推送最新的消息：

```shell
rackup sync.ru -E production
```

### Note：如果要部署到云上或者本地局域网内，需要修改`config/sync.yml`文件

以本地局域网为例：

1. 若本机的ip地址为192.168.0.14（使用`ifconfig`查看），那么需要将config/sync.yml中的localhost全改为此ip地址，例如

 ```
  development:
    server: "http://192.168.0.14:9292/faye"
    adapter_javascript_url: "http://192.168.0.14:9292/faye/faye.js"
    auth_token:  "97c42058e1466902d5adfac0f83e84c1794b9c3390e3b0824be9db8344eae82b"
    adapter: "Faye"
    async: true
    
  test:
    ...
  production:
    ...
 ```

2. 然后运行rake tmp:clear来清除缓存，不然修改不会生效（运行前先将所有相关的运行停止：如rails s,rackup sync.ru等）

3. 再次运行rails服务器和监听程序，并指定监听程序运行的ip地址

  ```
  rails s
  bundle exec rackup sync.ru -E production --host 192.168.0.14 
  ```

### Tips:

1. 在服务器中可以后台运行rack：`bundle exec rackup sync.ru -E production --host 192.168.0.14 -D`
2. 若要关闭在后台运行的rackup，请使用`ps ax | grep ruby`查找相关ruby端口，然后用`kill －9 <pid>`结束正在运行的rackup，如：

```
21099 ?        Sl     0:00 /var/www/railschat/RailsChat/vendor/bundle/ruby/2.3.0/bin/rackup                                    
21105 pts/4    S+     0:00 grep --color=auto ruby
```




## Debug

1. 当遇到消息并没有实时推送的情况时，先F12查看浏览器的Js文件加载情况，若faye.js加载成功则一般不会出现问题

2. 以上加载完成但是仍然没有推送的时候，请查看Rails服务器的log文件

3. 需要在两个浏览器中登录不同的账号来检验聊天室功能


## 截图

<img src="/lib/Snip20170301_2.png">

<img src="/lib/Snip20170301_3.png">

<img src="/lib/Snip20170301_4.png">

<img src="/lib/Snip20170301_5.png">



**如果觉得好，请给项目点颗星来支持吧～～** 

有什么好的建议，请在issue中提出，欢迎contributors！


## 大喵想说的话

在写关于这个项目之前，有几句话说——
我可能会写很多超级简单的东西，但是确实是我遇到的问题（因为我本身是跨专业过来计算机的，很多领域知识不知道），希望对ruby on rails开发中前端部分的你有帮助，接下来正式开始吧。
在开发前你一定要根据自己的电脑配置选择一个好的编辑器，我使用的是rubymine，然而太卡最后我放弃了，我是在Ubuntu 16.04 下使用的。
在rails开发中它的前端有一种属于它的语法，同时我们熟知的CSS也变为后缀SCSS的文件，javascript变为后缀为coffee的文件，同时他们的语法也有了变化，这些你可以通过网上资源学习或去官网找教程，但是你也不用担心，因为它同时还是可以用CSS和JS文件的，这时你不必按照它的标准，直接放入CSS和JS也可以使用。
在放入之后你使用

```html
<link rel="stylesheet" href="css/hua.css">，
<script type="text/javascript" src="js/hua.js">
```

这两个语句是无法让你的CSS和JS起作用的，你需要在你的项目目录下找到app/assets/下找到stylesheets和javascripts文件夹，里边存放着整个项目的CSS和JS文件，在这两个文件夹下都会有文件名为application的文件，打开后你可按照已有的链接方法把你的文件链接进去，保存之后你的CSS和JS就可以直接起作用了，不必要其他语法。
那么接下来是前端最关心的界面了，在ruby on rails页面的后缀为html.erb，你可以在app/views/下找到对应的界面，如果你要增加一个新的页面或者想搞个页面测试一下效果，那么你首先需要有route和action，不然会直接报错。
第一步，新建自己的controller或在别人的controller中添加action在config文件夹下找到routes.rb文件，加入action对应的路由，加入后你可以通过命令rake routes输出当前所有路由查看自己是否成功加入。如何添加属于ruby知识，可以百度自行学习。
若你是新建controller，那么你的views文件下会自动生成相同名字的erb文件，你在里边编辑前端代码就好。
否则自行添加，注意文件的位置。
在聊天机器人项目中我主要新增了robot_chat下的三个界面，修改了homes界面，以及模态框的使用（控制点击后界面弹出，比如注册界面登录界面等），界面中很多布局设计等等都是通过网页源码copy的，你可以逐步调试看看div对应的界面，需要耐心去熟悉。
至于界面的书写就看个人功底了，此外你需要知道这个项目中每个分为header+界面两个部分，即你看到的每个页面header都是最上边的黑条部分，也就是显示chatroom,logout,用户名的那一部分，这个你需要在views 中的layouts下找到命名为header的erb去修改，然后网页的其他部分才是你编辑的controller对应的erb文件。
接下来是前端另一个重要的部分——js，由于我在配置环境以及学习ruby方面花费很多时间，所以JS是另一个人写的，你可以打开项目中JS文件自行学习。但是你要回使用JS文件中的东西，其中有一个功能测试界面，可以通过http://localhost:3000/tests去访问。
最后关于前端部分的建议：如果你是个像我一样的小白，那么你一定要厚脸皮向小组的大神请教，即便大神百般虐你，那也是为了让你学到更多知识，你要忍，要多么注意团队合作，团队沟通。
