ansible-galaxy collection install -r requirements.yml
#ansible-playbook -i inventory base.yml --ask-vault-pass
#ansible-playbook -i inventory base.yml --vault-password-file /root/.ansible/pwd/pwd.txt
ansible-playbook -i inventory base.yml  --vault-id dev@/root/.ansible/pwd/pwd.txt