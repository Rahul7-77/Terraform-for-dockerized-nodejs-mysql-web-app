output "aws_instance_public_ip" {
  value = aws_instance.my-app-server.public_ip
}

output "my-vpc-id" {
  value = aws_vpc.my-vpc.id
}
