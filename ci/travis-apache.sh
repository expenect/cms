#!/bin/sh

# enable php-fpm
sudo cp ~/.phpenv/versions/$(phpenv version-name)/etc/php-fpm.conf.default ~/.phpenv/versions/$(phpenv version-name)/etc/php-fpm.conf
sudo a2enmod rewrite actions fastcgi alias
echo "cgi.fix_pathinfo = 1" >> ~/.phpenv/versions/$(phpenv version-name)/etc/php.ini
~/.phpenv/versions/$(phpenv version-name)/sbin/php-fpm

# configure apache virtual hosts
sudo cp -f ci/travis-apache-vhost /etc/apache2/sites-available/default
sudo sed -e "s?%TRAVIS_BUILD_DIR%?$(pwd)?g" --in-place /etc/apache2/sites-available/default

# set application environment variable
sudo sed -e "s?%APPLICATION_ENV%?$APPLICATION_ENV?g" --in-place /etc/apache2/sites-available/default
sudo cat /etc/apache2/sites-available/default

# restart apache
sudo service apache2 restart