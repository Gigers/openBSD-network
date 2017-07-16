#!/bin/sh

echo "Quantos DNS fixos voce tem ?"
read cont

limit=1

while [ $limit -le $cont ]
do
	echo "Insira seu endereco de DNS: "
	read dns
	echo "nameserver $dns" >> /etc/resolv.conf
	limit=$(( limit+1 ))
done

echo "Pronto"

### FIM ###
