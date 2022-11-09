#!/bin/bash 

vm_name=$1

check-vm() {
	local vm_name=$1
	vm_params=()
	
	vm_id=$(VBoxManage list runningvms | grep $vm_name | awk -F ' ' '{print $2}' | sed -r 's/[{}]//g')
	vm_params+=($vm_id)
	
	vm_ram_size=$(VBoxManage showvminfo $vm_id | grep "Memory size" | awk -F ':' '{print $2}' | sed -r 's/[MB]//g')
	vm_params+=($vm_ram_size)
	
	vm_os=$(VBoxManage showvminfo $vm_id | grep "Guest OS" | awk -F ':' '{print $2}')
	vm_params+=($vm_os)
	
}

get_vm_params $vm_name
printf '%s\n' "${vm_params[@]}"
