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
	vm_family=$(echo $vm_os | awk -F ' ' '{print $1}')
	vm_params+=($vm_family)
	vm_arch=$(echo $vm_os | awk -F ' ' '{print $2}')
	vm_params+=($vm_arch)
	
}

check_vm_params() {
	if [[ "${vm_params[1]}" -eq 8192 && "${vm_params[2]}" -eq "Debian" && "${vm_params[3]}" -eq "(64-bit)"]]; then
		echo Correct
	fi
}

get_vm_params $vm_name
printf '%s\n' "${vm_params[@]}"
check_vm_params