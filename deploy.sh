#! /bin/bash

# source ~/personal/vars.config
cp /home/qcerris/qcaas/constants.ts /home/qcerris/qcaas/frontend/src/utils/constants.ts

# Build frontend and remove old build
cd /home/qcerris/qcaas/frontend
npm install
# npm run build
rm /home/qcerris/qcaas/frontend/build.tar.gz
tar -cvzf /home/qcerris/qcaas/build.tar.gz /home/qcerris/qcaas/frontend/build

# Copy build to server
sshpass -e scp /home/qcerris/qcaas/build.tar.gz dusan@qcaas.qcerris.net:/tmp

# SSH to server and pull changes
sshpass -e ssh dusan@qcaas.qcerris.net \
"echo $SSHPASS | sudo -S ./pull_changes.sh; \
# Remove old backup and create new one
echo $SSHPASS | sudo -S rm /var/www/hr/backend_test.tar.gz; \
echo $SSHPASS | sudo -S tar -cvzf /var/www/hr/backend_test.tar.gz /var/www/hr/backend; \
echo $SSHPASS | sudo -S rm /var/www/hr/frontend_test.tar.gz; \
echo $SSHPASS | sudo -S tar -cvzf /var/www/hr/frontend_test.tar.gz /var/www/hr/frontend; \ 
# Copy build to server and extract
echo $SSHPASS | sudo -S cp /tmp/build.tar.gz /var/www/hr/frontend;" 
# 'echo Qcerris2020! | sudo -S tar -xvzf /var/www/hr/frontend/build.tar.gz -C /var/www/hr/' \
# Change settings.py
# 'echo Qcerris2020! | sudo -S cp /var/www/hr/settings.py /var/www/hr/backend/performance_review/' \
# Make migrations
# 'echo Qcerris2020! | sudo -S source venv/bin/activate'
# cd /var/www/hr/backend
# python3 manage.py makemigrations
# Restart services
# 'echo Qcerris2020! | sudo -S service qcaas restart' \
# 'echo Qcerris2020! | sudo -S service nginx restart' \