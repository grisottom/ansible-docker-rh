export ANSIBLE_STDOUT_CALLBACK=unixy
ansible-playbook -i inventory.yml base.yml 
#ansible-playbook -i inventory.yml test-rescue.yml 