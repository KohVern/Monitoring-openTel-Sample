## In ubuntu
ansible-playbook -i inventory.ini [file].yml

### Types of files
ec2-setup: In existing EC2 setup Required files
docker-commands: Start/Stop docker compose

### AWS commands
ssh -i ~/monitoring.pem ec2-user@ec2-18-138-248-103.ap-southeast-1.compute.amazonaws.com

aws ec2 describe-instances --instance-ids i-0ec4d96283d83c44c --query "Reservations[*].Instances[*].PublicIpAddress"

aws ec2 start-instances --instance-ids i-0ec4d96283d83c44c --region ap-southeast-1

aws ec2 stop-instances --instance-ids i-0ec4d96283d83c44c --region ap-southeast-1

### Open Cloudflare for https sample connection
cloudflared tunnel --url http://localhost:3000

### Quick Links
- Weather-App: http://[Ip-address]:5170
- Payment-App: http://[Ip-address]:5180
- cAdvisor: http://[Ip-address]:8080
- Node-Exporter: http://[Ip-address]:9100
- otel-collector: http://[Ip-address]:8889
- Prometheus: http://[Ip-address]:9090
- Grafana: http://[Ip-address]:3000 