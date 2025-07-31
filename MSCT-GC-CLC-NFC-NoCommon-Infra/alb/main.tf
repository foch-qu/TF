module "config" {
    source = "../config"
}

resource "aws_alb" "alb_nfc_private" {
  name           = "clc-nfc-load-balancer-private"
  internal        = true
  subnets        = ["subnet-0a07021591da94479","subnet-0758819fbf08d4a90"]
  security_groups = [var.security_group_443_80_nfc.security_group_id]
}

resource "aws_alb" "alb_nfc_public" {
  name           = "clc-nfc-load-balancer-public"
  internal        = false
  subnets        = ["subnet-04294c16f4627eb98","subnet-0c8df50ec250304cf"]
  security_groups = [var.security_group_443_80_nfc.security_group_id]
}



resource "aws_alb_target_group" "alb_target_nfc_private" {
  name                = "alb-target-nfc-private"
  port                = 80
  protocol            = "HTTP"
  target_type         = "ip"
  vpc_id   = var.vpc_id_nfc
  health_check {
    path                = "/actuator/health"
    interval            = 100
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
  }
}


resource "aws_alb_target_group" "alb_target_nfc_private_backend" {
  name                = "alb-target-nfc-private-backend"
  port                = 80
  protocol            = "HTTP"
  target_type         = "ip"
  vpc_id   = var.vpc_id_nfc
  health_check {
    path                = "/actuator/health"
    interval            = 100
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
  }
}


resource "aws_alb_target_group" "alb_target_nfc_public" {
  name                = "alb-target-nfc-public"
  port                = 8080
  protocol            = "HTTP"
  target_type         = "ip"
  vpc_id   = var.vpc_id_nfc
  health_check {
    path                = "/nfc-service/actuator/health"
    interval            = 100
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
  }
}

data "aws_acm_certificate" "gc_clc_nfc_stg_private" {
  domain = "intranet.nfc-qa.123.com.cn"
}

data "aws_acm_certificate" "gc_clc_nfc_stg_public" {
  domain = "api.nfc-qa.123.com.cn"
}


resource "aws_alb_listener" "alb_listen_nfc_private" {
  load_balancer_arn = aws_alb.alb_nfc_private.arn
  port              = "443"
  protocol          = "HTTPS"

  certificate_arn = data.aws_acm_certificate.gc_clc_nfc_stg_private.arn
  

  default_action {
    target_group_arn = aws_alb_target_group.alb_target_nfc_private.arn
    type             = "forward"
  }
}


resource "aws_alb_listener" "alb_listen_nfc_private_backend" {
  load_balancer_arn = aws_alb.alb_nfc_private.arn
  port              = "8082"
  protocol          = "HTTPS"

  certificate_arn = data.aws_acm_certificate.gc_clc_nfc_stg_private.arn
  

  default_action {
    target_group_arn = aws_alb_target_group.alb_target_nfc_private_backend.arn
    type             = "forward"
  }
}



resource "aws_alb_listener" "alb_listen_nfc_public" {
  load_balancer_arn = aws_alb.alb_nfc_public.arn
  port              = "443"
  protocol          = "HTTPS"

  certificate_arn = data.aws_acm_certificate.gc_clc_nfc_stg_public.arn

  default_action {
    target_group_arn = aws_alb_target_group.alb_target_nfc_public.arn
    type             = "forward"
  }
}



# resource "aws_route53_record" "example" {
#   name    = "example"
#   zone_id = "zone-id"
#   type    = "A"
#   alias {
#     name                   = "example-alb-dns-name"
#     zone_id                = "zone-id"
#     evaluate_target_health = true
#   }
# }





# resource "aws_ecs_task_definition" "example" {
#   family                = "example"
#   execution_role_arn       = "arn:aws-cn:iam::034861587527:role/nodeAdapterEcsTaskExecutionRole"
#   task_role_arn            = "arn:aws-cn:iam::034861587527:role/nodeAdapterEcsTaskExecutionRole"
#   network_mode             = "awsvpc"
#   requires_compatibilities = ["FARGATE"]
#   cpu                      = "2048"
#   memory                   = "4096"
#   container_definitions = jsonencode([
#     {
#       name: "example",
#       image: "034861587527.dkr.ecr.cn-northwest-1.amazonaws.com.cn/repo-test-need-delete:latest",
#       portMappings: [{ containerPort: 8080 }],
#     },
#   ])
# }

