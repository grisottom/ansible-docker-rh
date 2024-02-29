#ansible-playbook -i inventory.yml base-config.yml --limit 'master'
#ansible-playbook -i inventory.yml base-start.yml --limit 'master'
#ansible-playbook -i inventory.yml base-configj2.yml --limit 'slaves'
#ansible-playbook -i inventory.yml base-start.yml --limit 'slaves'

#ansible-playbook -i inventory.yml base.yml --limit 'master'
ansible-playbook -i inventory.yml base.yml --limit 'slaves'