module "config" {
    source = "../config"
}

module "security_group_443_80_nfc" {
  #source = "terraform-aws-modules/security-group/aws"
  source = "git@github.com:terraform-aws-modules/terraform-aws-security-group.git"
  name        = "https-443-80-tcp_nfc"
  description = "Security group for HTTP & HTTPS visit"
  vpc_id      = var.vpc_id_nfc

  ingress_cidr_blocks      = ["10.0.0.0/8"]
  ingress_rules            = ["https-443-tcp","http-80-tcp"]
  egress_rules            = ["all-all"]


}

module "security_group_22_nfc" {
  #source = "terraform-aws-modules/security-group/aws"
  source = "git@github.com:terraform-aws-modules/terraform-aws-security-group.git"

  name        = "https-22-tcp_nfc"
  description = "Security group for ssh visit"
  vpc_id      = var.vpc_id_nfc

  ingress_cidr_blocks      = ["10.0.0.0/8"]
  ingress_rules            = ["ssh-tcp"]
  egress_rules            = ["all-all"]


}

module "security_group_6379_nfc" {
  #source = "terraform-aws-modules/security-group/aws"
  source = "git@github.com:terraform-aws-modules/terraform-aws-security-group.git"
  

  name        = "https-6379-tcp_nfc"
  description = "Security group for redis visit"
  vpc_id      = var.vpc_id_nfc

  ingress_cidr_blocks      = ["10.0.0.0/8"]
  ingress_rules            = ["redis-tcp"]
  egress_rules            = ["all-all"]


}

module "security_group_3306_nfc" {
  #source = "terraform-aws-modules/security-group/aws"
  source = "git@github.com:terraform-aws-modules/terraform-aws-security-group.git"

  name        = "https-3306-tcp_nfc"
  description = "Security group for rds visit"
  vpc_id      = var.vpc_id_nfc

  ingress_cidr_blocks      = ["10.0.0.0/8"]
  #ingress_rules            = ["db-tcp"]
    ingress_with_cidr_blocks = [
    {
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      description = "Security group for rds visit"
      cidr_blocks = "0.0.0.0/0"
    }

  ]
  egress_rules            = ["all-all"]


}

module "security_group_8080_nfc" {
  #source = "terraform-aws-modules/security-group/aws"
  source = "git@github.com:terraform-aws-modules/terraform-aws-security-group.git"

  name        = "http-8080-tcp_nfc"
  description = "Security group for application visit"
  vpc_id      = var.vpc_id_nfc

  ingress_cidr_blocks      = ["10.0.0.0/8"]
  ingress_with_cidr_blocks = [
    {
      from_port   = 8080
      to_port     = 8080
      protocol    = "tcp"
      description = "clc-nfc"
      cidr_blocks = "0.0.0.0/0"
    }

  ]
  egress_rules = ["all-all"]


}

module "security_group_8082_nfc" {
  #source = "terraform-aws-modules/security-group/aws"
  source = "git@github.com:terraform-aws-modules/terraform-aws-security-group.git"

  name        = "http-8082-tcp_nfc"
  description = "Security group for application visit"
  vpc_id      = var.vpc_id_nfc

  ingress_cidr_blocks      = ["10.0.0.0/8"]
  ingress_with_cidr_blocks = [
    {
      from_port   = 8082
      to_port     = 8082
      protocol    = "tcp"
      description = "clc-nfc"
      cidr_blocks = "0.0.0.0/0"
    }

  ]
  egress_rules = ["all-all"]


}

  


# module "security_group_443_80_hkdc" {
#   source = "terraform-aws-modules/security-group/aws"

#   name        = "https-443-80-tcp_hkdc"
#   description = "Security group for HTTP & HTTPS visit"
#   vpc_id      = var.vpc_id_hkdc

#   ingress_cidr_blocks      = ["0.0.0.0/0"]
#   ingress_rules            = ["https-443-tcp","http-80-tcp"]
#   egress_rules            = ["all-all"]



# }

# module "security_group_22_hkdc" {
#   source = "terraform-aws-modules/security-group/aws"

#   name        = "https-22-tcp_hkdc"
#   description = "Security group for ssh visit"
#   vpc_id      = var.vpc_id_hkdc

#   ingress_cidr_blocks      = ["0.0.0.0/0"]
#   ingress_rules            = ["ssh-tcp"]
#   egress_rules            = ["all-all"]

 
# }

# module "security_group_6379_hkdc" {
#   source = "terraform-aws-modules/security-group/aws"

#   name        = "https-6379-tcp_hkdc"
#   description = "Security group for redis visit"
#   vpc_id      = var.vpc_id_hkdc

#   ingress_cidr_blocks      = ["0.0.0.0/0"]
#   ingress_rules            = ["redis-tcp"]
#   egress_rules            = ["all-all"]

   
  
# }

# module "security_group_8080_hkdc" {
#   source = "terraform-aws-modules/security-group/aws"

#   name        = "http-8080-tcp_hkdc"
#   description = "Security group for application visit"
#   vpc_id      = var.vpc_id_hkdc

#   ingress_cidr_blocks      = ["0.0.0.0/0"]
#   ingress_with_cidr_blocks = [
#     {
#       from_port   = 8080
#       to_port     = 8080
#       protocol    = "tcp"
#       description = "node-adapter"
#       cidr_blocks = "0.0.0.0/0"
#     }

#   ]
#   egress_rules = ["all-all"]

    
# }

  
