FROM ubuntu:18.04

RUN set -x && apt-get update && apt-get install -y \
    openssh-server \
    supervisor \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir /run/sshd

RUN { \
    echo '[program:sshd]'; \
    echo 'command=/usr/sbin/sshd -D'; \
    } | tee /etc/supervisor/conf.d/sshd.conf

RUN sed -i -e '/^\[supervisord\]$/a nodaemon=true' /etc/supervisor/supervisord.conf

CMD ["/usr/bin/supervisord"]
