FROM debian:9

EXPOSE 24/tcp 143/tcp 993/tcp

VOLUME /var/log/dovecot
VOLUME /ssl
VOLUME /vmail

RUN apt-get update -q -q && \
    DEBIAN_FRONTEND=noninteractive apt-get --yes install dovecot-sieve dovecot-mysql dovecot-managesieved dovecot-imapd dovecot-lmtpd

RUN groupadd -g 5000 vmail
RUN useradd -m -d /var/vmail -s /bin/false -u 5000 -g vmail vmail

RUN apt-get --yes install daemontools

ADD etc/ /etc/
ADD entrypoint.sh /entrypoint.sh

CMD ["/entrypoint.sh"]
