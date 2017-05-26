#!/bin/sh

initDaemon(){
	
	rcctl enable dhcpd
	
	echo "Insira o nome da interface que ira distribuir os enderecos: "
	read eth
	
	rcctl set dhcpd flags $eth

}

configServer(){

	echo "Insira o nome da regra: "
	read name
	echo "Insira o endereco subnet: "
	read subnet
	echo "Insira a mascara da rede: "
	read mask
	echo "Insira o DNS padrao desta rede: "
	read dns
	echo "Insira o roteador padrao para esta rede: "
	read router
	echo "Insira o inicio do range: "
	read start
	echo "Insira o final do range: "
	read end

	echo "# $name" >> teste
	echo "subnet $subnet netmask $mask {" >> teste
	echo "option domain-name-servers $dns;" >> teste
	echo "option routers $router;" >> teste
	echo "range $start $end;" >> teste
	echo "}" >> teste

}


echo "Configurando servidor DHCP"

echo "MENU"
echo "1-) Ativa servico"
echo "2-) Configurar Pool"
read choose

case $choose in
	1)
		initDaemon
		;;
	2)
		configServer
		;;
	*)
		echo "ERRO!"
		esac
