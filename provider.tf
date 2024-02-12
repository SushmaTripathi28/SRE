
provider "google" { 
  project     ="sharp-avatar-410113"
  region      = "us-central1"
zone= "us-central1-a"
}

module "alerting" {
  source       = "./main.tf"  # Update the path to your module
  email_address = "sushma.tripathi@hcl.com"  # Update with your email address
}
