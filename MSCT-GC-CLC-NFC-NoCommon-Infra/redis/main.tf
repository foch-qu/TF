module "config" {
    source = "../config"
}




resource "aws_elasticache_cluster" "reds_nfc" {
  cluster_id           = "gc-clc-nfc-redis-test"
  engine               = "redis"
  node_type            = "cache.m4.xlarge"
  num_cache_nodes      = 1
  parameter_group_name = "default.redis6.x"
  engine_version       = "6.2"
  port                 = 6379
  subnet_group_name    = var.subnet_redis_nfc.name
  security_group_ids   = [var.security_group_6379_nfc.security_group_id]
}
