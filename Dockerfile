FROM centos:centos7

MAINTAINER Marian Sievers

# Do some preparation
RUN yum install -y wget
RUN yum install -y epel-release

#####################
### Install nginx ###
#####################

# Install nginx
# TODO: version pinning?
RUN yum install -y nginx

# Add config
ADD conf/default.conf /etc/nginx/conf.d/default.conf

# Expose volumes
VOLUME ["/var/www", "/etc/nginx/conf.d"]

# Expose http-port
EXPOSE 80

# Run nginx
CMD ["nginx", "-g", "daemon off;"]

####################
### Install hhvm ###
####################

# Add hhvm repo
RUN wget https://copr.fedoraproject.org/coprs/no1youknowz/hhvm-repo/repo/epel-7/no1youknowz-hhvm-repo-epel-7.repo -O /etc/yum.repos.d/no1youknowz-hhvm-repo-epel-7.repo

# Install hhvm
# TODO: version pinning?
RUN yum install -y hhvm


# Do some cleanup

# Clean up YUM when done.
RUN yum clean all
