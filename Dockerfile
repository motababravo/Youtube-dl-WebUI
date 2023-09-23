FROM debian

RUN apt-get update && apt-get -y install apt-transport-https wget lsb-release ca-certificates
RUN wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
RUN echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list

RUN apt-get update && apt-get install -y --no-install-recommends\
    git python3 ffmpeg apache2 php5.6 curl ca-certificates
RUN rm -rf /var/lib/apt/lists/*

#Install youtube-dl
RUN curl -L -o /usr/local/bin/youtube-dl https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp && chmod a+x /usr/local/bin/youtube-dl

#WORKDIR /
#RUN mkdir /var/www

WORKDIR /var/www/html/
RUN git clone https://github.com/motababravo/Youtube-dl-WebUI.git youtube-dl

WORKDIR /www/youtube-dl
RUN rm -rf .git README.md img .gitignore docker

WORKDIR /
RUN chmod -R 755 /var/www && chown -R www-data:www-data /var/www

COPY ./docker/vhost.conf /etc/apache2/conf.d/extra/vhost.conf

RUN ln -sf /dev/stdout /var/log/apache2/youtube-dl_access.log
RUN ln -sf /dev/stderr /var/log/apache2/youtube-dl_error.log

EXPOSE 80

VOLUME /www/youtube-dl/downloads

CMD /usr/sbin/apache2ctl -D FOREGROUND
