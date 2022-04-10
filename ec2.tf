resource "aws_instance" "Test_EC2" {
  ami                         = "ami-0015fcaa5516c75ed"
  instance_type               = "t2.micro"
  key_name                    = "classkey"
  monitoring                  = "true"
  vpc_security_group_ids      = [aws_security_group.prod-sg.id]
  subnet_id                   = aws_subnet.sub2.id
  associate_public_ip_address = true
  ebs_block_device {
    device_name           = "/dev/xvda"
    volume_size           = "20"
    volume_type           = "gp2"
    delete_on_termination = false
  }

  tags = {
    Name = "RedHat Linux"
    Env  = "Production"
  }
}
