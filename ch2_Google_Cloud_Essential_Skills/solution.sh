$ export PROJECT_ID = <PROJECT_ID> 
$ gsutil mb gs://$PROJECT_ID
$ cat > install-web.sh << EOF
> apt-get update
> apt-get install -y apache2
> EOF

$ gsutil cp install-web.sh gs://$PROJECT_ID/install-web.sh
$ gcloud compute  instances create web --machine-type=n1-standard-1 --metadata startup-script-url=gs://$PROJECT_ID/install-web.sh--tags=http-server --zone=us-central1-a
$ gcloud compute firewall-rules create default-allow-http --direction=INGRESS --priority=1000 --network=default --action=ALLOW --rules=tcp:80 --source-ranges=0.0.0.0/0 --target-tags=http-server

# after vm is created 
$ curl http://[EXTERNAL_IP]