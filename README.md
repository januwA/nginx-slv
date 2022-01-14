## 生成镜像
```sh
$ docker build -t nginx-slv .
$ docker run -d -p 80:80 -p 1935:1935 --name=slv nginx-slv 
```

## 推流和拉流地址
```
rtmp://127.0.0.1/<app name>/<name>
rtmp://127.0.0.1/live/bbb
```

See also:
  - [video-streaming-for-remote-learning-with-nginx](https://www.nginx.com/blog/video-streaming-for-remote-learning-with-nginx/)
  - [nginx-rtmp-module](https://github.com/arut/nginx-rtmp-module)