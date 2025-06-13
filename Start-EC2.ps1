ssh -i "C:\Users\Kohve\Downloads\monitoring.pem" `
    -o StrictHostKeyChecking=no `
    ec2-user@13.229.218.122 `
    "cd Monitoring-openTel-Sample && git pull && docker compose up -d"