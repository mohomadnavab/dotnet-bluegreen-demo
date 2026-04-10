###################################
# APPLICATION LOAD BALANCER
###################################

resource "aws_lb" "dotnet_alb" {

  name               = "dotnet-bluegreen-lb"
  internal           = false
  load_balancer_type = "application"

  security_groups = [
    aws_security_group.ec2_sg.id
  ]

  subnets = [
    aws_subnet.subnet1.id,
    aws_subnet.subnet2.id
  ]

  tags = {
    Name = "dotnet-bluegreen-lb"
  }
}


# Target Group

resource "aws_lb_target_group" "blue" {
  name = "blue-tg-demo"
  port = 5000
  protocol = "HTTP"
  vpc_id = aws_vpc.main.id

  health_check {
    protocol = "HTTP"
    port = "5000"
    path = "/"
    matcher = "200"
    interval = 30
    timeout = 5
    healthy_threshold = 2
    unhealthy_threshold = 2
  }

  tags = {
    name = "blue-target-group"
  }
  
}


# target group - Green

resource "aws_lb_target_group" "green" {
  name = "green-tg-demo"
  port = "5000"
  protocol = "HTTP"
  vpc_id = aws_vpc.main.id

  health_check {
    protocol = "HTTP"
    port = "5000"
    path = "/"
    matcher = "200"
    interval = 30
    timeout = 5
    healthy_threshold = 2
    unhealthy_threshold = 2
  }
  
}
###################################
# ALB LISTENER
###################################

resource "aws_lb_listener" "http" {

  load_balancer_arn = aws_lb.dotnet_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "forward"

    forward {

      target_group {
        arn    = aws_lb_target_group.blue.arn
        weight = 1
      }

      target_group {
        arn    = aws_lb_target_group.green.arn
        weight = 0
      }

      stickiness {
        enabled  = false
        duration = 1
      }

    }
  }
}
