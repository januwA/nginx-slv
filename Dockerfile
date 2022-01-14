FROM debian:bullseye

ENV NGINX_VERSION   1.21.5

WORKDIR /root

# 更新包
RUN apt update -y && apt upgrade -y 

# 安装基础开发包
RUN apt install build-essential wget curl unzip -y 
RUN apt install libpcre3-dev libssl-dev zlib1g-dev -y
RUN apt install ffmpeg -y

# 安装 nginx-rtmp-module
# RUN git clone https://github.com/arut/nginx-rtmp-module.git
COPY ./nginx-rtmp-module-master.zip ./
RUN unzip ./nginx-rtmp-module-master.zip && mv ./nginx-rtmp-module-master ./nginx-rtmp-module

# 安装 nginx
RUN wget https://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz
RUN tar -zxvf nginx-${NGINX_VERSION}.tar.gz
RUN mv ./nginx-${NGINX_VERSION} ./nginx

WORKDIR /root/nginx

RUN ./configure --with-pcre --prefix=/usr/local/nginx --sbin-path=/usr/sbin/nginx \
  --add-module=../nginx-rtmp-module \
  --with-http_ssl_module 
RUN make && make install

WORKDIR /root
RUN rm -rf ./*

WORKDIR /usr/local/nginx

EXPOSE 80 1935

COPY ./nginx.conf /usr/local/nginx/conf/nginx.conf
CMD ["nginx", "-g", "daemon off;"]

# nginx path prefix: "/usr/local/nginx"
# nginx binary file: "/usr/sbin/nginx"
# nginx modules path: "/usr/local/nginx/modules"
# nginx configuration prefix: "/usr/local/nginx/conf"
# nginx configuration file: "/usr/local/nginx/conf/nginx.conf"
# nginx pid file: "/usr/local/nginx/logs/nginx.pid"
# nginx error log file: "/usr/local/nginx/logs/error.log"
# nginx http access log file: "/usr/local/nginx/logs/access.log"
# nginx http client request body temporary files: "client_body_temp"
# nginx http proxy temporary files: "proxy_temp"
# nginx http fastcgi temporary files: "fastcgi_temp"
# nginx http uwsgi temporary files: "uwsgi_temp"
# nginx http scgi temporary files: "scgi_temp"