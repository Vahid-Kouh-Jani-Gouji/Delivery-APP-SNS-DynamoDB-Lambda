resource "aws_sns_topic" "topic" {
  name = "topic-name"
  policy = data.aws_iam_policy_document.topic.json
}

data "aws_iam_policy_document" "topic" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["s3.amazonaws.com"]
    }

    actions   = ["SNS:Publish"]
    resources = ["arn:aws:sns:*:*:topic-name"]

    condition {
      test     = "ArnLike"
      variable = "aws:SourceArn"
      values   = ["arn:aws:s3:*:*:message-lambda"]
    }
  }
}


