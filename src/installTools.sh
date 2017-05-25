#!/bin/sh

export PKG_PATH=http://ftp.openbsd.org/pub/OpenBSD/`uname -r`/packages/`arch -s`

echo "Instala√√o de ferramentas"

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
		echo "Instalando a interface"
		exec ck-launch-session startxfce4
		;;

	*)	
		echo "Opcao invalida!!!"
		esac
