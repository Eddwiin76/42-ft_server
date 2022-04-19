FROM debian:buster
MAINTAINER ft_server
COPY srcs/script.sh /usr/bin/
RUN chmod 755 /usr/bin/script.sh
COPY srcs/* ./tmp/
CMD [ "script.sh" ]
