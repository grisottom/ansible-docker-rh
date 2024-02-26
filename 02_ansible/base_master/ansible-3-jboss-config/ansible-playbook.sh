#ansible-playbook -i inventory.yml base-config.yml --limit 'master'
#ansible-playbook -i inventory.yml base-start.yml --limit 'master'
ansible-playbook -i inventory.yml base-config.yml --limit 'slaves'
# ansible-playbook -i inventory.yml base-start.yml --limit 'slaves'