output "privite_subnet_nfc_a" {
  value = aws_subnet.privite_subnet_nfc_a
}

output "privite_subnet_nfc_b" {
  value = aws_subnet.privite_subnet_nfc_b
}

output "public_subnet_nfc_a" {
  value = aws_subnet.public_subnet_nfc_a
}

output "public_subnet_nfc_b" {
  value = aws_subnet.public_subnet_nfc_b
}



output "vpc_selected_nfc" {
  value = data.aws_vpc.vpc_nfc
}



output "subnet_redis_nfc" {
  value = aws_elasticache_subnet_group.subnet_redis_nfc
}

output "subnet_rds_nfc" {
  value = aws_db_subnet_group.subnet_rds_nfc
}
