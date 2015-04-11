FROM centos:centos7

MAINTAINER Marian Sievers

# Install nginx
RUN yum install -y epel-release
RUN yum install -y nginx

# Clean up YUM when done.
RUN yum clean all

# Add config
ADD conf/default.conf /etc/nginx/conf.d/default.conf

# Expose volumes
VOLUME ["/var/www", "/etc/nginx/conf.d"]

# Expose http-port
EXPOSE 80

# Run nginx
CMD ["nginx", "-g", "daemon off;"]


# ------------------------------------------------------------------------------
# Install packages
#RUN apt-get update
#RUN apt-get install -y php5-fpm
#RUN apt-get install -y supervisor curl wget php5-mysql php5-mcrypt php5-gd php5-memcached php5-curl php5-xdebug
# php5-fpm

# Install HHVM
#RUN wget -O - http://dl.hhvm.com/conf/hhvm.gpg.key | apt-key add -
#RUN echo deb http://dl.hhvm.com/ubuntu trusty main | tee /etc/apt/sources.list.d/hhvm.list
#RUN apt-get update
#RUN apt-get install -y hhvm

# Create required directories
#RUN mkdir -p /var/log/supervisor
#RUN mkdir -p /etc/nginx
#RUN mkdir -p /var/run/php5-fpm
#RUN mkdir -p /var/run/hhvm

# Add configuration files
#ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
#ADD php.ini /etc/php5/fpm/conf.d/40-custom.ini

# Expose volumes
#VOLUME ["/var/www", "/etc/nginx/sites-enabled"]

#EXPOSE 80 9000

#CMD ["/usr/bin/supervisord"]
