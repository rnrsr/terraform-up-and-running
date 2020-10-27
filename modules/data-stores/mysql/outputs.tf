output "address" {
  value       = aws_db_instance.example.address
  description = "The DB endpoint"
}

output "port" {
  value       = aws_db_instance.example.port
  description = "The port to use"
}