provider "aws" {
    region = "us-west-1"
}

variable "number_of_servers" {
    type = number
}

resource "aws_instance" "ec2" {
    ami = "ami-0e0bf4b3a0c0e0adc"
    instance_type = "t2.micro"
    count = var.number_of_servers
}