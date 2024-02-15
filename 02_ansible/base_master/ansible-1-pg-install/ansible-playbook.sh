ansible-galaxy collection install -r requirements.yml
ansible-playbook -i inventory base.yml --ask-vault-pass