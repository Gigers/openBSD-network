#!/bin/sh

user=$(whoami)

installXFCE(){

	pkg_add -v consolekit2 xfce xfce-extras evince seamonkey xscreensaver
	echo 'multicast_host=YES' >> /etc/rc.conf.local
	echo 'apmd_flags="-A"' >> /etc/rc.conf.local
	echo 'xenodm_flags=""' >> /etc/rc.conf.local
	echo 'pkg_scripts="messagebus"' >> /etc/rc.conf.local

	echo "exec ck-launch-session startxfce4" > /home/$user/.xsession

}

export PKG_PATH=http://ftp.openbsd.org/pub/OpenBSD/`uname -r`/packages/`arch -s`


echo "Instalacao de ferramentas"

echo "Escolha: "
echo "1-) Vim"
echo "2-) XCFE4"

read choose

case $choose in
	
	1)
		echo "Instalando vim"
		pkg_add vim
		;;
	2)
		echo "Instalando a interface grafica"
		installXFCE
		;;

	*)	
		echo "Opcao invalida!!!"
		esac
