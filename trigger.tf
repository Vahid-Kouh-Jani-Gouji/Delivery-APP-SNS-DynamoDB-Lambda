resource "aws_lambda_event_source_mapping" "event_source_mapping_se" {
  batch_size        = 1
  event_source_arn  = "${aws_sqs_queue.some_queue.arn}"
  enabled           = true
  function_name     = "${aws_lambda_function.put_dynamodb.arn}"
}