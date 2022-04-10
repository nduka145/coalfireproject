resource "aws_launch_configuration" "launch_conf" {
  name_prefix   = "prod-configuration"
  image_id      = "ami-0015fcaa5516c75ed"
  instance_type = "t2.micro"
  key_name      = "classkey"
  ebs_block_device {
    device_name           = "/dev/xvda"
    volume_size           = "20"
    volume_type           = "gp2"
    delete_on_termination = false
  }
  user_data     = <<EOF
                #!/bin/bash -xe
                sudo yum upday -y
		sudo yum install -y httpd
		sudo systemctl start httpd
		sudo systemctl enable httpd
        	EOF
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "sgroup" {
  name                 = "asg-prod"
  launch_configuration = aws_launch_configuration.launch_conf.id
  availability_zones = ["us-east-1a,us-east-1b"]
  min_size             = 2
  max_size             = 6

  lifecycle {
    create_before_destroy = true
  }
}
