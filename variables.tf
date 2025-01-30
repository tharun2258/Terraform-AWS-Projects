variable "ami" {
  type        = string
  description = "ami value of the ec2 instance"
}

variable "instance_type" {
  type        = string
  description = "instance type of the ec2 istance"

}

variable "key_name" {
  type        = string
  description = "key name of the ec2 instance"

}

variable "bucket_name" {
  type        = string
  description = "bucket name of the s3 bucket"

}

variable "bucket_env" {
  type        = string
  description = "environment of the s3 bucket"

}