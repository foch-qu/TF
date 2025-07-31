module "config" {
    source = "../config"
}

resource "aws_ecs_cluster" "oms-cluster" {
  name = "OMS-cluster"
}


resource "aws_ecs_task_definition" "nfc-test-def" {
  for_each = var.application_list_nfc
  family = "gc-clc-nfc-${each.value["name"]}"
  execution_role_arn       = "arn:aws-cn:iam::034861587527:role/nodeAdapterEcsTaskExecutionRole"
  task_role_arn            = "arn:aws-cn:iam::034861587527:role/nodeAdapterEcsTaskExecutionRole"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.fargate_cpu
  memory                   = var.fargate_memory
  container_definitions    = jsonencode([
    {
      "name" : "${each.value["name"]}",
      "image": "${var.account}.dkr.ecr.${var.region}.amazonaws.com.cn/gc-clc-nfc-${each.value["name"]}:latest",
      "cpu": "${tonumber(each.value["cpu"])}",
      "memory": "${tonumber(each.value["memory"])}",
      "networkMode": "awsvpc",
      "environment": [
        {
          "name": "APP",
          "value": "${each.value["name"]}"
        },
        {
          "name": "RUN_ENV",
          "value": "${var.env}"
        },
        {
          "name": "SERVER_REGION",
          "value": "${var.region}"
        },
        {
          "name": "SERVER_GROUP",
          "value": "${each.value["name"]}"
        },
        {
          "name": "AWS_ACCOUNT_ID",
          "value": "${var.account}"
        },
        {
          "name": "APP_GROUP",
          "value": "goal-gc"
        },
      ],
      "ulimits": [
        {
          "name": "nofile",
          "softLimit": 65535,
          "hardLimit": 65535
        }
      ],
      "portMappings": [
        {
          "containerPort": 8080,
          "hostPort": 8080
        },
        {
          "containerPort": 8082,
          "hostPort": 8082
        },
                {
          "containerPort": 80,
          "hostPort": 80
        }
        

      ],
      "logConfiguration": {
                "logDriver": "awslogs",
                "options": {
                    "awslogs-create-group": "true",
                    "awslogs-group": "/ecs/",
                    "awslogs-region": "cn-northwest-1",
                    "awslogs-stream-prefix": "ecs"
                },
                "secretOptions": []
            }
    }
    
  ])
}




resource "aws_ecs_service" "nfc-service" {
  for_each = var.application_list_nfc_frontend
  name = "gc-clc-nfc-${each.value["name"]}-ecs-service"
  cluster         = aws_ecs_cluster.nfc-cluster.id
  task_definition = "${aws_ecs_task_definition.nfc-test-def[each.key].arn}"
  desired_count   = "${each.value["count"]}"
  launch_type     = "FARGATE"


  network_configuration {
    security_groups  = [var.security_group_8082.security_group_id,var.security_group_80.security_group_id]
    subnets          = var.privite_subnet_nfc.*.id
    assign_public_ip = false
  }
  load_balancer {
    
    
    target_group_arn = var.alb_target_group_private.arn
    container_name   = "frontend-test"
    container_port   = "80"
  }

}


resource "aws_ecs_service" "nfc-service-backend" {
  for_each = var.application_list_nfc_backend
  name = "gc-clc-nfc-${each.value["name"]}-ecs-service"
  cluster         = aws_ecs_cluster.nfc-cluster.id
  task_definition = "${aws_ecs_task_definition.nfc-test-def[each.key].arn}"
  desired_count   = "${each.value["count"]}"
  launch_type     = "FARGATE"


  network_configuration {
    security_groups  = [var.security_group_8082.security_group_id]
    subnets          = var.privite_subnet_nfc.*.id
    assign_public_ip = false
  }
  load_balancer {
    
    
    target_group_arn = var.alb_target_group_private_backend.arn
    container_name   = "backend-test"
    container_port   = "8082"
  }

}

resource "aws_ecs_service" "nfc-api-service" {
  for_each = var.application_api_list_nfc
  name = "gc-clc-nfc-service-test-ecs-service"
  cluster         = aws_ecs_cluster.nfc-cluster.id
  task_definition = "${aws_ecs_task_definition.nfc-test-def[each.key].arn}"
  desired_count   = "${each.value["count"]}"
  launch_type     = "FARGATE"


  network_configuration {
    security_groups  = [var.security_group_8080.security_group_id]
    subnets          = var.public_subnet_nfc.*.id
    assign_public_ip = true
  }
  load_balancer {
    
    target_group_arn = var.alb_target_group_public.arn
    container_name   = "service-test"
    container_port   = "8080"
  }

}




#   # load_balancer {
#   #   target_group_arn = var.alb_target_group.arn
#   #   container_name   = "${each.value["name"]}"
#   #   container_port   = var.app_port
#   # }

#   # depends_on = [var.alb_listener, var.ecs_task_execution_attach]
#   depends_on = [var.ecs_task_execution_attach]

# }





resource "aws_appautoscaling_target" "app" {
  for_each = var.application_list_nfc
  max_capacity       = "${each.value["max_autoscaling"]}"    
  min_capacity       = "${each.value["min_autoscaling"]}"
  resource_id        = "service/${aws_ecs_cluster.nfc-cluster.name}/${"gc-clc-nfc-${each.value["name"]}-ecs-service"}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

resource "aws_appautoscaling_policy" "app-cpu-scale-up" {
  for_each = var.application_list_nfc
  name = "cpu-scale-up"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.app[each.key].resource_id
  scalable_dimension = aws_appautoscaling_target.app[each.key].scalable_dimension
  service_namespace  = aws_appautoscaling_target.app[each.key].service_namespace

  target_tracking_scaling_policy_configuration {
    target_value       = 70
    disable_scale_in   = false
    scale_in_cooldown  = 300
    scale_out_cooldown = 300

    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }
  }
}

resource "aws_appautoscaling_policy" "app-memory-scaleup" {
  for_each = var.application_list_nfc
  name = "memory-scale-up"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.app[each.key].resource_id
  scalable_dimension = aws_appautoscaling_target.app[each.key].scalable_dimension
  service_namespace  = aws_appautoscaling_target.app[each.key].service_namespace
  target_tracking_scaling_policy_configuration {
    target_value       = 80
    disable_scale_in   = false
    scale_in_cooldown  = 300
    scale_out_cooldown = 300
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageMemoryUtilization"
    }
  }
}

