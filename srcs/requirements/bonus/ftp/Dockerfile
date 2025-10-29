FROM debian:bookworm

RUN apt-get update && apt-get install vsftpd -y

COPY ./conf/vsftpd.conf /etc/vsftpd.conf
COPY ./tools/docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

EXPOSE 20 21 21100-21110

ENTRYPOINT [ "/usr/local/bin/docker-entrypoint.sh" ]
CMD [ "/usr/sbin/vsftpd", "-obackground=NO", "-olisten=YES", "/etc/vsftpd.conf" ]