provider "aws" {
    region = "us-west-1"
}

# EC2 for web server module
module "web" {
    source = "./web"
}
# EC2 for DB server module
module "db" {
    source = "./db"
}

# output private IP
output "PrivateIP" {
    value = module.db.PrivateIP
}
# output public IP
output "PublicIP" {
    value = module.web.PublicIP
}
