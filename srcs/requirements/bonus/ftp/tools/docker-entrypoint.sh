#!/bin/bash

set -e

if ! id "${FTP_USER}" >/dev/null 2>&1; then
    useradd -m -d /var/www/html -s /usr/sbin/nologin "${FTP_USER}"
    chown -R "${FTP_USER}":"${FTP_USER}" /var/www/html
    echo "${FTP_USER}:${FTP_PASS}" | chpasswd
fi

if ! ls /etc/vsftpd.userlist >/dev/null 2>&1; then
    touch /etc/vsftpd.userlist
    echo "${FTP_USER}" > /etc/vsftpd.userlist
fi

exec "$@"
