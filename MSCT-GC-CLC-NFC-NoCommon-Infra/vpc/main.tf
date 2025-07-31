module "config" {
    source = "../config"
}

data "aws_vpc" "vpc_nfc" {
  id = var.vpc_id_nfc
}





resource "aws_subnet" "privite_subnet_nfc_a" {
  vpc_id            = data.aws_vpc.vpc_nfc.id
  availability_zone = "cn-northwest-1a"
  cidr_block        = var.private_subnets_cidr_zoneA_nfc
  map_public_ip_on_launch = true
  tags = {
    Name = "cn-northwest-1a-privite-subnet_nfc-test"
  }

}

resource "aws_subnet" "privite_subnet_nfc_b" {
  vpc_id            = data.aws_vpc.vpc_nfc.id
  availability_zone = "cn-northwest-1b"
  cidr_block        = var.private_subnets_cidr_zoneB_nfc
  map_public_ip_on_launch = true
  tags = {
    Name = "cn-northwest-1b-privite-subnet_nfc-test"
  }

}

resource "aws_subnet" "public_subnet_nfc_a" {
  vpc_id            = data.aws_vpc.vpc_nfc.id
  availability_zone = "cn-northwest-1a"
  cidr_block        = var.public_subnets_cidr_zoneA_nfc
  map_public_ip_on_launch = true
  tags = {
    Name = "cn-northwest-1a-public_subnet_nfc-test"
  }
}

resource "aws_subnet" "public_subnet_nfc_b" {
  vpc_id            = data.aws_vpc.vpc_nfc.id
  availability_zone = "cn-northwest-1b"
  cidr_block        = var.public_subnets_cidr_zoneB_nfc
  map_public_ip_on_launch = true
  tags = {
    Name = "cn-northwest-1b-public_subnet_nfc-test"
  }
}




resource "aws_route_table_association" "bound_privite_nfc" {
  subnet_id      = aws_subnet.privite_subnet_nfc_a.id
  route_table_id = aws_route_table.privite_nfc.id

}

resource "aws_route_table_association" "bound_privite_nfc_b" {
  subnet_id      = aws_subnet.privite_subnet_nfc_b.id
  route_table_id = aws_route_table.privite_nfc.id

}


resource "aws_route_table_association" "bound_public_nfc" {
  subnet_id      = aws_subnet.public_subnet_nfc_a.id
  route_table_id = aws_route_table.public_nfc.id
}

resource "aws_route_table_association" "bound_public_nfc_b" {
  subnet_id      = aws_subnet.public_subnet_nfc_b.id
  route_table_id = aws_route_table.public_nfc.id
}



resource "aws_route_table_association" "bound_public_cnnw1az1_nfc" {
  subnet_id      = "subnet-036ea15f4bddeb98d"
  route_table_id = aws_route_table.public_nfc.id
}
resource "aws_route_table_association" "bound_public_cnnw1az2_nfc" {
  subnet_id      = "subnet-014b9c755955dd3e7"
  route_table_id = aws_route_table.public_nfc.id
}
resource "aws_route_table_association" "bound_public_cnnw1az3_nfc" {
  subnet_id      = "subnet-07b39908cb697a002"
  route_table_id = aws_route_table.public_nfc.id
}


# resource "aws_internet_gateway" "internet_gateway" {
#   vpc_id = data.aws_vpc.selected.id
#   tags = {
#     Name = "route-internet-gateway"
#   }
# }


