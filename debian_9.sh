#!/bin/bash

apt-get update;
apt-get upgrade -y;

#Install packages and dependencies
apt-get install -y curl python-dev python-pip git nikto nmap golang libunwind8 gettext apt-transport-https apache2 dnsutils telnet proxychains zip p7zip libffi-dev libssl-dev dirmngr;

#Install Java 8
echo 'deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main' >> /etc/apt/sources.list.d/java-8-debian.list;
echo 'deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main' >> /etc/apt/sources.list.d/java-8-debian.list;
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886;
apt-get update;
apt-get install oracle-java8-installer;

#Install dotnet
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg;
mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg;
echo 'deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-debian-stretch-prod stretch main' >> /etc/apt/sources.list;

apt-get update;
apt-get install -y dotnet-sdk-2.0.2;

#Grab Repos
git clone https://github.com/fullmetalcache/tools;
git clone https://github.com/fullmetalcache/powerline;
git clone https://github.com/creddefense/creddefense;
git clone https://github.com/ChrisTruncer/EyeWitness;
git clone https://bitbucket.org/LaNMaSteR53/peepingtom.git;
git clone https://github.com/fullmetalcache/theHarvester;
git clone https://bitbucket.org/LaNMaSteR53/recon-ng;
git clone https://github.com/nyxgeek/lyncsmash;

#Setup recon-ng (not sure if this is working correctly atm)
cd ~/os_setup/recon-ng;
pip install -r REQUIREMENTS;

#Setup EyeWitness
cd ~/os_setup/EyeWitness;
./setup/setup.sh;

#Install LetsEncrytp / Certbot
echo 'deb http://ftp.debian.org/debian stretch-backports main' >> /etc/apt/sources.list;
apt-get update && apt-get install -y python-certbot-apache -t stretch-backports;
#certbot --apache certonly

#Install Metasploit...yes this works =)
curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall && chmod 755 msfinstall && ./msfinstall;

#Setup VIM environment
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim;
touch ~/.vimrc;
echo 'set nocompatible' >> ~/.vimrc;
echo 'filetype off' >> ~/.vimrc;
echo 'set rtp+=~/.vim/bundle/Vundle.vim' >> ~/.vimrc;
echo 'call vundle#begin()' >> ~/.vimrc;
echo "Plugin 'gmarik/Vundle.vim'" >> ~/.vimrc;
echo "Plugin 'vim-scripts/indentpython.vim'" >> ~/.vimrc;
echo "Plugin 'vim-syntastic/syntastic'" >> ~/.vimrc;
echo "Plugin 'nvie/vim-flake8'" >> ~/.vimrc;
echo 'call vundle#end()' >> ~/.vimrc;
echo 'filetype plugin indent on' >> ~/.vimrc;
echo 'let python_highlight_all=1' >> ~/.vimrc;
echo 'syntax on' >> ~/.vimrc;

#Put this in to deal with some weird dependency for one of the tools...not sure if it is needed anymore...
pip uninstall pyopenssl;
easy_install pyopenssl;
