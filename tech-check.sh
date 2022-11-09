#!/bin/bash 

vm_name=$1

check-vm() {
	local vm_name=$1
	
	vm_id=$(VBoxManage list runningvms | grep $vm_name | awk -F ' ' '{print $2}' | sed -r 's/[{}]//g')
	echo $vm_id
	
	vm_ram_size=$(VBoxManage showvminfo $vm_id | grep "Memory size" | awk -F ':' '{print $2}' | sed -r 's/[MB]//g' )
	echo $vm_ram_size
	
	vm_os=$(VBoxManage showvminfo $vm_id | grep "Guest OS" | awk -F ':' '{print $2}' | sed -r 's/[MB]//g' )
	echo $vm_os
	
}

check-vm $vm_name
