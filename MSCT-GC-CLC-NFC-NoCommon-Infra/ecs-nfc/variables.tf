
variable "fargate_cpu" {
  default     = "512"
  description = "fargate instacne CPU units to provision,my requirent 1 vcpu so gave 1024"
}

variable "fargate_memory" {
  default     = "4096"
  description = "Fargate instance memory to provision (in MiB) not MB"
}

variable "ecs_task_role" {}

# variable "privite_subnet_sdc" {}


variable "ecr_images" {
  type = list(string)
  default = [
    "gc-clc-nfc-backend-test",
    "gc-clc-nfc-frontend-test",
    "gc-clc-nfc-service-test"
  ]
}



# variable "privite_subnet_nfc" {
#   type = list
#   default = ["subnet-0a07021591da94479","subnet-0758819fbf08d4a90"]
# }

variable "security_group_8080" {}
variable "alb_target_group_public" {}
variable "alb_target_group_private" {}
variable "alb_target_group_private_backend" {}
variable "security_group_8082" {}
variable "security_group_80" {}
variable "privite_subnet_nfc" {}
variable "public_subnet_nfc" {}



variable "app_image" {
  default     = "nginx:latest"
  description = "docker image to run in this ECS cluster"
}

variable "app_port_list" {
  #   type = map(object({
  #   port     = string

  # }))
  # # default     = "8080"
  # # description = "portexposed on the docker image"
  #   default = {
  #   "80" = {
	#       port     = "80" 
  #   }			
  #   "8082" = {
	#       port     = "8082" 

  #   }		
  #   "8080" = {
	#       port     = "8080" 
  #   }								

  # }
    type    = list(string)
   default = ["8080", "8082", "80"]
}

variable "aws_region" {
  default     = "cn-northwest-1"
  description = "aws region where our resources going to create choose"
  #replace the region as suits for your requirement
}

# variable "app_count" {
#   default     = "2" #choose 2 bcz i have choosen 2 AZ
#   description = "numer of docker containers to run"
# }

# variable "alb_listener" {}
variable "ecs_task_execution_attach" {}
variable "account" {
  default = "034861587527"
}
variable "region" {
  default = "cn-northwest-1"
}

variable "env" {
  default = "test"
}


variable "application_list_nfc_frontend" {
  type = map(object({
    name     = string
    #accesskey  = string
    cpu = string
    memory = string
    count  = string
    max_autoscaling  = string
    min_autoscaling  = string
    port  = string
  }))
  default = {
        "frontend-test" = {
	      name     = "frontend-test" 
        cpu = 512
        memory = 4096,
        count  = 1
        max_autoscaling  = 4
        min_autoscaling  = 2
        port = 80

    }								

  }
}

variable "application_list_nfc_backend" {
  type = map(object({
    name     = string
    #accesskey  = string
    cpu = string
    memory = string
    count  = string
    max_autoscaling  = string
    min_autoscaling  = string
    port  = string
  }))
  default = {
    "backend-test" = {
	      name     = "backend-test" 
        cpu = 512
        memory = 4096,
        count  = 1
        max_autoscaling  = 4
        min_autoscaling  = 2
        port = 8082

    }			


    }								

  }




variable "application_api_list_nfc" {
  type = map(object({
    name     = string
    #accesskey  = string
    cpu = string
    memory = string
    count  = string
    max_autoscaling  = string
    min_autoscaling  = string
    port  = string
  }))
  default = {
		
        "service-test" = {
	      name     = "service-test" 
        cpu = 512
        memory = 4096,
        count  = 2
        max_autoscaling  = 4
        min_autoscaling  = 2
        port = 8080

    }		
							

  }
}


variable "application_list_nfc" {
  type = map(object({
    name     = string
    #accesskey  = string
    cpu = string
    memory = string
    count  = string
    max_autoscaling  = string
    min_autoscaling  = string
    port  = string
  }))
  default = {
		
        "service-test" = {
	      name     = "service-test" 
        cpu = 512
        memory = 4096,
        count  = 2
        max_autoscaling  = 4
        min_autoscaling  = 2
        port = 8080

    }		

        "backend-test" = {
	      name     = "backend-test" 
        cpu = 512
        memory = 4096,
        count  = 1
        max_autoscaling  = 4
        min_autoscaling  = 2
        port = 8082

    }	


            "frontend-test" = {
	      name     = "frontend-test" 
        cpu = 512
        memory = 4096,
        count  = 1
        max_autoscaling  = 4
        min_autoscaling  = 2
        port = 80

    }		
							

  }
}




# variable "fargate_cpu" {
#   default     = "1024"
#   description = "fargate instacne CPU units to provision,my requirent 1 vcpu so gave 1024"
# }

# variable "fargate_memory" {
#   default     = "2048"
#   description = "Fargate instance memory to provision (in MiB) not MB"
# }