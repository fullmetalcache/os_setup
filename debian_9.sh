#!/bin/bash

apt-get update;
apt-get upgrade -y;

apt-get install -y curl python-dev python-pip git nikto nmap golang libunwind8 gettext apt-transport-https apache2 dnsutils telnet proxychains zip p7zip;

curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg;
mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg;
echo 'deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-debian-stretch-prod stretch main' >> /etc/apt/sources.list;

apt-get update;
apt-get install -y dotnet-sdk-2.0.2;

git clone https://github.com/fullmetalcache/tools;
git clone https://github.com/fullmetalcache/powerline;
git clone https://github.com/creddefense/creddefense;
git clone https://github.com/ChrisTruncer/EyeWitness;
git clone https://bitbucket.org/LaNMaSteR53/peepingtom.git;
git clone https://github.com/laramies/theHarvester;
git clone https://bitbucket.org/LaNMaSteR53/recon-ng;

cd ~/recon-ng;
pip install -r REQUIREMENTS;

cd ~/EyeWitness;
./setup/setup.sh;

echo 'deb http://ftp.debian.org/debian stretch-backports main' >> /etc/apt/sources.list;
apt-get update && apt-get install -y python-certbot-apache -t stretch-backports;
#certbot --apache certonly

curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall && chmod 755 msfinstall && ./msfinstall;

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

pip uninstall pyopenssl;
easy_install pyopenssl;
