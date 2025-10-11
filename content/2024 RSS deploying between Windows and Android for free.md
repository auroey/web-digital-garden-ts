---
title: 2024 RSS deploying between Windows and Android for free
date: 2024-08-21
summary: 美观 | 全免费 | 开源 | 多平台 | 无建站 | 数据可迁移 | 无需编程基础 | Win和安卓 | RSSHub + FluentReader + FreshRSS
---
效果图

![image.png](https://kennels.oss-cn-beijing.aliyuncs.com/img_for_typora/202510112139673.png)


## 步骤 1：安装 Docker

- 访问 [Docker Desktop](https://www.docker.com/products/docker-desktop/) 网站，按照操作系统的要求下载并安装 Docker Desktop。

![image.png](https://kennels.oss-cn-beijing.aliyuncs.com/img_for_typora/202510112140756.png)


## 步骤 2：配置 RSSHub

- 在任意位置新建一个名字任意的文件夹，在其内新建`docker-compose.yml`文件，内容如下：

```yaml
version: '3.9'

services:
    rsshub:
        image: diygod/rsshub
        restart: always
        ports:
            - '1200:1200'
        environment:
            NODE_ENV: production
            CACHE_TYPE: redis
            REDIS_URL: 'redis://redis:6379/'
        depends_on:
            - redis

    redis:
        image: redis:alpine
        restart: always
        volumes:
            - redis-data:/data

volumes:
    redis-data:
```

![image.png](https://kennels.oss-cn-beijing.aliyuncs.com/img_for_typora/202510112140328.png)


![image.png](https://kennels.oss-cn-beijing.aliyuncs.com/img_for_typora/202510112140403.png)


按win+R，输入cmd，在新窗口中输入：

```vbnet
docker-compose up -d
```

访问[Welcome to RSSHub!](http://127.0.0.1:1200)网站，确保 RSSHub 已经成功启动。

![image.png](https://kennels.oss-cn-beijing.aliyuncs.com/img_for_typora/202510112140400.png)


## 步骤 3：配置 FreshRSS

再找任意位置新建一个名字任意的文件夹，在其内新建同样名为`docker-compose.yml`的文件，内容如下：

```vbnet
version: '3'
services:
  freshrss:
    image: freshrss/freshrss
    container_name: freshrss
    restart:  always
    ports:
      - "8080:80"
    environment:
      TZ: 'Asia/Shanghai'
      CRON_MIN: 1,31
    volumes:
      - freshrss_data:/var/www/FreshRSS/data
      - freshrss_extensions:/var/www/FreshRSS/extensions
volumes:
  freshrss_data:
  freshrss_extensions:
```

按win+R，输入cmd，在新窗口中输入：

![image.png](https://kennels.oss-cn-beijing.aliyuncs.com/img_for_typora/202510112140087.png)


![image.png](https://kennels.oss-cn-beijing.aliyuncs.com/img_for_typora/202510112140647.png)


```vbnet
docker-compose up -d
```

访问[登录 · FreshRSS](http://127.0.0.1:8080)，点下一步下一步下一步，步骤四的用户名和密码按自己习惯来，然后登录

![image.png](https://kennels.oss-cn-beijing.aliyuncs.com/img_for_typora/202510112140343.png)


## 步骤 4：配置 FreshRSS API

- 登录 FreshRSS 后，删除默认的 RSS 源。
- 点击右上角进入认证页面，在认证页面中启用 “允许 API 访问”。
- 再点击账户页面设置 API 密码，然后点击 API 密码下方的链接查看，两个都为 `PASS` 即为成功。确保 Google Reader compatible API 的 Your API address 下面的一行 `http://xxxxxxx.php` 地址可以正常访问。

![image.png](https://kennels.oss-cn-beijing.aliyuncs.com/img_for_typora/202510112140828.png)


![image.png](https://kennels.oss-cn-beijing.aliyuncs.com/img_for_typora/202510112140230.png)


![image.png](https://kennels.oss-cn-beijing.aliyuncs.com/img_for_typora/202510112140701.png)


![image.png](https://kennels.oss-cn-beijing.aliyuncs.com/img_for_typora/202510112140195.png)


![image.png](https://kennels.oss-cn-beijing.aliyuncs.com/img_for_typora/202510112141926.png)


## 步骤 5：下载和配置 RSS 插件

- **下载 RSSHub Radar 插件**:
    
    - 大部分网页使用 [RSSHub Radar](https://chrome.google.com/webstore/detail/kefjpfngnndepjbopdmoebkipbgkggaa) 插件，下载并安装该插件。
    - 在插件设置中，下拉找到 FreshRSS，启用，并输入 `http://127.0.0.1:8080`。
    - 点开一个页面用于测试，例如[Zoet’ Blog | Are you there?](https://blog-two-chi-99.vercel.app/)，利用插件获取RSS，导入到FreshRSS中
    
    ![image.png](https://kennels.oss-cn-beijing.aliyuncs.com/img_for_typora/202510112141501.png)

    

![image.png](https://kennels.oss-cn-beijing.aliyuncs.com/img_for_typora/202510112141801.png)


![image.png](https://kennels.oss-cn-beijing.aliyuncs.com/img_for_typora/202510112141964.png)


- **（进阶，可选）下载推特专用 RSS 插件**:
    - 使用 [RSS Feed Generator](https://rss.app/myfeeds) 生成推特的 RSS 源。

## 步骤 6：配置同步

- **电脑端配置 Fluent Reader**:
    
    - 访问 [Fluent Reader](https://hyliu.me/fluent-reader/) 页面拉到底，下载并安装 Windows 版本的 Fluent Reader。
    - 下载后打开Fluent Reader的设置，点击Google Reader API
    - 在 Google Reader API 中，端点就设置为上文中的 `http://xxxxxxx.php`，用户名和密码按照前面设置的 API 账号填写，密码是**API 密码**，然后确认。
    
    ![image.png](https://kennels.oss-cn-beijing.aliyuncs.com/img_for_typora/202510112141267.png)

    

![image.png](https://kennels.oss-cn-beijing.aliyuncs.com/img_for_typora/202510112141205.png)


![image.png](https://kennels.oss-cn-beijing.aliyuncs.com/img_for_typora/202510112141340.png)


- **手机端配置 Fluent Reader Lite**:
    - 下载并安装 [Fluent Reader Lite](https://github.com/yang991178/fluent-reader-lite/releases/download/v1.0.4%2B11/fluent_reader_lite_1.0.4+11.apk)。
    - 打开手机热点，让电脑连接
    - 按win+R，输入cmd，在新窗口中输入 `ipconfig`，找到 IPv4 Address 后面的数字（如 xxx.xxx.xx.xx）。
    - 将先前电脑端配置用到的 `http://xxx.xxx.xx.xx:8080/api/greader.php`里的xx替换为上一步IPv4 Address 后面的数字，作为手机阅读软件的端点。
    - 其他配置与电脑端一样。

![image.png](https://kennels.oss-cn-beijing.aliyuncs.com/img_for_typora/202510112141242.png)


![image.png](https://kennels.oss-cn-beijing.aliyuncs.com/img_for_typora/202510112141537.png)


## 参考

[zhuanlan.zhihu.com/p/683851138](https://zhuanlan.zhihu.com/p/683851138)




# 付费版

刚才写了个全平台服务器RSS配置细致的指南，重启时typora忘保存了。。

直接补个纯文字的简易版吧，这次会有阅读门槛（因为懒得写太细了），推荐先看我上一篇文章。

先买服务器，腾讯云，带docker的

然后按照官方docker教程下载docker和docker compose，报错的话就在info前面加sudo提高权限。

环境配好后先配freshrss，nano后复制以下内容：

```
services:
  freshrss:
    image: freshrss/freshrss
    container_name: freshrss
    restart: always
    ports:
      - "8080:80"
    environment:
      TZ: 'Asia/Shanghai'
      CRON_MIN: 1,31
    volumes:
      - freshrss_data:/var/www/FreshRSS/data
      - freshrss_extensions:/var/www/FreshRSS/extensions

volumes:
  freshrss_data:
  freshrss_extensions:

```

然后sudo docker compose up -d

然后访问http://`ip`:8080/。导入先前的配置

再配置rsshub，nano后文件里放

```
services:
    rsshub:
        image: diygod/rsshub
        restart: always
        ports:
            - '1200:1200'
        environment:
            NODE_ENV: production
            CACHE_TYPE: redis
            REDIS_URL: 'redis://redis:6379/'
            BILIBILI_COOKIE_2267573: 'SESSDATA=be4111b1%2C1739880980%2C85d52%2A81CjAI3X3vp_RT5YrEsx27DoUj8g64OKBYZt2Hltvf5ImdKcv2a-xmmlV0wWAlcLy2POoSVkdSZkh4TmswTXdORDhRRG9mbFNfT0phYXk0SUNPcHFDcFdWRzJfOVh5SkZQS01SZGsydHBKM3VJak1OUEJmYzE2dXdJd0N3cmdfQW51VjhTeHpEZmJnIIEC; bili_jct=fe96c2b656b03f0fa0861e3704d7ab70; sid=845bp5jo'
            YOUTUBE_KEY: 'AIzaSyBIcc8FSF1bDoHtSJir27_JwnuHF3g-NlE'
            TWITTER_AUTH_TOKEN: 'AAAAAAAAAAAAAAAAAAAAANRILgAAAAAAnNwIzUejRCOuH5E6I8xnZz4puTs%3D1Zv7ttfk8LF81IUq16cHjhLTvJu4FA33AGWWjCpTnA'
        depends_on:
            - redis

    redis:
        image: redis:alpine
        restart: always
        volumes:
            - redis-data:/data

volumes:
    redis-data:

```

up后修改插件option，

RSSHub instance：[http://ip:1200](http://ip:1200)

FreshRSS: [http://ip:8080](http://ip:8080)

然后各端同步，over