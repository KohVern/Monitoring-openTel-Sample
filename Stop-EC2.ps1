ssh -i "C:\Users\Kohve\Downloads\monitoring.pem" `
    -o StrictHostKeyChecking=no `
    ec2-user@13.229.218.122 `
    "cd Monitoring-openTel-Sample && docker compose down && exit"
aws ec2 stop-instances --instance-ids i-0ec4d96283d83c44c