#!/bin/sh

# list of packages or modules, separated by spaces
LIST_OF_APPS="openssh_server zip openssh_client apache2 make members libapache2-mod-evasive"

aptitude update
aptitude install -y $LIST_OF_APPS

# creates log dir for apache mod-evasive, give it apache permissions
mkdir /var/log/mod_evasive
chown www-data:www-data /var/log/mod_evasive

# change index.html from default apache2 page to IT240 home
