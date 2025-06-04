resource "aws_iam_policy" "this" {
  name        = "example-policy"
  description = "Custom policy to allow access to S3 "

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "aws"
        Effect = "Allow"
        Action = [
          "s3:ListBucket",
          "s3:PutObject",
          "s3:GetObject",
          "s3:DeleteObject"
        ]
        Resource = [
          "arn:aws:s3:::example-bucket",
          "arn:aws:s3:::example-bucket/*",
        ]
      }
    ]
  })
}
