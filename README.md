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

如果需要设置网络代理，请在vimrc下添加如下代码：
<pre>
"代理设置
"是否启用代理设置，1表示启用，0表示不启用
let g:vbo_sina_weibo_proxy_enable = 1 
"HTTP代理地址，如果是url的形式则不需要协议方式直接写域名就行，例如：www.baidu.com
let g:vbo_sina_weibo_proxy_http_host = 'xx.xxx.xxx.xxx'
"HTTP代理端口
let g:vbo_sina_weibo_proxy_http_port = 80
"HTTPS代理地址
let g:vbo_sina_weibo_proxy_https_host = 'xx.xxx.x.xxx'
"HTTPS代理端口
let g:vbo_sina_weibo_proxy_https_port = 80
</pre>

如何使用
===

* 发送微博： `:WB 微博内容`

更新历史
===
* 2013-01-07  
增加代理设置支持
  
* 2013-01-06  
初始化应用程序，添加发送微博功能
