FROM alpine:latest
LABEL maintainer: xml@live.com
ENV NGINX_VER=1.17.6
RUN mkdir nginx && \
	cd tmp && \
	apk update && \
	apk add --no-cache ffmpeg pcre-dev bash && \
	apk add --no-cache --virtual .git git && \
	wget http://nginx.org/download/nginx-$NGINX_VER.tar.gz && \
	tar -xzf nginx-$NGINX_VER.tar.gz && \
	git clone https://github.com/winshining/nginx-http-flv-module.git && \
	apk add --no-cache --virtual .buildenv gcc libc-dev make linux-headers \
	openssl-dev zlib-dev && \
	cd nginx-$NGINX_VER && \
	./configure --prefix=/nginx --with-http_ssl_module --add-module=../nginx-http-flv-module && \
	make && \
	make install && \
	cd /nginx && \
	rm -r /tmp/* && \
	apk del .git && \
	apk del .buildenv && \
	rm conf/nginx.conf && \
	cd html && \
	mkdir hls hls/transcode dash dash/transcode vod record
WORKDIR /nginx
COPY conf/* ./conf/
COPY html/* ./html/
COPY start.sh .
RUN chmod +x ./start.sh
EXPOSE 80
EXPOSE 1935
VOLUME [ "/nginx" ]
CMD ["bash", "/nginx/start.sh"]