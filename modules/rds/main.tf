############################################
# modules/rds/main.tf
############################################

resource "aws_db_subnet_group" "this" {
  name       = "${var.name}-db-subnets"
  subnet_ids = var.db_subnet_ids
  tags       = var.tags
}

resource "aws_security_group" "db" {
  name        = "${var.name}-rds-sg"
  description = "RDS security group"
  vpc_id      = var.vpc_id
  tags        = var.tags
}

# EKS 노드 SG에서만 DB 접근 허용 (3306)
resource "aws_security_group_rule" "db_in_3306" {
  for_each = { for idx, sg_id in var.allowed_sg_ids : tostring(idx) => sg_id }

  type                     = "ingress"
  security_group_id        = aws_security_group.db.id
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = each.value
}

resource "aws_security_group_rule" "db_out_all" {
  type              = "egress"
  security_group_id = aws_security_group.db.id
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

############################################
# ✅ UTF-8 (utf8mb4) 강제용 Parameter Group
############################################
resource "aws_db_parameter_group" "this" {
  name   = "${var.name}-rds-pg"
  family = var.parameter_group_family
  tags   = var.tags

  # 서버 기본 문자셋/콜레이션
  parameter {
    name  = "character_set_server"
    value = "utf8mb4"
  }

  parameter {
    name  = "collation_server"
    value = "utf8mb4_unicode_ci"
  }

  # (연결/클라이언트 계열) - 환경에 따라 도움이 됨
  parameter {
    name  = "character_set_client"
    value = "utf8mb4"
  }

  parameter {
    name  = "character_set_connection"
    value = "utf8mb4"
  }

  parameter {
    name  = "character_set_results"
    value = "utf8mb4"
  }

  # 타임존도 같이(원하면 유지, 싫으면 제거)
  parameter {
    name  = "time_zone"
    value = "Asia/Seoul"
  }
}

############################################
# RDS Instance
############################################
resource "aws_db_instance" "this" {
  identifier = "${var.name}-rds"

  engine         = var.engine
  engine_version = var.engine_version
  instance_class = var.instance_class

  allocated_storage = var.allocated_storage
  storage_type      = var.storage_type

  db_name  = var.db_name
  username = var.username
  password = var.password
  port     = var.port

  db_subnet_group_name   = aws_db_subnet_group.this.name
  vpc_security_group_ids = [aws_security_group.db.id]


  parameter_group_name = aws_db_parameter_group.this.name

  # 운영 옵션
  publicly_accessible   = false
  multi_az              = var.multi_az
  deletion_protection   = var.deletion_protection
  skip_final_snapshot   = var.skip_final_snapshot
  apply_immediately     = var.apply_immediately
  backup_retention_period = var.backup_retention_period

  # 로그(원하면 켜기)
  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports

  tags = var.tags
}

############################################
# outputs
############################################
output "rds_endpoint" {
  value = aws_db_instance.this.endpoint
}

output "rds_address" {
  value = aws_db_instance.this.address
}

output "rds_port" {
  value = aws_db_instance.this.port
}

output "rds_security_group_id" {
  value = aws_security_group.db.id
}

output "rds_parameter_group" {
  value = aws_db_parameter_group.this.name
}
