$ export project_id=<project_id>
$ gcloud config set compute/zone us-central1-a

$ gcloud compute ssh blog

$ gsutil mb gs://$project_id

# create cloudsql with Database name = wordpress
# create username=blogadmin with password Password1*
# update network that allowed <blog_public_ip>


vm: blog> mysqldump -u blogadmin  wordpress > dump.sql -p
vm: blog> gsutil cp dump.sql gs://<project_id> 
vm: blog> sudo sed -i 's/localhost/<MYSQL_PUBLIC_IP>/g' /var/www/html/wordpress/wp-config.php 
vm: blog> sudo service apache2 restart
vm: blog> exit

# sql -> import data from gs://<project_id>/dump.sql