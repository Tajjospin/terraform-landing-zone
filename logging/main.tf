#resource "aws_kms_key" "mykey" {
#  description             = "This key is used to encrypt bucket objects"
#  deletion_window_in_days = 10
#  policy = <<EOF
  
  
# EOF
#}

resource "aws_s3_bucket" "b" {
  bucket = "jospin-bucket-de-log"
  tags = {
    Name        = "bucket-de-log"
    Environment = "Dev"
  }
}
# create log folders of each service

# resource "aws_s3_object" "object-1" {
#   bucket = aws_s3_bucket.b.id
#   key    = "network-transite-gateway-flowlogs/"
#   # kms_key_id = aws_kms_key.mykey.id
# }
# resource "aws_s3_object" "object-2" {
#   bucket = aws_s3_bucket.b.id
#   key    = "network-vpcflowlogs/"
#   # kms_key_id = aws_kms_key.mykey.id
# }

# configurate bucket policy
#resource "aws_s3_bucket_server_side_encryption_configuration" "example" {
#  bucket = aws_s3_bucket.b.id

#  rule {
#    apply_server_side_encryption_by_default {
#      kms_master_key_id = aws_kms_key.mykey.arn
#      sse_algorithm     = "aws:kms"
#    }
#  }
#}

resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.b.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
resource "aws_s3_bucket_policy" "network-access" {
  bucket = aws_s3_bucket.b.id
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AWSLogDeliveryWrite",
      "Effect": "Allow",
      "Principal": {
        "Service": "delivery.logs.amazonaws.com"
      },
      "Action": "s3:PutObject",
      "Resource": "${aws_s3_bucket.b.arn}/*",
      "Condition": {
        "StringEquals": {
          "aws:SourceAccount": [
            "370953620355",
            "387537833577",
            "031960154372",
            "182862085962"
          ],
          "s3:x-amz-acl": "bucket-owner-full-control"
        },
        "ArnLike": {
          "aws:SourceArn": [
            "arn:aws:logs:eu-west-1:370953620355:*",
            "arn:aws:logs:eu-west-1:387537833577:*",
            "arn:aws:logs:eu-west-1:031960154372:*",
            "arn:aws:logs:eu-west-1:182862085962:*"
          ]
        }
      }
    },
    {
      "Sid": "AWSLogDeliveryAclCheck",
      "Effect": "Allow",
      "Principal": {
        "Service": "delivery.logs.amazonaws.com"
      },
      "Action": [
        "s3:GetBucketAcl",
        "s3:ListBucket"
      ],
      "Resource": "${aws_s3_bucket.b.arn}",
      "Condition": {
        "StringEquals": {
          "aws:SourceAccount": [
            "370953620355",
            "387537833577",
            "031960154372",
            "182862085962"
          ]
        },
        "ArnLike": {
          "aws:SourceArn": [
            "arn:aws:logs:eu-west-1:370953620355:*",
            "arn:aws:logs:eu-west-1:387537833577:*",
            "arn:aws:logs:eu-west-1:031960154372:*",
            "arn:aws:logs:eu-west-1:182862085962:*"
          ]
        }
      }
    }
  ]
}

  EOF
}
