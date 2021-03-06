output "address" {
  value       = module.database_instance.address
  description = "The DB endpoint"
}

output "port" {
  value       = module.database_instance.port
  description = "The port to use"
}