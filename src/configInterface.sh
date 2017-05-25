#!/bin/sh

static(){


	echo "Insira a interface: "
	read eth
	echo "Insira o endereco IP: "
	read ip
	echo "Insira a mascara da rede: "
	read mask
	echo "Insira o broadcast: "
	read bc

	echo "inet $ip $mask $bc" > /etc/hostname.$eth


}


main(){
	echo "Configurando Interfaces de rede"

	echo "Deseja configurar o IP Static ou dinamico nesta interface ?"
	echo "1 - Fixo\n2 - DHCP"
	read choose

	case $choose in

		1)
			static
			;;

		*)	
			echo "ERRO!"
			esac

}

TOOR=$(id -u)

if [ "$TOOR" == "0" ];then
		main

	else
		echo "Root only!"
		exit
	fi

