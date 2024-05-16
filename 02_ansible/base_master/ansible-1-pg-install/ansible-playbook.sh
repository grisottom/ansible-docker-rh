ansible-galaxy collection install -r requirements.yml
export ANSIBLE_STDOUT_CALLBACK=unixy
ansible-playbook -i inventory base.yml
