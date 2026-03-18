# The Resource uses variables instead of "quotes"
resource "local_file" "multi_file" {
  filename = var.filename
  content  = var.message
}

# Declaring the variables (The placeholders)
variable "filename" {
  type = string
}

variable "message" {
  type = string
}
