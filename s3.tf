resource "aws_s3_bucket" "prod" {
  bucket = "interview-fire101"
}

resource "aws_s3_bucket_acl" "access_control" {
  bucket = aws_s3_bucket.prod.id
  acl    = "private"
}

resource "aws_s3_object" "folder1" {
    bucket = "aws_s3_bucket.prod.id"
    key    = "logs/"
    source = "/dev/null"
}

resource "aws_s3_object" "folder2" {
    bucket = "aws_s3_bucket.prod.id"
    key    = "image/"
    source = "/dev/null"
}

resource "aws_s3_bucket_lifecycle_configuration" "bucket-config" {
  bucket = aws_s3_bucket.prod.id
  rule {
    id = "images"

    filter {
      and {
        prefix = "images/"

        tags = {
          rule      = "images"
        }
      }
    }
    status = "Enabled"
    transition {
      days          = 90
      storage_class = "GLACIER"
    }
  }

  rule {
    id = "logs"

    filter {
      prefix = "logs/"
    }

    expiration {
      days = 90
    }

    status = "Enabled"
  }
}
