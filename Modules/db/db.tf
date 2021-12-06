
resource "aws_instance" "db" {
    ami = "ami-03af6a70ccd8cb578"
    instance_type = "t2.micro"

    tags = {
        "Name" = "DBServer"
    }
}

output "PrivateIP" {
    value = aws_instance.db.private_ip
}