provider "aws" {
    region = "us-west-1"
}

resource "aws_instance" "ec2" {
    ami = "ami-0e0bf4b3a0c0e0adc"
    instance_type = "t2.micro"
    security_groups = [ aws_security_group.webtraffic.name ]
}

resource "aws_security_group" "webtraffic" {
    name = "Allows HTTPS"

    ingress = [ {
        cidr_blocks = [ "0.0.0.0/0" ]
        ipv6_cidr_blocks = ["::/0"]
        description = "test sg"
        from_port = 443
        protocol = "TCP"
        self = false
        to_port = 443
        security_groups = []
        prefix_list_ids = []
    } ]
    egress = [ {
        cidr_blocks = [ "0.0.0.0/0" ]
        ipv6_cidr_blocks = ["::/0"]
        description = "test sg"
        from_port = 443
        protocol = "TCP"
        self = false
        to_port = 443
        security_groups = []
        prefix_list_ids = []
    } ]
}