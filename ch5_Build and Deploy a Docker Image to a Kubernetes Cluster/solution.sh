$ export project_id=<project_id>
$ gcloud config set compute/zone us-central1-a

$ gsutil cp gs://$project_id/echo-web.tar.gz .
$ tar xzvf echo-web.tar.gz

$ docker build -t gcr.io/$project_id/echo-app:v1 .
$ docker push gcr.io/$project_id/echo-app:v1
$ gcloud container clusters create echo-cluster --num-nodes=2 --machine-type=n1-standard-2
$ kubectl create deployment echo-app --image=gcr.io/$project_id/echo-app:v1
$ kubectl get pods
$ kubectl expose deployment echo-app --type=LoadBalancer --port 80 --target-port 8000
$ kubectl get service