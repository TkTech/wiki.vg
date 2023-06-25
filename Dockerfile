FROM mediawiki:1.34

COPY LocalSettings.php /var/www/html/
COPY ./extensions/. /var/www/html/extensions/

ENV MW_MAX_UPLOAD_SIZE 10M

RUN echo "upload_max_filesize = $MW_MAX_UPLOAD_SIZE;" > /usr/local/etc/php/conf.d/uploads.ini
RUN echo "post_max_size = $MW_MAX_UPLOAD_SIZE;" >> /usr/local/etc/php/conf.d/uploads.ini

EXPOSE 80
