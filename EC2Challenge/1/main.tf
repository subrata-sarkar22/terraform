provider "aws"{
    region = "us-west-1"
}

resource "aws_instance" "DBServer" {
    ami = "ami-0e0bf4b3a0c0e0adc"
    instance_type = "t2.micro"
    tags = {
        Name = "DBServer"
    }
}

output "EC2-Private-IP" {
    value = aws_instance.DBServer.private_ip
}