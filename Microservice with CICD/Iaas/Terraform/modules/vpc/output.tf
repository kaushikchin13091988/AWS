output "vpc_id" {
  value = aws_vpc.test-kaushik-vpc.id
}

output "public_subnet_1_id" {
  value = aws_subnet.test-kaushik-public-subnet-1.id
}

output "public_subnet_2_id" {
  value = aws_subnet.test-kaushik-public-subnet-2.id
}

output "private_subnet_1_id" {
  value = aws_subnet.test-kaushik-private-subnet-1.id
}

output "private_subnet_2_id" {
  value = aws_subnet.test-kaushik-private-subnet-2.id
}