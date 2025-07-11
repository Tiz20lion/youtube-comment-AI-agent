#!/bin/bash

# Google Cloud VPS Deployment Script with Uvicorn
# Default port: 7844
# Startup command: python -m uvicorn app.main:app --host 0.0.0.0 --port 7844

set -e

DEFAULT_PORT=7844
SERVICE_NAME="tiz-lion-ai-agent"
APP_DIR="/opt/youtube-comment-ai-agent"
VENV_DIR="$APP_DIR/venv"

create_systemd_service() {
    echo "Creating systemd service with uvicorn..."
    
    sudo tee "/etc/systemd/system/$SERVICE_NAME.service" > /dev/null <<EOF
[Unit]
Description=Tiz Lion AI Agent - YouTube Comment Automation
After=network.target

[Service]
Type=simple
User=root
Group=root
WorkingDirectory=$APP_DIR
Environment=PATH=$VENV_DIR/bin
Environment=PYTHONPATH=$APP_DIR
ExecStart=$VENV_DIR/bin/python -m uvicorn app.main:app --host 0.0.0.0 --port $DEFAULT_PORT
Restart=always
RestartSec=10
StandardOutput=journal
StandardError=journal

[Install]
WantedBy=multi-user.target
EOF

    sudo systemctl daemon-reload
    sudo systemctl enable "$SERVICE_NAME"
    
    echo "✅ Systemd service created with uvicorn startup command"
}

echo "🚀 Tiz Lion AI Agent - Google Cloud Deployment"
echo "📡 Startup Command: python -m uvicorn app.main:app --host 0.0.0.0 --port 7844"
echo "🌐 Service will use port 7844 by default"
echo ""
echo "Run this script to deploy on Google Cloud VPS"
