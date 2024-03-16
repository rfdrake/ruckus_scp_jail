#!/bin/bash

USER=${USERNAME:-rouser}
PASSW=${PASSWORD:-$(cat /var/run/secrets/scp_password)}
PASS=${PASSW:-$(head -n 1 /dev/urandom | tr -dc 'a-zA-Z2-9-_' | cut -b1-20)}

# if the password wasn't specified in the environment then show it in the logs
if [ -z "$PASSW" ]; then
  echo "Username: $USER Password: $PASS"
fi

useradd -m -d /home/$USER $USER
echo "$USER:$PASS" | chpasswd

mkdir /run/sshd
/usr/sbin/sshd -D

