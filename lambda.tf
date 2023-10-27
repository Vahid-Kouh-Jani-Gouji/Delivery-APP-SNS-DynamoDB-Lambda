resource "aws_lambda_function" "put_dynamodb" {
 
 filename = "${path.module}/python/putitem.zip"
 function_name = "putitem"
  runtime = "python3.11"
  handler = "putitem.lambda_handler"
  role = aws_iam_role.lambda_exec_dynamodb.arn
}

resource "aws_cloudwatch_log_group" "lambda_put_dynamodb" {
  name = "/aws/lambda/${aws_lambda_function.put_dynamodb.function_name}"

  retention_in_days = 30
}

resource "aws_iam_role" "lambda_exec_dynamodb" {
  name = "serverless_lambda_dynamodb"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Sid    = ""
      Principal = {
        Service = "lambda.amazonaws.com"
      }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_policy" {
  role       = aws_iam_role.lambda_exec_dynamodb.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  
}

resource "aws_iam_policy" "iam_policy_for_lambda_dynamodb" {

  name         = "aws_iam_policy_for_terraform_aws_lambda_dynamodb"
  path         = "/"
  description  = "AWS IAM Policy for managing aws lambda role"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Stmt1698074550649",
      "Action": [
        "dynamodb:PutItem"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:dynamodb:YourRegion:YourID:table/delivery"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "attach_iam_policy_lambda_dynamodb" {
  role        = aws_iam_role.lambda_exec_dynamodb.name
  policy_arn  = aws_iam_policy.iam_policy_for_lambda_dynamodb.arn
}


resource "aws_iam_role_policy_attachment" "example_lambda" {
  policy_arn = "${aws_iam_policy.example_lambda.arn}"
  role = aws_iam_role.lambda_exec_dynamodb.name
}

resource "aws_iam_policy" "example_lambda" {
  policy = "${data.aws_iam_policy_document.example_lambda.json}"
}

data "aws_iam_policy_document" "example_lambda" {
  statement {
    sid       = "AllowSQSPermissions"
    effect    = "Allow"
    resources = ["arn:aws:sqs:*"]

    actions = [
      "sqs:ChangeMessageVisibility",
      "sqs:DeleteMessage",
      "sqs:GetQueueAttributes",
      "sqs:ReceiveMessage",
      "sqs:SendMessage",
      
    ]
  }
}

