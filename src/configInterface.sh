#!/bin/sh

quest(){

	echo "Insira a interface: "
	read eth
	echo "Insira o endereco IP: "
	read ip
	echo "Insira a mascara da rede: "
	read mask
	echo "Insira o endereÃo broadcast: "
	read bc

}


dhcp(){

	echo "Insira a interface: "
	read eth
	
	echo "dhcp" > /etc/hostname.$eth

}

static(){

	quest
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

		2)
			dhcp
			;;

		*)	
			echo "ERRO!"
			esac

}

### Final ###

TOOR=$(id -u)

if [ "$TOOR" == "0" ];then
		main

	else
		echo "Root only!"
		exit
	fi

