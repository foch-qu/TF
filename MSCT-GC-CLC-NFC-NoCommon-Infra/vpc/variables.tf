
variable "avail_zone" {
  default = ["cn-north-1a", "cn-north-1b", "cn-north-1c"]
}

# variable "vpc_cidr_block" {
#   default = "10.92.170.0/24"
# }
# variable "subnet_cidr_block" {
#   type = string
#   default = "10.92.170.0/24"
# }


variable "private_subnets_cidr_zoneA_nfc" {
  default = "10.65.118.0/25"
} 

variable "public_subnets_cidr_zoneA_nfc" {
  default = "10.65.119.0/25"
}

variable "private_subnets_cidr_zoneB_nfc" {
  default = "10.65.118.128/25"
} 

variable "public_subnets_cidr_zoneB_nfc" {
  default = "10.65.119.128/25"
}

variable "vpc_id_nfc" {
  default = "vpc-02ef9167c8369aa50"
}

# variable "vpc_id_hkdc" {
#   default = "vpc-0cf684a49a04c01a3"
# }

variable "transit_gateway" {
  default = "tgw-07928b3534a4283c3"
}

variable "abc_internal_ip_list" {
  default = [
    "10.0.0.0/8",
    "146.197.0.0/21",
    "146.197.8.0/23",
    "146.197.20.0/22",
    "146.197.48.0/24",
    "146.197.54.0/24",
    "146.197.64.0/23",
    "146.197.88.0/22",
    "146.197.118.0/24",
    "146.197.132.0/23",
    "146.197.212.0/22",
    "146.197.251.0/24",
    "172.16.0.0/12",
    "192.168.0.0/16"]
}


variable "privite_subnet_nfc_a" {
  default = "subnet-0a07021591da94479"
  description = "privite_subnet_nfc_a"
}

