resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = "${aws_s3_bucket.message_s3.id}"

  topic {
    topic_arn     = "${aws_sns_topic.topic.arn}"
    events        = ["s3:ObjectCreated:*"]
    
  }
}


