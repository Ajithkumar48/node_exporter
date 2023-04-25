#!/bin/bash

# Get the working directory path
WORKING_DIRECTORY="$(pwd)"

# Print the working directory path
echo "The working directory is: $WORKING_DIRECTORY"

# Set the command to be executed by the service
COMMAND_TO_RUN=$WORKING_DIRECTORY/node_exporter

# Set the service name
SERVICE_NAME=node_exporter

# Set the description of the service
SERVICE_DESCRIPTION="Node Exporter for Monitoring"

# Create the service file
sudo tee /etc/systemd/system/$SERVICE_NAME.service <<EOF
[Unit]
Description=$SERVICE_DESCRIPTION
After=network.target

[Service]
WorkingDirectory=$WORKING_DIRECTORY
ExecStart=$COMMAND_TO_RUN
Restart=always

[Install]
WantedBy=multi-user.target
EOF

# Reload the systemd daemon
sudo systemctl daemon-reload

# Start the service and enable it to run at boot time
sudo systemctl start $SERVICE_NAME
sudo systemctl enable $SERVICE_NAME
