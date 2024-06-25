provider "aws" {
  region = "eu-central-1" 
}

data "aws_security_group" "existing_sg" {
  id = "sg-04c2644c9ffd0276c" # Replace this with your actual security group ID
}

# Output the security group ID to verify it's being fetched correctly
output "security_group_id" {
  value = data.aws_security_group.existing_sg.id
}

# Create a new EC2 instance
resource "aws_instance" "example" {
  ami           = "ami-01e444924a2233b07" # Replace this with your desired AMI ID
  instance_type = "t2.micro"
  key_name      = "pracc"
  vpc_security_group_ids = [data.aws_security_group.existing_sg.id]

  tags = {
    Name = "ExampleInstance"
  }
}

# Output the instance ID and public IP
output "instance_id" {
  value = aws_instance.example.id
}

output "public_ip" {
  value = aws_instance.example.public_ip
}