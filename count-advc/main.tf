provider "aws" {
    region = "us-west-1"
}

module "db" {
    source = "./db"
    server_names = ["mariadb", "mysql", "mssql"]
}

output "private_ips" {
    value = module.db.PrivateIP
}