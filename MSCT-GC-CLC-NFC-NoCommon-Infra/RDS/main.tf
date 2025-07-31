module "config" {
    source = "../config"
}

resource "aws_db_instance" "rds_nfc" {
 identifier              = "gc-clc-nfc-rds-test"
 instance_class          = "db.m4.2xlarge"
 engine                  = "MySQL"
 engine_version          = "8.0.33"
 allocated_storage       = 200
 storage_type            = "gp3"
 db_name                 = "nfctest"
 username                = "admin"
 password                = "ntDiFfWwyh5j7bjZ"
 ca_cert_identifier      = "rds-ca-rsa2048-g1"
 storage_encrypted       = true
 port                    = 3306
 #skip_final_snapshot     = false
 db_subnet_group_name    = var.subnet_rds_nfc.name
 vpc_security_group_ids  = [var.security_group_3306_nfc.security_group_id]
  
}
