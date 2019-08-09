FROM centos
MAINTAINER hoo
ENV REFRESHED_AT 2018-11-19

# put nginx-1.12.0 into /usr/local/nginx and unpack nginx
RUN mkdir -p /usr/local/nginx
ADD nginx-1.12.0 /usr/local/nginx

# running required command
RUN rpm -ivh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
#RUN rpm -ivh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm
RUN yum install -y gcc gcc-c++ glibc make autoconf openssl openssl-devel 
RUN yum install -y libxslt-devel -y gd gd-devel GeoIP GeoIP-devel pcre pcre-devel zlib zlib-devel supervisor
RUN rm -rf /var/lib/yum/history/*.sqlite &&\
rm -rf /var/cache/yum
RUN useradd -M -s /sbin/nologin nginx

# change dir to /usr/local/nginx
WORKDIR /usr/local/nginx

# execute command to compile nginx
RUN ./configure --user=nginx --group=nginx --prefix=/usr/local/nginx --conf-path=/usr/local/nginx/nginx.conf --with-file-aio --with-http_ssl_module --with-http_realip_module --with-http_addition_module --with-http_xslt_module --with-http_image_filter_module --with-http_geoip_module --with-http_sub_module --with-http_dav_module --with-http_flv_module --with-http_mp4_module --with-http_gunzip_module --with-http_gzip_static_module --with-http_auth_request_module --with-http_random_index_module --with-http_secure_link_module --with-http_degradation_module --with-http_stub_status_module && make && make install

EXPOSE 8888
#COPY nginx.conf /usr/local/nginx/conf/
#ENTRYPOINT ["/usr/local/nginx/sbin/nginx","run"]
