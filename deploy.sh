#! /bin/bash

# source ~/personal/vars.config

# Build frontend and remove old build
cd /home/qcerris/qcaas/frontend
git stash 
git pull new main
cp /home/qcerris/qcaas/constants.ts /home/qcerris/qcaas/frontend/src/utils/constants.ts
npm install
echo '123' | sudo -S npm run build
echo '123' | sudo -S rm /home/qcerris/qcaas/frontend/build.tar.gz
echo '123' | sudo -S tar -cvzf build.tar.gz build/

# Copy build to server
sshpass -p "$SSHPASS" scp /home/qcerris/qcaas/frontend/build.tar.gz dusan@qcaas.qcerris.net:/tmp

# SSH to server and pull changes
sshpass -e ssh dusan@qcaas.qcerris.net \
"echo $SSHPASS | sudo -S /home/dusan/pull_changes.sh; \
# Remove old backup and create new one
echo $SSHPASS | sudo -S rm /var/www/hr/backend_backup.tar.gz; \
echo $SSHPASS | sudo -S tar -czf /var/www/hr/backend_backup.tar.gz /var/www/hr/backend; \
echo $SSHPASS | sudo -S rm /var/www/hr/frontend_backup.tar.gz; \
echo $SSHPASS | sudo -S tar -czf /var/www/hr/frontend_backup.tar.gz /var/www/hr/frontend; \ 
# Copy build to server and extract
echo $SSHPASS | sudo -S rm -rf /var/www/hr/build; \
echo $SSHPASS | sudo -S mv /tmp/build.tar.gz /var/www/hr; \
echo $SSHPASS | sudo -S chown root:root /var/www/hr/build.tar.gz; \
echo $SSHPASS | sudo -S tar -xzf /var/www/hr/build.tar.gz; \
# Change settings.py
# echo $SSHPASS | sudo -S cp /var/www/hr/settings.py /var/www/hr/backend/qcaas/; \
# Make migrations
cd /var/www/hr/backend; \
source venv/bin/activate; \
echo $SSHPASS | sudo -S pip3 install -r requirements.txt; \
echo $SSHPASS | sudo -S python3 manage.py makemigrations; \
echo $SSHPASS | sudo -S python3 manage.py migrate; \
# Restart services
echo $SSHPASS | sudo -S service qcaas restart; \
echo $SSHPASS | sudo -S service nginx restart;" \