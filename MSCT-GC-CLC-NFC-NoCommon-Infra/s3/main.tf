module "s3_bucket" {
  #source = "terraform-aws-modules/s3-bucket/aws"
  source = "git@github.com:terraform-aws-modules/terraform-aws-s3-bucket.git"
  bucket = "clc-nfc-test"
  acl    = "private"

  control_object_ownership = true
  object_ownership         = "ObjectWriter"

}

resource "aws_s3_bucket" "s3_bucket" {


    bucket = "clc-nfc-test"  #Need Modify
    # block_public_acls = "false"
    # ignore_public_acls = "true"

}


resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.s3_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

}

resource "aws_s3_bucket_ownership_controls" "s3_owner_control" {
  bucket = aws_s3_bucket.s3_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "s3_acl" {
  depends_on = [aws_s3_bucket_ownership_controls.s3_owner_control]

  bucket = aws_s3_bucket.s3_bucket.id
  acl    = "private"
}