# resource "aws_ecs_service" "example" {
#   name            = "example"
#   task_definition = aws_ecs_task_definition.example.arn
#   cluster         = "arn:aws-cn:ecs:cn-northwest-1:034861587527:cluster/temp-cluster"
#   desired_count   = 2
#   launch_type     = "FARGATE"
#    network_configuration {
#     security_groups  = ["sg-0e9b9aae91d44c338"]
#     subnets          = ["subnet-0b92dce2a3ad952e1"]
#     assign_public_ip = false
#   }
#   load_balancer {
#     target_group_arn = aws_alb_target_group.example.arn
#     container_name   = "example"
#     container_port   = 8080
#   }
# }







# resource "aws_cloudwatch_metric_alarm" "alpha_service_cpu_high" {
#   alarm_name = "${var.service_name}-cpu-utilization-above-80"
#   alarm_description = "This alarm monitors ${var.service_name} CPU utilization for scaling up"
#   comparison_operator = "GreaterThanOrEqualToThreshold"
#   evaluation_periods = "1"
#   metric_name = "CPUUtilization"
#   namespace = "AWS/ECS"
#   period = "120"
#   statistic = "Average"
#   threshold = "80"
#   alarm_actions = ["${aws_appautoscaling_policy.scale_up.arn}"]

#   dimensions {
#     ClusterName = "${var.cluster_name}"
#     ServiceName = "${var.service_name}"
#   }
# }

# # A CloudWatch alarm that monitors CPU utilization of containers for scaling down
# resource "aws_cloudwatch_metric_alarm" "alpha_service_cpu_low" {
#   alarm_name = "${var.service_name}-cpu-utilization-below-5"
#   alarm_description = "This alarm monitors ${var.service_name} CPU utilization for scaling down"
#   comparison_operator = "LessThanThreshold"
#   evaluation_periods = "1"
#   metric_name = "CPUUtilization"
#   namespace = "AWS/ECS"
#   period = "120"
#   statistic = "Average"
#   threshold = "5"
#   alarm_actions = ["${aws_appautoscaling_policy.scale_down.arn}"]

#   dimensions {
#     ClusterName = "${var.cluster_name}"
#     ServiceName = "${var.service_name}"
#   }
# }

# # A CloudWatch alarm that monitors memory utilization of containers for scaling up
# resource "aws_cloudwatch_metric_alarm" "alpha_service_memory_high" {
#   alarm_name = "${var.service_name}-memory-utilization-above-80"
#   alarm_description = "This alarm monitors ${var.service_name} memory utilization for scaling up"
#   comparison_operator = "GreaterThanOrEqualToThreshold"
#   evaluation_periods = "1"
#   metric_name = "MemoryUtilization"
#   namespace = "AWS/ECS"
#   period = "120"
#   statistic = "Average"
#   threshold = "80"
#   alarm_actions = ["${aws_appautoscaling_policy.scale_up.arn}"]

#   dimensions {
#     ClusterName = "${var.cluster_name}"
#     ServiceName = "${var.service_name}"
#   }
# }



# # A CloudWatch alarm that monitors memory utilization of containers for scaling down
# resource "aws_cloudwatch_metric_alarm" "alpha_service_memory_low" {
#   alarm_name = "test-memory-utilization-below-5"
#   alarm_description = "This alarm monitors application memory utilization for scaling down"
#   comparison_operator = "LessThanThreshold"
#   evaluation_periods = "1"
#   metric_name = "MemoryUtilization"
#   namespace = "AWS/ECS"
#   period = "120"
#   statistic = "Average"
#   threshold = "5"
#   alarm_actions = ["${aws_appautoscaling_policy.scale_down.arn}"]

#   dimensions {
#     ClusterName = "temp-cluster"
#     ServiceName = "example"
#   }
# }

# resource "aws_appautoscaling_target" "target" {

#   resource_id = "service/temp-cluster/example"
#   role_arn = "arn:aws-cn:iam::034861587527:role/nodeAdapterEcsTaskExecutionRole"
#   scalable_dimension = "ecs:service:DesiredCount"
#   min_capacity = "2"
#   max_capacity = "8"
# }

# resource "aws_appautoscaling_policy" "scale_up" {
#   name = "example-scale-up"
#   resource_id = "service/temp-cluster/example"
#   scalable_dimension = "ecs:service:DesiredCount"
#   adjustment_type = "ChangeInCapacity"
#   cooldown = 120
#   metric_aggregation_type = "Average"

#   step_adjustment {
#     metric_interval_lower_bound = 0
#     scaling_adjustment = 1
#   }


# }

# resource "aws_appautoscaling_policy" "scale_down" {
#   name = "example-scale-down"
#   resource_id = "service/temp-cluster/example"
#   scalable_dimension = "ecs:service:DesiredCount"
#   adjustment_type = "ChangeInCapacity"
#   cooldown = 120
#   metric_aggregation_type = "Average"

#   step_adjustment {
#     metric_interval_upper_bound = 0
#     scaling_adjustment = -1
#   }

# }