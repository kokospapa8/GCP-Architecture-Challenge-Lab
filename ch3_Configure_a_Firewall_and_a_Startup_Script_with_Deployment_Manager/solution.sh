$ mkdir deployment_manager
$ cd deployment_manager
$ gsutil cp gs://spls/gsp302/* .
# edit qwiklabs.jinja and qwiklabs.yaml
$ gcloud deployment-manager deployments create lab --config qwiklabs.yaml