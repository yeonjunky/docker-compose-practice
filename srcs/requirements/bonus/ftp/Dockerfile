FROM debian:bookworm

RUN apt-get update && apt-get install vsftpd -y

COPY ./conf/vsftpd.conf /etc/vsftpd.conf
COPY ./tools/docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

RUN mkdir -p /var/run/vsftpd/empty

# according /etc/pam.d/vsftpd auth option, the user's shell must be listed in /etc/shells
# otherwise the login attempt will fail. 
RUN echo '/usr/sbin/nologin' >> /etc/shells

EXPOSE 20 21 21100-21110

ENTRYPOINT [ "/usr/local/bin/docker-entrypoint.sh" ]
CMD [ "/usr/sbin/vsftpd", "-obackground=NO", "-olisten=YES", "/etc/vsftpd.conf" ]
