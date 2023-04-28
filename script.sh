#!/bin/bash

WORKSPACE=$1
SERVER=$2
SSH_USER=$3

# Set the Source directory with WORKSPACE
SOURCE_DIR="${WORKSPACE}"
echo "Source folder: ${SOURCE_DIR}"

# Set the destination directory with SSH_USER
DEST_DIR="/home/${SSH_USER}"
echo "Destination folder: ${DEST_DIR}"

echo ""
echo "------------------------------------------------------------------------"
echo "[STARTED] node_exporter initiated on server: ${SERVER}"
echo "------------------------------------------------------------------------"
echo ""

  echo "Copying files to ${SERVER}..."
  echo ""
  ssh -i /home/vagrant/.ssh/id_rsa -o StrictHostKeyChecking=no -p 22 "${SSH_USER}@${SERVER}" "rm -r ${DEST_DIR}/node_exporter" > /dev/null
  scp -i /home/vagrant/.ssh/id_rsa -o StrictHostKeyChecking=no -P 22 -r "${SOURCE_DIR}"* "${SSH_USER}@${SERVER}:${DEST_DIR}"
  ssh -i /home/vagrant/.ssh/id_rsa -o StrictHostKeyChecking=no -p 22 "${SSH_USER}@${SERVER}" "cd ${DEST_DIR}/node_exporter && chmod +x ./node_exporter && ./node_exporter" > /dev/null