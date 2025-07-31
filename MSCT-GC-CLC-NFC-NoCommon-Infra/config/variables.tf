terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.22.0"
    }
  }
}

variable "region" {
    type = string
    default = "cn-northwest-1"
}

variable "tags_default" {
  type = map(string)
  default = {


    "Application" = "CLC-NFC"                      #application name
    "Project" = "CLC-NFC"                            #project name
    "Environment" = "stg"                    #environment e.g. Deplyoment
    "ContactEmail" = ""
    "Purpose" = "stg"                             #purpose

  }
}



variable "env_prefix" {
  type = list
  default = ["dev", "qa", "stg","prod"]
}