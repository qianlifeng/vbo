"避免重复加载插件
if exists('g:loaded_vbo')
    finish
endif
let g:loaded_vbo = 1

if !exists('g:vbo_code')
    echoerr 'please config g:sina_weibo_code'
    finis
endif

" 新浪分配给vimer.cn的appid，用户不需要变更
let s:sina_weibo_app_key = '979722265'
let s:sina_weibo_app_secret = '0e4819d558049bb037cffb3a3bcf0a86'
let s:sina_weibo_app_callback = 'http://sipaizhao.de'

let s:sina_weibo_url_get_openid = 'https://api.weibo.com/oauth2/access_token'
let s:sina_weibo_url_add_t = 'https://api.weibo.com/2/statuses/update.json'

python << EOF
import httplib
import urllib
import urlparse
import re
import json
import vim

def https_send(ip, url_path, params, method='GET'):
    ec_params = urllib.urlencode(params)

    conn = httplib.HTTPSConnection(ip)

    method = method.upper()

    if method == 'GET':
        url = '%s?%s' % (url_path, ec_params)
        conn.request(method, url)
    else:
        headers = {
            'Content-Type': 'application/x-www-form-urlencoded'
        }
        conn.request(method, url_path, ec_params, headers)

    rsp = conn.getresponse()

    if rsp.status != 200:
        raise ValueError, 'status:%d' % rsp.status
    data = rsp.read()

    return data

class Weibo():
    def __init__(self):
        try:
            self.access_token = self.api_get_openid(vim.eval('g:sina_weibo_code'))
        except Exception, e:
            print 'exception occur.msg[%s], traceback[%s]' % (str(e), __import__('traceback').format_exc())
            print 'access_token无效或者过期、网络有问题'
            return

    def api_get_openid(self, code):
        params = {
            'code': code,
            'client_id': vim.eval('s:sina_weibo_app_key'),
            'client_secret': vim.eval('s:sina_weibo_app_secret'),
            'grant_type': 'authorization_code',
            'redirect_uri':  vim.eval('s:sina_weibo_app_callback')
        }
        url_parts = urlparse.urlparse(vim.eval('s:sina_weibo_url_get_openid'))
        data = https_send(url_parts.netloc, url_parts.path, params, 'POST')
        jdata = json.loads(data)
        return jdata['access_token']

    def api_add_t(self, content):
        params = {
            'access_token': self.access_token,
            'status': content,
        }
        url_parts = urlparse.urlparse(vim.eval('s:sina_weibo_url_add_t'))
        data = https_send(url_parts.netloc, url_parts.path, params, 'POST')
        jdata = json.loads(data)
        return jdata

    def handle_add_t(self, content):
        try:
            jdata = self.api_add_t(content)
        except Exception, e:
            print 'exception occur.msg[%s], traceback[%s]' % (str(e), __import__('traceback').format_exc())
            print '发表失败! 可能原因为: 网络有问题'
            return

        if jdata['id']:
            print '发表成功!'
        else:
            print '发表失败! ret:%d, error:%s' % (jdata['error_code'], jdata['error'])

weibo = Weibo()
EOF

function! s:AddT(content)
python<<EOF
all_content = vim.eval('a:content')
weibo.handle_add_t(all_content)
EOF

endfunction

command! -nargs=1 -range AddT :call s:AddT(<f-args>)

vnoremap ,at "ty:AddT <C-R>t
nnoremap ,at :AddT

