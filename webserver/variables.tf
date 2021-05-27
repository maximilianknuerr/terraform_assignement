variable "server_port" {
  type = number
  default = 8080
}
variable "redis_address" {
  type = string
  default = ""
}

variable "aws_ami_id" {
  type=string
  default =""
}