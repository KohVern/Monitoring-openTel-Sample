## In ubuntu
ansible-playbook -i inventory.ini [file].yml

### Types of files
ec2-setup: In existing EC2 setup Required files
docker-commands: Start/Stop docker compose

### AWS commands
ssh -i ~/monitoring.pem ec2-user@ec2-52-221-164-168.ap-southeast-1.compute.amazonaws.com
aws ec2 start-instances --instance-ids i-0de158030cdbab7f5 --region ap-southeast-1
aws ec2 stop-instances --instance-ids i-0de158030cdbab7f5 --region ap-southeast-1

### Open Cloudflare for https sample connection
cloudflared tunnel --url http://localhost:3000

### Quick Links
- Weather-App: http://52.221.164.168:5170
- Payment-App: http://52.221.164.168:5180
- cAdvisor: http://52.221.164.168:8080
- Node-Exporter: http://52.221.164.168:9100
- otel-collector: http://52.221.164.168:8889
- Prometheus: http://52.221.164.168:9090
- Grafana: http://52.221.164.168:3000 