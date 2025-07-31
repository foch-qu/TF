module "config" {
    source = "../config"
}


#  source = "terraform-aws-modules/ecr/aws"
# resource "aws_ecr_repository" "images" {
#   count = "${length(var.images)}"
#   name  = "${var.images[count.index]}"
# }
resource "aws_ecr_repository" "images" {
  for_each = toset(var.ecr_images)
  name = each.value
}

# resource "aws_ecr_repository_policy" "imagespolicy" {
#   for_each = toset(var.ecr_images)
#   # repository = each.value
#   registry_id = "aws_ecr_repository.images.${each.value}.id"


#   policy = <<EOF
# {
#     "Version": "2008-10-17",
#     "Statement": [
#         {
#             "Sid": "new policy",
#             "Effect": "Allow",
#             "Principal": "*",
#             "Action": [
#                 "ecr:GetDownloadUrlForLayer",
#                 "ecr:BatchGetImage",
#                 "ecr:BatchCheckLayerAvailability",
#                 "ecr:PutImage",
#                 "ecr:InitiateLayerUpload",
#                 "ecr:UploadLayerPart",
#                 "ecr:CompleteLayerUpload",
#                 "ecr:DescribeRepositories",
#                 "ecr:GetRepositoryPolicy",
#                 "ecr:ListImages",
#                 "ecr:DeleteRepository",
#                 "ecr:BatchDeleteImage",
#                 "ecr:SetRepositoryPolicy",
#                 "ecr:DeleteRepositoryPolicy"
#             ]
#         }
#     ]
# }
# EOF
# }



