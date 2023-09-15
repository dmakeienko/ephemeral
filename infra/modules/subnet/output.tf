output "subnet_id" {
  value = {for k, s in aws_subnet.main: k => s.id}
}