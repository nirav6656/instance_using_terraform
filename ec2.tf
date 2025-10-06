#key_pair

resource "aws_key_pair" "deployer" {
  key_name   = "terrakey"
  public_key = file("terrakey.pub")
}

#VPC

resource "aws_default_vpc" "default" {
    
  tags = {
    Name = "my_default_vpc"
  }
}

#security_group

resource "aws_default_security_group" "default" {
    
  vpc_id = aws_default_vpc.default.id #interpolation
  #inbound rules
  ingress {
    description = "Allow SSH from anywhere (0.0.0.0/0)"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    # WARNING: Using 0.0.0.0/0 is insecure. For production,
    # replace this with your specific public IP address (e.g., "x.x.x.x/32").
    cidr_blocks = ["0.0.0.0/0"]
  }

  # EGRESS Rule: Allow all outbound traffic (default)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # -1 means all protocols
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#ec2-instance

resource "aws_instance" "demo" {
  ami           = "ami-029c5475368ac7adc"
  instance_type = var.aws_instance_type
  associate_public_ip_address = true
  user_data = file("install_nginx.sh")
  key_name = aws_key_pair.deployer.key_name
  vpc_security_group_ids = [aws_default_security_group.default.id]
  tags = {
    Name = "demo-server"
  }
  root_block_device {
    volume_size = var.aws_root_storage_size
    volume_type = "gp3"
  }
}
