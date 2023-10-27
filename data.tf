data "archive_file" "lambda_dynamodb_put" {
  type = "zip"

  source_dir  = "${path.module}/python/"
  output_path = "${path.module}/python/putitem.zip"
}

data "archive_file" "lambda_s3_put" {
  type = "zip"

  source_dir  = "${path.module}/s3/"
  output_path = "${path.module}/s3/lambdaPutS3.zip"
}