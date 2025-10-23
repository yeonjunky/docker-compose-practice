FROM debian:bookworm

RUN apt-get update && apt-get install -y nginx openssl

RUN mkdir /root/.tls

# genrsa generate private key
# 2048 key length
# the output writes in server.key
RUN openssl genrsa -out /root/.tls/server.key

RUN openssl req -new \
	-newkey rsa:2048 -nodes \
	-keyout /root/.tls/server.key \
	-out /root/.tls/server.csr \
	-subj "/C=KR/ST=Gyeongsan/L=42/O=42/CN=yeonjuki.42.fr" \
	-addext "subjectAltName=DNS:yeonjuki.42.fr"

RUN openssl x509 -req \
	-in /root/.tls/server.csr \
	-signkey /root/.tls/server.key \
	-out /root/.tls/server.crt \
	-days 365

COPY ./conf/nginx.conf /etc/nginx/nginx.conf

WORKDIR /var/www/html

EXPOSE 80 443

ENTRYPOINT [ "nginx", "-g", "daemon off;" ]
