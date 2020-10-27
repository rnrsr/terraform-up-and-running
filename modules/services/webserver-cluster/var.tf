variable "server_port" {
  description = "The server port for http"
  type        = number
  default     = 8080
}

variable "cluster_name" {
  type = string
}

variable "db_remote_state_bucket" {
  type = string
}

variable "db_remote_state_key" {
  type = string
}

variable "instance_type" {
  description = "The type of EC2 instance"
  type        = string
}

variable "min_size" {
  description = "The min number of instances"
  type        = number
}

variable "max_size" {
  description = "The max number of instances"
  type        = number
}
