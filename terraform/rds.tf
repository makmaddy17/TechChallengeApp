resource "aws_db_subnet_group" "postgress-subnet" {
  name        = "mariadb-subnet"
  description = "RDS subnet group"
  subnet_ids  = [aws_subnet.main-private-1.id, aws_subnet.main-private-2.id]
}

resource "aws_db_parameter_group" "postgress-parameters" {
  name        = "postgres-parameters"
  family      = "postgres9.6"
  description = "postgres parameter group"

  parameter {
    name  = "max_allowed_packet"
    value = "16777216"
  }
}

resource "aws_db_instance" "mariadb" {
  allocated_storage       = 100
  engine                  = "postgres"
  engine_version          = "9.6.9"
  instance_class          = "db.t2.large"
  identifier              = "postgres"
  name                    = "postgres"
  username                = "demouser"
  password                = "YourPwd!"
  db_subnet_group_name    = aws_db_subnet_group.postgres-subnet.name
  parameter_group_name    = aws_db_parameter_group.postgres-parameters.name
  multi_az                = "false" 
  vpc_security_group_ids  = [aws_security_group.allow-mariadb.id]
  storage_type            = "gp2"
  backup_retention_period = 30                                          
  availability_zone       = aws_subnet.main-private-1.availability_zone 
  skip_final_snapshot     = true                                        
  tags = {
    Name = "postgres-rds"
  }
}
