# 1. Define the provider (Local File)
resource "local_file" "hello" {
  filename = var.filename
  content  = var.message
}

# 2. Define Variables
variable "filename" {
  type    = string
  default = "hello.txt"
}

variable "message" {
  type    = string
  default = "Hello from Terraform"
}

# 3. Define Output
output "file_path" {
  value = "${path.module}/${local_file.hello.filename}"
}
