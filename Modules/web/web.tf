resource "aws_instance" "web" {
    ami = "ami-03af6a70ccd8cb578"
    instance_type = "t2.micro"
    security_groups = [module.sg.sg_name]  # assigned the module
    user_data = file("./web/server-script.sh")  # assigne the script details
    tags = {
        "Name" = "WebServer"
    }
}

output "PublicIP" {
    value = module.eip.PublicIP  # will get the public IP from elastic IP assigne to the webserver
}

# call module for elactic IP (eip)
module "eip" {
    source = "../eip"
    instance_id = aws_instance.web.id
}

# call module for security group
module "sg" {
    source = "../sg"
}