$ gcloud compute  instances create web --machine-type=n1-standard-1 --zone=us-central1-a
$ gcloud compute firewall-rules create default-allow-http --direction=INGRESS --priority=1000 --network=default --action=ALLOW --rules=tcp:80 --source-ranges=0.0.0.0/0 --target-tags=http-server

$ gcloud compute ssh web

web> $ apt-get update
web> $ sudo apt-get install -y apache2 
web> exit

# after vm is created 
$ curl http://[EXTERNAL_IP]