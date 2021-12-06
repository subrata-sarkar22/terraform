provider "aws" {
    region = "us-west-1"
}

resource "aws_instance" "db" {
    ami = "ami-0e0bf4b3a0c0e0adc"
    instance_type = "t2.micro"
    tags ={
        Name = "DB Server"
    }
}

resource "aws_instance" "web" {
    ami = "ami-0e0bf4b3a0c0e0adc"
    instance_type = "t2.micro"
    tags ={
        Name = "Web Server"
    }
    depends_on = [aws_instance.db]
}

data "aws_instance" "dbsearch" {
    filter {
        name = "tag:Name"
        values = ["DB Server"]
    }
}

output "dbservers" {
    value = data.aws_instance.dbsearch.availability_zone
}