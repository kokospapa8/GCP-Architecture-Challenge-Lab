$ export project_id=<project_id>
$ gcloud config set compute/zone us-central1-a

$ gsutil cp gs://$project_id/echo-web.tar.gz .
$ tar xzvf echo-web.tar.gz

$ gcloud container clusters get-credentials echo-cluster --zone=us-central1-a
$ kubectl create deployment echo-web --image=gcr.io/qwiklabs-resources/echo-app:v1
$ kubectl expose deployment echo-web --type=LoadBalancer --port 80 --target-port 8000




$ docker build -t gcr.io/$project_id/echo-app:v2 .
$ docker push gcr.io/$project_id/echo-app:v2

$ kubectl edit deployment echo-web
# update image version from v1 -> v2
$ kubectl scale deployment echo-web --replicas=2
