FROM php:7.2-fpm

RUN apt-get update

RUN apt-get install -y \
  	openssl \
    libssl-dev \
    wget \
    inotify-tools

RUN cd /tmp && wget https://pecl.php.net/get/swoole-4.2.9.tgz && \
    tar zxvf swoole-4.2.9.tgz && \
    cd swoole-4.2.9  && \
    phpize  && \
    ./configure  --enable-openssl && \
    make && make install

RUN touch /usr/local/etc/php/conf.d/swoole.ini && \
    echo 'extension=swoole.so' > /usr/local/etc/php/conf.d/swoole.ini

WORKDIR /app

EXPOSE 8101
CMD ["/app/run.sh"]
# CMD ["/app/run.sh", "php index.php"]
