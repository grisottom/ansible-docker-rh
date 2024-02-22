# to run once
# to be used as vault password file in 'in ansible-playbook.sh'
if [ ! -f "/root/.ansible/pwd/pwd.txt" ] ; then
  mkdir -p /root/.ansible/pwd/
  ls -all ./quick-fix/pwd.txt
  cp ./quick-fix/pwd.txt /root/.ansible/pwd/
fi