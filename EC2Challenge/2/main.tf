provider "aws" {
    region = "us-west-1"
}

resource "aws_instance" "webserver" {
    ami = "ami-0e0bf4b3a0c0e0adc"
    instance_type = "t2.micro"
    tags = {
        Name = "WebServer"
    }
}

resource "aws_eip" "elasticip" {
    instance = aws_instance.webserver.id
}