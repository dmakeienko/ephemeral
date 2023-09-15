resource "aws_db_subnet_group" "this" {
  name       = "${var.resource_name_prefix}-db-sn-gr1"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "${var.resource_name_prefix}-db-sn-gr1"
  }
}

resource "aws_db_instance" "main" {
  allocated_storage    = var.allocated_storage
  db_name              = var.db_name
  engine               = var.db_engine
  engine_version       = var.engine_version
  instance_class       = var.db_instance_tier
  username             = var.db_username
  password             = var.db_password
  skip_final_snapshot  = var.skip_final_snapshot
  db_subnet_group_name = "${var.resource_name_prefix}-db-sn-gr1"
  port                 = var.db_port

  tags = {
    Name = "${var.resource_name_prefix}-vpc1-db1"
  }

  depends_on = [aws_db_subnet_group.this]
}


resource "aws_security_group" "allow_tls" {
  name        = "allow trafic from minikube"
  description = "Allow HTTP inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = var.db_port
    to_port     = var.db_port
    protocol    = "tcp"
    cidr_blocks = var.allowed_network_cidr
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.resource_name_prefix}-vpc1-db1-sg1"
  }

}