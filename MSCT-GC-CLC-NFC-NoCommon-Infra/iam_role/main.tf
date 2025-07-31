# data "aws_iam_policy_document" "ecs_task_execution_role" {
#   version = "2012-10-17"
#   statement {
#     sid     = ""
#     effect  = "Allow"
#     actions = ["sts:AssumeRole"]

#     principals {
#       type        = "Service"
#       identifiers = ["ecs-tasks.amazonaws.com"]
#     }
#   }
# }


# resource "aws_iam_role" "ecsrole" {
#   name                = "nodeAdapterEcsTaskExecutionRole"
#   assume_role_policy  = aws_iam_role_policy.ecs_policy.policy
  
# }
output "ecs_task_execution_attach" {
   value = aws_iam_role.test_role
}

resource "aws_iam_role" "test_role" {
  name = "CLCNFCEcsTaskExecutionRole"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
          Service = "ecs-tasks.amazonaws.com"
          
        }
      },
    ]
  })

  tags = {
    tag-key = "tag-value"
  }
}

resource "aws_iam_role_policy" "ecs_policy" {
  name = "ecsExecutionpolicy"
  role = aws_iam_role.test_role.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:*",
          "s3:*",
          "s3-object-lambda:*",
          "sqs:*",
          "ecs:*",
          "elasticache:*",
          "ecr:*",
          "cloudwatch:*",
          "logs:*"

        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}




# # ## ECS task execution role data
# data "aws_iam_policy_document" "ecs_task_execution_role" {
#   version = "2012-10-17"
#   statement {
#     sid     = ""
#     effect  = "Allow"
#     actions = ["sts:AssumeRole"]

#     principals {
#       type        = "Service"
#       identifiers = ["ecs-tasks.amazonaws.com"]
#     }
#   }
# }

# #ECS task execution role
# resource "aws_iam_role" "ecs_task_execution_role" {
#   name               = var.ecs_task_execution_role
#   assume_role_policy = data.aws_iam_policy_document.ecs_task_execution_role.json
# }

# variable "iam_policy_arn" {
#   description = "IAM Policy to be attached to role"
#   type = list
#   default = ["arn:aws-cn:iam::aws:policy/AmazonS3FullAccess"]
# }

# resource "aws_iam_role_policy_attachment" "role-policy-attachment" {
#   role       = aws_iam_role.ecs_task_execution_role.name
#   count      = "${length(var.iam_policy_arn)}"
#   policy_arn = "${var.iam_policy_arn[count.index]}"
# }



# # ECS task execution role policy attachment
# resource "aws_iam_role_policy_attachment" "ecs_task_execution_role" {
#   role       = aws_iam_role.ecs_task_execution_role.name
#   policy_arn = "arn:aws-cn:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
# }

# resource "aws_iam_role_policy_attachment" "s3_full_access" {
#   role       = aws_iam_role.ecs_task_execution_role.name
#   policy_arn = "arn:aws-cn:iam::aws:policy/AmazonS3FullAccess"
# }

# resource "aws_iam_role_policy_attachment" "ec2_full_access" {
#   role       = aws_iam_role.ecs_task_execution_role.name
#   policy_arn = "arn:aws-cn:iam::aws:policy/AmazonEC2FullAccess"
# }

# resource "aws_iam_role_policy_attachment" "ecr_read_only" {
#   role       = aws_iam_role.ecs_task_execution_role.name
#   policy_arn = "arn:aws-cn:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
# }

# resource "aws_iam_role_policy_attachment" "sqs_full_access" {
#   role       = aws_iam_role.ecs_task_execution_role.name
#   policy_arn = "arn:aws-cn:iam::aws:policy/AmazonSQSFullAccess"
# }

# resource "aws_iam_role_policy_attachment" "elasticache_full_access" {
#   role       = aws_iam_role.ecs_task_execution_role.name
#   policy_arn = "arn:aws-cn:iam::aws:policy/AmazonElastiCacheFullAccess"
# }


# output "ecs_task_role" {
#   value = aws_iam_role.ecs_task_execution_role
# }
