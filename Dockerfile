FROM alpine:3.8

LABEL maintainer="NGINX Docker Maintainers <docker-maint@nginx.com>"

WORKDIR /data/app
RUN apk upgrade -U \
 && apk add ca-certificates ffmpeg libva-intel-driver 

RUN mkdir -p /data/app/hls

RUN addgroup -S www-data \
		&& adduser -D -S -h /var/cache/nginx -s /sbin/nologin -G www-data www-data

RUN apk update && apk upgrade && \
    apk add --no-cache bash git openssh \
		gcc \
		libc-dev \
		make \
		openssl-dev \
		pcre-dev \
		zlib-dev \
		linux-headers \
		curl \
		gnupg1 \
		libxslt-dev

RUN git clone https://github.com/arut/nginx-rtmp-module.git


RUN curl http://nginx.org/download/nginx-1.14.0.tar.gz --output nginx-1.14.0.tar.gz 
RUN tar -xf nginx-1.14.0.tar.gz
RUN cd nginx-1.14.0 && ./configure --prefix=/usr/share/nginx \
											 --sbin-path=/usr/sbin/nginx \
											 --conf-path=/etc/nginx/nginx.conf \
											 --pid-path=/var/run/nginx.pid \
											 --lock-path=/var/lock/nginx.lock \
											 --error-log-path=/var/log/nginx/error.log \
											 --http-log-path=/var/log/access.log \
											 --user=www-data --group=www-data \
											 --with-http_ssl_module \
											 --add-module=/data/app/nginx-rtmp-module
RUN cd nginx-1.14.0 && make -j 1 && make install


COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80
EXPOSE 1935

STOPSIGNAL SIGTERM

CMD ["nginx", "-g", "daemon off;"]
