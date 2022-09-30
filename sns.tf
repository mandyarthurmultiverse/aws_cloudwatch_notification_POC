resource "aws_sns_topic" "slack_cloudwatch_alerts" {
  name = "slack_cloudwatch_alerts"
}

resource "aws_sns_topic_subscription" "slack_cloudwatch_alerts" {
    topic_arn = aws_sns_topic.slack_cloudwatch_alerts.arn
    protocol  = "lambda"
    endpoint  = aws_lambda_function.cloudwatch_slack_notification.arn
}