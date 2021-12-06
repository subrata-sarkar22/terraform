provider "aws" {
    region = "us-west-1"
}

resource "aws_instance" "db" {
    ami = "ami-0e0bf4b3a0c0e0adc"
    instance_type = "t2.micro"
    
    tags = {
        Name = "DB Server"
    }
}

resource "aws_instance" "web" {
    ami = "ami-0e0bf4b3a0c0e0adc"
    instance_type = "t2.micro"
    security_groups = [aws_security_group.web_traffic.name]
    user_data = file("server-script.sh")
    tags = {
        Name = "Web Server"
    }
}

resource "aws_eip" "web_ip" {
    instance = aws_instance.web.id
}

variable "ingress" {
    type = list(number)
    default = [80,443]
}

variable "egress" {
    type = list(number)
    default = [80,443]
}

resource "aws_security_group" "web_traffic" {
    name = "Allow Web traffic"

    dynamic "ingress" {
        iterator = port
        for_each = var.ingress
        content {
            cidr_blocks = [ "0.0.0.0/0" ]
            ipv6_cidr_blocks = ["::/0"]
            description = "HTTPS-SG"
            from_port = port.value
            protocol = "TCP"
            self = false
            to_port = port.value
            security_groups = []
            prefix_list_ids = []
        }
    }

    dynamic "egress" {
        iterator = port
        for_each = var.ingress
        content {
            cidr_blocks = [ "0.0.0.0/0" ]
            ipv6_cidr_blocks = ["::/0"]
            description = "HTTPS-SG"
            from_port = port.value
            protocol = "TCP"
            self = false
            to_port = port.value
            security_groups = []
            prefix_list_ids = []
        }
    }
}

output "PrivateIP" {
    value = aws_instance.db.private_ip
}

output "PublicIP" {
    value = aws_eip.web_ip.public_ip
}