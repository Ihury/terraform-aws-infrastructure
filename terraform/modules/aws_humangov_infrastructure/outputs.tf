output "state_ec2_public_dns" {
  value = aws_instance.state_ec2.public_dns
}

output "state_dynamodb_table" {
  value = aws_dynamodb_table.state_dynamodb.name
}

output "state_s3_bucket" {
  value = aws_s3_bucket.state_s3.bucket
}