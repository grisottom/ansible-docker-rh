
#!/bin/bash

# Add jboss Application user
#add-user.sh {{ jboss_mgmt_user }} {{ jboss_mgmt_user_pwd }};
#add-user.sh -a {{ jboss_app_user }} {{ jboss_app_pwd }};

#add-user.sh {{ jboss_mgmt_user }} {{ jboss_mgmt_user_pwd }};
add-user.sh -a $1 $2;