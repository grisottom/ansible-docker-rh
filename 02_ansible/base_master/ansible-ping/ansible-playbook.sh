ansible-galaxy install -vvv -r requirements.yml 
export ANSIBLE_STDOUT_CALLBACK=unixy
ansible-playbook -v -i inventory ping_all.yml
