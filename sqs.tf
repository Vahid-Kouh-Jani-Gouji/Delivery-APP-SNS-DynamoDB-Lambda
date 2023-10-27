resource "aws_sqs_queue" "some_queue" {
  name = "SomeQueue"

  policy            = <<POLICY
  {
  "Version": "2012-10-17",
  "Id": "__default_policy_ID",
  "Statement": [
    {
      "Sid": "__owner_statement",
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::YourID:root"
      },
      "Action": "SQS:*",
      "Resource": "arn:aws:sqs:YourRegion:YourID:SomeQueue"
    },
    {
      "Sid": "topic-subscription-arn:aws:sns:YourRegion:YourID:topic-name",
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": "SQS:SendMessage",
      "Resource": "arn:aws:sqs:YourRegion:YourID:SomeQueue",
      "Condition": {
        "ArnLike": {
          "aws:SourceArn": "arn:aws:sns:YourRegion:YourID:topic-name"
        }
      }
    }
  ]
}
POLICY

}


