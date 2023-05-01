#!/bin/bash

ansible-playbook -i inventory/inventory.yml delete-all.yml --ask-vault-pass

if [ -d inventory ];
then
	rm -r inventory
fi

if [ -d host_vars ];
then
	rm -r host_vars
fi

if [ -d group_vars ];
then
	rm -r group_vars
fi

if [ $(grep -c dhcpd_name: vars_files/var_file_strings.yml) == 1 ];
then
	sed -i '/dhcpd_name/,$d' vars_files/var_file_strings.yml
fi

echo "";

echo "********************************************************";

echo "";

echo "Configuration and server is deleted";

echo "";

echo "********************************************************";

echo "";