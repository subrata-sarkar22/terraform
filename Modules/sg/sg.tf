variable "ingress" {
    type = list(number)
    default = [80,443]
}

variable "egress" {
    type = list(number)
    default = [80,443]
}

resource "aws_security_group" "web_traffic" {
    name = "allow web traffic"

    dynamic "ingress" {
        iterator = port
        for_each = var.ingress
        content {
            description      = "Web-SG"
            from_port        = port.value
            to_port          = port.value
            protocol         = "TCP"
            self = false
            cidr_blocks      = ["0.0.0.0/0"]
            ipv6_cidr_blocks = ["::/0"]
        }
    }

    dynamic "egress" {
        iterator = port
        for_each = var.egress
        content {
            description      = "Web-SG"
            from_port        = port.value
            to_port          = port.value
            protocol         = "TCP"
            self = false
            cidr_blocks      = ["0.0.0.0/0"]
            ipv6_cidr_blocks = ["::/0"]
        }
    }
}

output "sg_name" {
    value = aws_security_group.web_traffic.name
}
