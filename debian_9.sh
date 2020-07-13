#!/bin/bash

CURRDIR=$(pwd);

apt-get update;
apt-get upgrade -y;

#Install packages and dependencies
apt-get install -y curl python-dev python-pip git nikto nmap libunwind8 gettext apt-transport-https apache2 dnsutils telnet proxychains zip p7zip libffi-dev libssl-dev dirmngr libcurl4-gnutls-dev librtmp-dev lsof dirmngr openjdk-8-jdk-headless ike-scan;

#Install dotnet
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg;
mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg;
echo 'deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-debian-stretch-prod stretch main' >> /etc/apt/sources.list;

apt-get update;
apt-get install -y dotnet-sdk-2.0.2;

#Install GoLang
cd ~;
wget https://dl.google.com/go/go1.13.5.linux-amd64.tar.gz;
tar -C /usr/local -xzf go1.13.5.linux-amd64.tar.gz;
echo "export PATH=$PATH:/usr/local/go/bin" >> ~/.profile;
source ~/.profile;
mkdir /root/go;
mkdir /root/go/src;

#Install Amass
echo "export GO111MODULE=on" >> ~/.profile; 
source ~/.profile;
go get -v -u github.com/OWASP/Amass/v3/...;
cd /root/go/src/github.com/OWASP/Amass;
go install ./...;
mkdir /root/Amass/;
cp /root/go/bin/amass /root/Amass/;


#Grab Repos
cd ~;
git clone https://github.com/fullmetalcache/tools;
git clone https://github.com/fullmetalcache/powerline;
git clone https://github.com/creddefense/creddefense;
git clone https://github.com/ChrisTruncer/EyeWitness;
git clone https://bitbucket.org/LaNMaSteR53/peepingtom.git;
git clone https://github.com/fullmetalcache/theHarvester;
git clone https://github.com/LaNMaSteR53/recon-ng;
git clone https://github.com/nyxgeek/lyncsmash;
git clone https://github.com/rvrsh3ll/FindFrontableDomains;
git clone https://github.com/bluscreenofjeff/Malleable-C2-Randomizer;
wget https://raw.githubusercontent.com/killswitch-GUI/CobaltStrike-ToolKit/master/HTTPsC2DoneRight.sh;
git clone https://github.com/SpiderLabs/ikeforce;
git clone https://bitbucket.org/grimhacker/office365userenum/src/master/;
git clone https://github.com/blechschmidt/massdns;
git clone https://github.com/infosec-au/altdns;
wget 
https://gist.github.com/jhaddix/86a06c5dc309d08580a018c66354a056/raw/96f4e51d96b2203f19f6381c8c545b278eaa0837/all.txt;
git clone https://github.com/sullo/nikto;

#Make massdns
cd ~/massdns;
make;

#Install altdns
cd ~/altsdns;
pip install -R requirements.txt;
python setup.py install;

#Setup recon-ng (not sure if this is working correctly atm)
cd $CURRDIR/recon-ng;
pip install -r REQUIREMENTS;

#Setup EyeWitness
cd $CURRDIR/EyeWitness;
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

#Install dirb
cd $CURRDIR;
wget https://newcontinuum.dl.sourceforge.net/project/dirb/dirb/2.22/dirb222.tar.gz;
tar -xvf dirb222.tar.gz;
cd dirb222;
chmod +x configure;
./configure;
make -j8;
mkdir wordlists/raft;
cd wordlists/raft;
wget https://raw.githubusercontent.com/danielmiessler/SecLists/master/Discovery/Web-Content/raft-large-directories.txt;
wget https://raw.githubusercontent.com/danielmiessler/SecLists/master/Discovery/Web-Content/raft-large-files.txt;
cd $CURRDIR;

#Setup bash to not display entire path
echo "export PS1='\${debian_chroot:+(\$debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]\$ '" >> ~/.bashrc;
source ~/.bashrc;

#Put this in to deal with some weird dependency for one of the tools...not sure if it is needed anymore...
pip uninstall pyopenssl;
easy_install pyopenssl;

#ikeforce/ikescan stuff
pip install pyip;
pip install pycrypto;
pip install 'pyopenssl==17.2.0';
