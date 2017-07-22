#!/bin/sh


configSquid(){

	#Baixando as blacklists
	wget http://www.shallalist.de/Downloads/shallalist.tar.gz

	tar zxvf shallalist.tar.gz -C /var/db/squidGuard/db/

	chown -R _squid /var/db/squidGuard

	echo "url_rewrite_program /usr/local/bin/squidGuard" >> /etc/squid/squid.conf
	echo "url_rewrite_children 5" >> /etc/squid/squid.conf
	echo "url_rewrite_access deny localhost" >> /etc/squid/squid.conf


	export PKG_PATH=http://ftp.openbsd.org/pub/OpenBSD/`uname -r`/packages/`arch -s`
	pkg_add -i squidGuard
}

configGuard(){

	echo "As configuracoes que serao realizadas bloqueiam apenas os sites pornograficos"

	cd /etc/squidguard/

	#fazendo bkp
	cp squidguard.conf squidguard.bkp

	#apagando conteudo anterior
	echo "" > squidguard.conf

	echo "Insira sua rede e mascara"
	echo "exemplo: 192.168.5.0/24"
	read netmask

	echo "dbhome /var/db/squidGuard/db" >> squidguard.conf
	echo "logdir /var/log/squidguard" >> squidguard.conf

	echo "dest porn {" >> squidguard.conf
        echo "domainlist BL/porn/domains" >> squidguard.conf
        echo "urllist  BL/porn/urls" >> squidguard.conf
	echo "}" >> squidguard.conf

	echo "src lan {" >> squidguard.conf
        echo "ip      $netmask" >> squidguard.conf
	echo "}" >> squidguard.conf


	echo "acl {" >> squidguard.conf
        echo "lan {" >> squidguard.conf
        echo "        pass !porn all" >> squidguard.conf
        echo "}" >> squidguard.conf

        echo "default {" >> squidguard.conf
        echo "       pass !porn all" >> squidguard.conf
        echo "}" >> squidguard.conf
 	echo "}" >> squidguard.conf
}

echo "Configuracao do squidGuard"

configSquid
configGuard
