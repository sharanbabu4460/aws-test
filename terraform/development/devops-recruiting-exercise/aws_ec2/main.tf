#### create EC2 instance ####
module "vpc_id" {
    source = "../../aws_ec2"
}

resource "aws_security_group" "ssh-allowed" {
    vpc_id = module.vpc_id.cidr_blocks.id
    
    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = var.ssh
    }
        ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags {
        Name = "ssh-allowed"
    }
}

module "ec2_instance" {
  name = "single-instance"
  ami                    = "ami-ebd02392"
  instance_type          = "t2.micro"
  key_name               = "user1"
  monitoring             = true
  vpc_security_group_ids = module.aws_security_group.ssh-allowed.aws_security_group_id
  subnet_id              =  module.vpc_id.subnet.id

  tags = {
    Terraform   = "true"
    Environment = "prod"
  }
}