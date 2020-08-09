# Create a new VPC network with a single subnet.
$ gcloud compute networks create securenetwork --subnet-mode=custom --bgp-routing-mode=regional
$ gcloud compute networks subnets create bastion-subnet --range=10.0.0.0/24 --network=securenetwork --region=us-central1
# Create firewall rule that allows external RDP traffic to the bastion host system
$ gcloud compute firewall-rules create bastion-allow-rdp --direction=INGRESS --priority=1000 --network=securenetwork --action=ALLOW --rules=tcp:3389 --source-ranges=0.0.0.0/0 --target-tags=bastionhost
# create secure server
$ gcloud compute instances create vm-securehost --zone=us-central1-a --machine-type=n1-standard-1 \
--network-interface network=securenetwork,subnet=bastion-subnet,no-address \
--network-interface no-address \
 --tags=securehost --image=windows-server-2016-dc-v20200714 --image-project=windows-cloud --boot-disk-size=50GB --boot-disk-type=pd-standard --boot-disk-device-name=vm-securehost --no-shielded-secure-boot --shielded-vtpm --shielded-integrity-monitoring
# create bastion server
$ gcloud compute instances create vm-bastionhost --zone=us-central1-a --machine-type=n1-standard-1 \
--network-interface network=securenetwork,subnet=bastion-subnet \
--network-interface no-address \
--tags=bastionhost --image=windows-server-2016-dc-v20200714 --image-project=windows-cloud --boot-disk-size=50GB --boot-disk-type=pd-standard --boot-disk-device-name=vm-bastionhost --no-shielded-secure-boot --shielded-vtpm --shielded-integrity-monitoring --reservation-affinity=any
# reset password 
$ gcloud compute reset-windows-password vm-bastionhost --user app_admin --zone us-central1-a

# RDP and rest of operation done on windows 
> mstsc /v:<secure_bastion_internal_ip>:3389