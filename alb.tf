resource "aws_lb" "prod" {
  name               = "test-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.prod-sg.id]
  subnets            = [aws_subnet.sub3.id,aws_subnet.sub4.id]

  enable_deletion_protection = true

  tags = {
    Environment = "production"
  }
}
