FROM alpine:latest
ENV NGINX_VER=1.17.6
RUN mkdir nginx && \
	cd tmp && \
	apk update && \
	apk add --no-cache --virtual .git git && \
	wget http://nginx.org/download/nginx-$NGINX_VER.tar.gz && \
	tar -xzf nginx-$NGINX_VER.tar.gz && \
	git clone https://github.com/winshining/nginx-http-flv-module.git && \
	apk add --no-cache --virtual .buildenv gcc libc-dev make linux-headers \
	bash openssl-dev pcre-dev zlib-dev && \
	cd nginx-$NGINX_VER && \
	./configure --prefix=/nginx --with-http_ssl_module --add-module=../nginx-http-flv-module && \
	make && \
	make install && \
	apk add --no-cache --virtual .ffmpeg ffmpeg && \
	cd / && \
	rm -r /tmp/* && \
	apk del .git && \
	apk del .buildenv

EXPOSE 80
EXPOSE 1935
VOLUME [ "/nginx" ]
CMD ["/nginx/sbin/nginx", "-c", "/nginx/conf/nginx.conf"]