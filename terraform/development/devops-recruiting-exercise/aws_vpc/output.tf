output "cidr_blocks" {
  description = "List of cidr_blocks of private subnets"
  value       = aws_vpc.prod-vpc.id
}
output "subnet" {
  description = "subnet id extraction"
  value = aws_subnet.prod-subnet-public-1.ids
}