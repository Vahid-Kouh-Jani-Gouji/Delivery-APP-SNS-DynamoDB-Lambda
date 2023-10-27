resource "aws_sns_topic_subscription" "sqs_subscription" {
  topic_arn = aws_sns_topic.topic.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.some_queue.arn
}

