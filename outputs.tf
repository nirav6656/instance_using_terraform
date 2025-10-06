output "aws_ec2_public_ip" {
  value = aws_instance.demo[*].public_ip
}

output "aws_ec2_private_ip" {
  value = aws_instance.demo[*].private_ip
}