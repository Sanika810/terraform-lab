resource "local_file" "automation_test" {
  filename = var.filename
  content  = "Automation Success!"
}

variable "filename" {
  type    = string
  default = "test.txt"
}
