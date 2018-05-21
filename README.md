# Terraform-Elastifile-CloudConnect-GCP

Terraform to create, configure and deploy a Elastifile CloudConnect VM in Google Compute (GCE)

Use:

1. Create password.txt file with a password (.gitignore skips this file)
2. Specify configuration variables in terraform.tvars
3. Run terraform init, terraform apply


Components

google_elfs.tf
Main terraform configuration file.

terraform.tvars
Configuration file
