#! /bin/bash

# cd /home/qcerris/qcaas/frontend

cp /home/qcerris/qcaas/constants.ts /home/qcerris/qcaas/frontend/src/utils/constants.ts

# Build frontend and remove old build
npm install
npm run build
rm /home/qcerris/qcaas/frontend/build.tar.gz
tar -cvzf /home/qcerris/qcaas/build.tar.gz /home/qcerris/qcaas/frontend/build

# Copy build to server
sshpass -p 'Qcerris2020!' scp /home/qcerris/qcaas/build.tar.gz dusan@qcaas.qcerris.net:/tmp

# SSH to server and pull changes
sshpass -p 'Qcerris2020!' ssh dusan@qcaas.qcerris.net \
'echo Qcerris2020! | sudo -S ./pull_changes.sh;' \
# Copy build to server
'echo Qcerris2020! | sudo -S cp /tmp/build.tar.gz /var/www/hr/frontend' \
# Change settings.py
'echo Qcerris2020! | sudo -S cp /var/www/hr/settings.py /var/www/hr/backend/performance_review/' \
# Restart services
'echo Qcerris2020! | sudo -S service qcaas restart' \
'echo Qcerris2020! | sudo -S service nginx restart' \