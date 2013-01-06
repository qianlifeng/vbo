vbo介绍
===

vbo是一款基于的vim的新浪微博插件，利用vbo你可以在vim下进行新浪微博的的发送，查看等功能。


配置账户
===

下载插件后，在vbo.vim文件中（位于plugin文件夹下面） 的13,14行设置微博账户信息:
<pre>
let g:vbo_sina_weibo_user = 'YOUR ACCOUNT'
let g:vbo_sina_weibo_password = 'PASSWORD'
</pre>

如何使用
===

* 发送微博： `:WB 微博内容`

更新历史
===
* 2013-01-06  
初始化应用程序，添加发送微博功能
