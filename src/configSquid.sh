#!/bin/sh

install(){

	export PKG_PATH=http://ftp.openbsd.org/pub/OpenBSD/`uname -r`/packages/`arch -s`
	pkg_add -i squid	

}

config(){
	
	echo "Entrando no diretorio Squid"
	cd /etc/squid/

	#Fazendo backup e zerando arquivo
	cp squid.conf squid.bkp

	echo "" > squid.conf

	#Rede do usuario

	echo "Insira a rede e mascara que irao poder utilizar o squid"
	echo "Exemplo: 192.168.5.0/24"
	read netmask

	#Adicionando novas configuracoes

	echo "#Porta padrão do squi" >> squid.conf
	echo "http_port   3128" >> squid.conf

	echo "#Nome do servidor" >> squid.conf
	echo "visible_hostname SquidOpenBSD" >> squid.conf

	echo "#Caminho do diretório de cach" >> squid.conf
	echo "cache_dir   ufs /var/squid/cache 100 16 256" >> squid.conf 

	echo "#Cache Admin" >> squid.conf
	echo "cache_mgr  administrador@VoIP.com" >> squid.conf

	echo "#Usuário que irá ter permissão no diretório de c" >> squid.conf
	echo "cache_effective_user    _squid" >> squid.conf
	echo "cache_effective_group   _squid" >> squid.conf

 
	echo "#Log de acesso" >> squid.conf
	echo "access_log /var/log/squid/access.log squid" >> squid.conf

	echo "#Bloqueio de sites por URL" >> squid.conf
	echo "acl sites_proibidos url_regex -i '/etc/squid/sites_proibidos'" >> squid.conf
	echo "http_access deny sites_proibidos" >> squid.conf

	echo "#Portas Seguras" >> squid.conf

	echo "#Porta SSL" >> squid.conf
	echo "acl SSL_ports port 443" >> squid.conf

	echo "acl Safe_ports port 80 #HTTP" >> squid.conf
	echo "acl Safe_ports port 443 #HTTPS" >> squid.conf
	echo "acl Safe_ports port 3128 #Squid" >> squid.conf
	echo "acl Safe_ports port 22 #SSH" >> squid.conf

	echo "acl CONNECT method CONNECT" >> squid.conf

	echo "#Redes que vão se conectar ao squi" >> squid.conf
	echo "acl manager proto cache_object" >> squid.conf
	echo "acl redelocal src $netmask" >> squid.conf

	echo "#Bloqueio de portas e endereço" >> squid.conf
	echo "http_access allow redelocal" >> squid.conf
	echo "http_access deny !Safe_ports" >> squid.conf
	echo "http_access deny CONNECT !SSL_ports" >> squid.conf
	echo "http_access deny all" >> squid.conf
		
	> sites_proibidos
	mkdir /var/log/squid
	> /var/log/squid/access.log
	
	squid -z

}


echo "CONFIGURACAO DO SQUID"

echo "1 - Instalar"
echo "2 - Configurar (squid.conf default)"
echo "3 - Instalar e configurar"

read choose

case $choose in

	1)
		echo "Instalar"
		install
		;;
	2)
		echo "Configurar"
		config
		;;
	3)
		echo "Instalar e configurar"
		install
		config
		;;
	*)
		echo "ERRO!"
		esac
