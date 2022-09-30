resource "aws_cloudwatch_log_metric_filter" "Lambda-Error-Case" {
  name           = "OurMetricFilter"
  log_group_name = "/aws/lambda/cloudwatch-slack-notification"
  pattern        = "ERROR"
  metric_transformation {
    name      = "Error-Lambda"
    namespace = "ImportantMetrics"
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "Lambda-Error-Case-alarm" {
  alarm_name = "Lambda_Failure"
  metric_name         = aws_cloudwatch_log_metric_filter.Lambda-Error-Case.name
  threshold           = "0"
  statistic           = "Sum"
  comparison_operator = "GreaterThanThreshold"
  datapoints_to_alarm = "1"
  evaluation_periods  = "1"
  period              = "60"
  namespace           = "ImportantMetrics"
  alarm_actions       = [aws_sns_topic.slack_cloudwatch_alerts.arn]
}