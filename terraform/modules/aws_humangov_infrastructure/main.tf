resource "aws_security_group" "state_ec2_sg" {
  name        = "humangov-${var.state_name}-ec2-sg"
  description = "Allow traffic on ports 22 and 80"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "humangov-${var.state_name}"
  }
}

resource "aws_key_pair" "state_ec2_key" {
  key_name   = "humangov-${var.state_name}-ec2-key"
  public_key = file("${var.public_key_path}")
}

resource "aws_instance" "state_ec2" {
  ami                    = "ami-007855ac798b5175e"
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.state_ec2_key.key_name
  vpc_security_group_ids = [aws_security_group.state_ec2_sg.id]

  tags = {
    Name = "humangov-${var.state_name}"
  }
}

resource "aws_dynamodb_table" "state_dynamodb" {
  name         = "humangov-${var.state_name}-dynamodb"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"

  attribute {
    name = "id"
    type = "S"
  }

  tags = {
    Name = "humangov-${var.state_name}"
  }
}

resource "aws_s3_bucket" "state_s3" {
  bucket = "humangov-${var.state_name}-s3-${random_string.bucket_suffix.result}"

  tags = {
    Name = "humangov-${var.state_name}"
  }
}

resource "aws_s3_bucket_acl" "state_s3_acl" {
  bucket = aws_s3_bucket.state_s3.id

  acl = "private"
}

resource "random_string" "bucket_suffix" {
  length  = 4
  special = false
  upper   = false
}