if ! id "ftpuser" >/dev/null &2>1; then
    adduser ftpuser
    chown -R ftpuser:ftpuser /var/www/html
fi
