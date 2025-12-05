FROM debian:bookworm

RUN apt-get update && apt-get install -y python3

RUN mkdir -p /etc/html
COPY ./resume.html /etc/html/resume.html

ENTRYPOINT [ "python3", "-m", "http.server", "-d", "/etc/html", "8081" ]
