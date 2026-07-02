# Sử dụng môi trường PHP 8.2 có sẵn máy chủ Apache
FROM php:8.2-apache

# Cài đặt công cụ kết nối Database và tiện ích curl phục vụ Healthcheck
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/* \
    && docker-php-ext-install mysqli pdo pdo_mysql

# Bật URL Rewrite cho mô hình MVC và cấu hình AllowOverride All cho Apache .htaccess
RUN a2enmod rewrite \
    && sed -ri -e 's!AllowOverride None!AllowOverride All!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

# Cấu hình thư mục làm việc
WORKDIR /var/www/html

# Copy toàn bộ code vào trong thư mục web_qlsp
COPY . /var/www/html/web_qlsp/

# Tự động chuyển hướng từ trang chủ vào /web_qlsp/
RUN echo "RedirectMatch ^/$ /web_qlsp/" > /etc/apache2/conf-available/redirect.conf \
    && a2enconf redirect

# Cấp quyền sở hữu và phân quyền bảo mật (755 cho thư mục, 644 cho file)
RUN chown -R www-data:www-data /var/www/html/web_qlsp/ \
    && find /var/www/html/web_qlsp/ -type d -exec chmod 755 {} \; \
    && find /var/www/html/web_qlsp/ -type f -exec chmod 644 {} \;

# Thêm bộ kiểm tra sức khỏe container (HEALTHCHECK)
HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
  CMD curl -f http://localhost/web_qlsp/ || exit 1

# Mở cổng 80 cho web hoạt động
EXPOSE 80