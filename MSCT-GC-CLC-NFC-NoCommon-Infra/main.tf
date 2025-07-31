module "config" {
    source = "./config"
}

# terraform {
#   required_version = ">= 0.12"
#   backend "s3" {
#     bucket = "terraform-status-nfc-stg-cn-northwest-1"
#     key = "myapp/state.tfstate"
#     region = "cn-northwest-1"
#   }
# }

provider "aws" {

    region = module.config.region
    access_key = "AKIAQQHPJTRDTAX7VXWY"
    secret_key = "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"
// access key id is stored in environment variable AWS_ACCESS_KEY_ID
// secret is stored in AWS_SECRET_ACCESS_KEY
// often defined in .bashrc or from CI/CD tool
    default_tags {
      tags = module.config.tags_default
    }
}

module "vpc" {
  source = "./vpc"
  privite_subnet_nfc_a = module.vpc.privite_subnet_nfc_a
 # public_subnet_nfc_a = module.vpc.public_subnet_nfc_a
}


module "security-group" {
  source = "./security-group"
  vpc_id_nfc = module.vpc.vpc_selected_nfc.id
}

# module "ec2" {
#   source = "./ec2"
#   public_subnet = module.vpc.public_subnet
#   security_group_22 = module.security-group.security_group_22
#   security_group_8080 = module.security-group.security_group_8080
#   security_group_443_80 = module.security-group.security_group_443_80
# }

# output "ec2_ip" {
#   value = module.ec2.ec2_ip
# }



module "iam_role" {
  source = "./iam_role"
}

# module "cloudwatch_loggroup" {
#   source = "./cloudwatch_loggroup"
# }
module "ecr" {
   source = "./ecr"
}


# module "sqs" {
#    source = "./sqs"
# }

module "s3" {
   source = "./s3"

}

module "redis" {
   source = "./redis"
   subnet_redis_nfc = module.vpc.subnet_redis_nfc
   
   security_group_6379_nfc = module.security-group.security_group_6379_nfc
   


}

module "RDS" {
   source = "./RDS"
   subnet_rds_nfc = module.vpc.subnet_rds_nfc
   
   security_group_3306_nfc = module.security-group.security_group_3306_nfc
   


}

module "alb" {
  source = "./alb"
  # security_group_443_80 = module.security-group.security_group_443_80
  # vpc_id = module.vpc.vpc_selected.id
  # public_subnet = module.vpc.public_subnet
  # privite_subnet = module.vpc.privite_subnet

   security_group_443_80_nfc = module.security-group.security_group_443_80_nfc
   vpc_id_nfc = module.vpc.vpc_selected_nfc.id
   #vpc_id_hkdc = module.vpc.vpc_selected_hkdc.id

}
module "ecs-nfc" {
   source = "./ecs-nfc"
    ecs_task_role = "arn:aws-cn:iam::034861587527:role/CLCNFCEcsTaskExecutionRole"
    security_group_8080 = module.security-group.security_group_8080_nfc
    security_group_8082 = module.security-group.security_group_8082_nfc
    security_group_80 = module.security-group.security_group_443_80_nfc
    privite_subnet_nfc = module.vpc.privite_subnet_nfc_a
    public_subnet_nfc = module.vpc.public_subnet_nfc_a
   #  alb_target_group = module.alb.alb_target_group
   #  alb_listener = module.alb.alb_listener
    ecs_task_execution_attach = module.iam_role.ecs_task_execution_attach
    # alb_listener = module.alb.alb_listen_sdc
    alb_target_group_public = module.alb.alb_target_nfc_public
    alb_target_group_private = module.alb.alb_target_nfc_private
    alb_target_group_private_backend = module.alb.alb_target_nfc_private_backend
    

}
