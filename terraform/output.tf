output "elb" {
  value = aws_elb.myapp-elb.dns_name
}


output "rds" {
  value = aws_db_instance.postgres.endpoint
}
