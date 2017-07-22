#!/bin/sh


echo 'pf=YES' >> /etc/rc.conf.local
echo  'net.inet.ip.forwarding=1' >> /etc/sysctl.conf

echo 'Insira o endereco da interface externa: '
read ExtIf

echo 'Insira o endereco da interface interna: '
read IntIf

echo "Insira a rede onde sera feito o NAT: "
echo "Exemplo: 192.168.0.0/24"
read PrivNet

echo "match out log on $ExtIf from $PrivNet to any received-on $IntIf tag EGRESS nat-to ($ExtIf:0)" >> /etc/pf.conf

#Reiniciando interfaces
sh /etc/netstart

#Reiniciando DHCP
/etc/rc.d/dhcpd restart

#Reinicia PF
pfctl -f /etc/pf.conf
