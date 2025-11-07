FROM debian:bookworm

RUN apt-get update && apt-get install -y ngircd

COPY ./conf/ngircd.conf /etc/ngircd/ngircd.conf

EXPOSE 6667
CMD [ "/usr/sbin/ngircd", "-n", "-f", "/etc/ngircd/ngircd.conf" ]