resource "aws_route_table" "public_nfc" {
  
  vpc_id = data.aws_vpc.vpc_nfc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway_nfc.id
  }
  route {
    cidr_block = "10.0.0.0/8"
    transit_gateway_id = "${var.transit_gateway}"
  }
  route {
    cidr_block = "146.197.0.0/21"
    transit_gateway_id = "${var.transit_gateway}"
  }
    route {
    cidr_block = "146.197.8.0/23"
    transit_gateway_id = "${var.transit_gateway}"
  }
    route {
    cidr_block = "146.197.20.0/22"
    transit_gateway_id = "${var.transit_gateway}"
  }
    route {
    cidr_block = "146.197.48.0/24"
    transit_gateway_id = "${var.transit_gateway}"
  }
    route {
    cidr_block = "146.197.54.0/24"
    transit_gateway_id = "${var.transit_gateway}"
  }
    route {
    cidr_block = "146.197.64.0/23"
    transit_gateway_id = "${var.transit_gateway}"
  }
    route {
    cidr_block = "146.197.88.0/22"
    transit_gateway_id = "${var.transit_gateway}"
  }
    route {
    cidr_block = "146.197.118.0/24"
    transit_gateway_id = "${var.transit_gateway}"
  }
    route {
    cidr_block = "146.197.132.0/23"
    transit_gateway_id = "${var.transit_gateway}"
  }
    route {
    cidr_block = "146.197.212.0/22"
    transit_gateway_id = "${var.transit_gateway}"
  }
    route {
    cidr_block = "146.197.251.0/24"
    transit_gateway_id = "${var.transit_gateway}"
  }
    route {
    cidr_block = "172.16.0.0/12"
    transit_gateway_id = "${var.transit_gateway}"
  }    
  route {
    cidr_block = "192.168.0.0/16"
    transit_gateway_id = "${var.transit_gateway}"
  }

 
  tags = {
    Name: "Intenet-route-nfc"
  }

  depends_on = [aws_internet_gateway.internet_gateway_nfc]
}
resource "aws_route_table" "privite_nfc" {
  vpc_id = data.aws_vpc.vpc_nfc.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway_nfc.id
  }
  route {
    cidr_block = "10.0.0.0/8"
    transit_gateway_id = "${var.transit_gateway}"
  }
  
  route {
    cidr_block = "146.197.0.0/21"
    transit_gateway_id = "${var.transit_gateway}"
  }
    route {
    cidr_block = "146.197.8.0/23"
    transit_gateway_id = "${var.transit_gateway}"
  }
    route {
    cidr_block = "146.197.20.0/22"
    transit_gateway_id = "${var.transit_gateway}"
  }
    route {
    cidr_block = "146.197.48.0/24"
    transit_gateway_id = "${var.transit_gateway}"
  }
    route {
    cidr_block = "146.197.54.0/24"
    transit_gateway_id = "${var.transit_gateway}"
  }
    route {
    cidr_block = "146.197.64.0/23"
    transit_gateway_id = "${var.transit_gateway}"
  }
    route {
    cidr_block = "146.197.88.0/22"
    transit_gateway_id = "${var.transit_gateway}"
  }
    route {
    cidr_block = "146.197.118.0/24"
    transit_gateway_id = "${var.transit_gateway}"
  }
    route {
    cidr_block = "146.197.132.0/23"
    transit_gateway_id = "${var.transit_gateway}"
  }
    route {
    cidr_block = "146.197.212.0/22"
    transit_gateway_id = "${var.transit_gateway}"
  }
    route {
    cidr_block = "146.197.251.0/24"
    transit_gateway_id = "${var.transit_gateway}"
  }
    route {
    cidr_block = "172.16.0.0/12"
    transit_gateway_id = "${var.transit_gateway}"
  }    
  route {
    cidr_block = "192.168.0.0/16"
    transit_gateway_id = "${var.transit_gateway}"
  }
  

 
  tags = {
    Name: "Privite-route-nfc"
  }
  depends_on = [aws_nat_gateway.nat_gateway_nfc]

}

resource "aws_internet_gateway" "internet_gateway_nfc" {
  vpc_id = data.aws_vpc.vpc_nfc.id

  tags = {
    Name = "internetg_gateway_nfc"
  }
}
resource "aws_eip" "nat_gateway_ip_nfc" {
  vpc              = true
  # public_ipv4_pool = "ipv4pool-ec2-012345"
  
}
resource "aws_nat_gateway" "nat_gateway_nfc" {
  allocation_id = aws_eip.nat_gateway_ip_nfc.id
  subnet_id     = aws_subnet.public_subnet_nfc_a.id
  tags = {
    Name = "GW NAT NFC"
    "abc-distributionlist" = "lst-gcscops@123.com" 
    "abc-domain"           = "MSCT" 
    "abc-owner"            = "111111@123.com" 
  }

}





resource "aws_elasticache_subnet_group" "subnet_redis_nfc" {
  name        = "elasticache-subnet-group-nfc"
  description = "Elasticache Redis subnet group nfc"
  subnet_ids  = [aws_subnet.privite_subnet_nfc_a.id,aws_subnet.privite_subnet_nfc_b.id]
}

resource "aws_db_subnet_group" "subnet_rds_nfc" {
  name        = "rds-subnet-group-nfc"
  description = "RDS subnet group nfc"
  subnet_ids  = [aws_subnet.privite_subnet_nfc_b.id,aws_subnet.privite_subnet_nfc_a.id]
}