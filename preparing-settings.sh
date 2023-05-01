#!/bin/bash

##################
# vaiables dhcp server
dhcpd_name=""
dhcp_server_dev_out=""
option_domain_name=""
option_domain_name_servers=""
default_lease_time=""
max_lease_time=""

# ansible variables
ansible_host=""
ansible_user=""
ansible_password=""
ansible_port=""
ansible_connection=""
##################

echo "";

echo "********************************************************";

echo "";

echo "Preparing settings for dhcp server podman";

echo "";

echo "********************************************************";

echo "";

if [ ! -d inventory ];
then
	mkdir inventory
fi

if [ ! -d host_vars ];
then
	mkdir host_vars
fi

if [ ! -d group_vars ];
then
	mkdir group_vars
fi

if [ ! -f inventory/inventory.yml ];
then
	
	echo "all:" >> inventory/inventory.yml
	echo "  children:" >> inventory/inventory.yml
	echo "    linuxservices:" >> inventory/inventory.yml
	echo "      children:" >> inventory/inventory.yml
	echo "        debianbased:" >> inventory/inventory.yml
	echo "          hosts:" >> inventory/inventory.yml
	echo "            dhcp-server-podman:" >> inventory/inventory.yml
	
fi

if [ ! -f host_vars/dhcp-server-podman.yml ];
then
	echo "ansible_host: "$ansible_host >> host_vars/dhcp-server-podman.yml
fi

if [ ! -f group_vars/linuxservices.yml ];
then
	
	echo "********************************************************";

	echo "";
	
	echo "Encrypt ansible password";
	
	echo "";
	
	echo "ansible_user: " $ansible_user >> group_vars/linuxservices.yml
	
	ansible-vault encrypt_string $ansible_password >> group_vars/linuxservices.yml
	
	sed -i 's/!vault/ansible_password: !vault/' group_vars/linuxservices.yml
	
	echo "ansible_port: " $ansible_port >> group_vars/linuxservices.yml
	echo "ansible_connection: " $ansible_connection >> group_vars/linuxservices.yml
	
	echo "";
	
fi

if [ $(grep -c dhcpd_name: vars_files/var_file_strings.yml) == 0 ];
then
	echo "dhcpd_name: " $dhcpd_name >> vars_files/var_file_strings.yml
fi

if [ $(grep -c dhcp_server_dev_out: vars_files/var_file_strings.yml) == 0 ];
then
	echo 'dhcp_server_dev_out: "'$dhcp_server_dev_out'"' >> vars_files/var_file_strings.yml
fi

if [ $(grep -c option_domain_name: vars_files/var_file_strings.yml) == 0 ];
then
	echo 'option_domain_name: "'$option_domain_name'"' >> vars_files/var_file_strings.yml
fi

if [ $(grep -c option_domain_name_servers: vars_files/var_file_strings.yml) == 0 ];
then
	echo 'option_domain_name_servers: "'$option_domain_name_servers'"' >> vars_files/var_file_strings.yml
fi

if [ $(grep -c default_lease_time: vars_files/var_file_strings.yml) == 0 ];
then
	echo 'default_lease_time: "'$default_lease_time'"' >> vars_files/var_file_strings.yml
fi

if [ $(grep -c max_lease_time: vars_files/var_file_strings.yml) == 0 ];
then
	echo 'max_lease_time: "'$max_lease_time'"' >> vars_files/var_file_strings.yml
fi

if [ $(grep -c dhcp_network_vars: vars_files/var_file_strings.yml) == 0 ];
then

	echo "dhcp_network_vars:" >> vars_files/var_file_strings.yml
	echo "# Vars to set network, example:" >> vars_files/var_file_strings.yml
	echo '#  - { interface: "eth0.1002", subnet: "172.16.12", netmask: "255.255.255.0", ip_range: "172.16.12.10 172.16.12.50" }' >> vars_files/var_file_strings.yml
	
fi

if [ $(grep -c networks_to_delete_vars: vars_files/var_file_strings.yml) == 0 ];
then

	echo "networks_to_delete_vars:" >> vars_files/var_file_strings.yml
	echo "# Vars to delete network, example:" >> vars_files/var_file_strings.yml
	echo '#  - 172.16.13' >> vars_files/var_file_strings.yml
	
fi

echo "********************************************************";

echo "";

echo "Configuration is set";

echo "";

echo "To create dhcp server or add new network, run:";

echo "";

echo "ansible-playbook -i inventory/inventory.yml install-dhcp-server.yml --ask-vault-pass";

echo "";

echo "remember to set dhcp_network_vars in file vars_files/var_file_strings.yml";

echo "";

echo "To delete network, run:";

echo "";

echo "ansible-playbook -i inventory/inventory.yml delete-network.yml --ask-vault-pass";

echo "";

echo "remember to set networks_to_delete_vars in file vars_files/var_file_strings.yml";

echo "";

echo "To delete server and all settings, run:";

echo "";

echo "./clean-all.sh";

echo "";

echo "********************************************************";

echo "";