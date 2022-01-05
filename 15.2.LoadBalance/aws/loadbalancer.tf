
resource "aws_autoscaling_group" "ags-web" {
  name                = "terraform-web-asg"
  vpc_zone_identifier = [aws_subnet.public1.id, aws_subnet.public2.id]
  desired_capacity = 3
  min_size         = 3
  max_size         = 3

  health_check_grace_period = 60
  health_check_type         = "ELB"
  force_delete              = true

  target_group_arns = [aws_lb_target_group.web-tg.arn]

  launch_template {
    id = aws_launch_template.ec2_template1.id

  }

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [aws_lb.alb1, aws_lb_target_group.web-tg]
}

resource "aws_autoscaling_policy" "web_policy_up" {
  name                   = "web_policy_up"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.ags-web.name
}

resource "aws_cloudwatch_metric_alarm" "web_cpu_alarm_up" {
  alarm_name          = "web_cpu_alarm_up"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "60"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.ags-web.name
  }

  alarm_description = "This metric monitor EC2 instance CPU utilization"
  alarm_actions     = [aws_autoscaling_policy.web_policy_up.arn]
}

resource "aws_autoscaling_policy" "web_policy_down" {
  name                   = "web_policy_down"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.ags-web.name
}

resource "aws_cloudwatch_metric_alarm" "web_cpu_alarm_down" {
  alarm_name          = "web_cpu_alarm_down"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "10"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.ags-web.name
  }

  alarm_description = "This metric monitor EC2 instance CPU utilization"
  alarm_actions     = [aws_autoscaling_policy.web_policy_down.arn]
}


resource "aws_lb_target_group" "web-tg" {
  name                          = "web-lb-tg"
  port                          = 80
  protocol                      = "HTTP"
  vpc_id                        = aws_vpc.vpc1.id
  load_balancing_algorithm_type = "round_robin"
  target_type                   = "instance"

}


resource "aws_lb" "alb1" {
  name                       = "application-lb1"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.allow_http.id]
  subnets                    = [aws_subnet.public1.id, aws_subnet.public2.id]
  enable_deletion_protection = false

  tags = {
    Environment = "production"
  }
}


resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.alb1.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web-tg.arn
  }
}