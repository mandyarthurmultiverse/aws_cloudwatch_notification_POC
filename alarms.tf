resource "aws_cloudwatch_metric_alarm" "RDS_CPU_UTIL_MAX" {
  alarm_name                = "RDS_CPU_UTIL_MAX"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "2"
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/RDS"
  period                    = "60"
  statistic                 = "Average"
  threshold                 = "80"
  alarm_description         = "This metric monitors RDS CPU utilization & raises an alarm if CPU Usage is too high"
  alarm_actions       = aws_sns_topic.slack_cloudwatch_alerts.*.arn
  ok_actions          = aws_sns_topic.slack_cloudwatch_alerts.*.arn

  tags = {
    Owner = "Mandy Arthur"
    Team = "Data Insights"
    Project-Type = "Proof of Concept"
    Terraform = "Y"
    Repo = "Local/aws_cloudwatch_notification_POC" # Ideally "Multiverse/Github link"

  }
}

resource "aws_cloudwatch_metric_alarm" "RDS_CPU_UTIL_MIN" {
  alarm_name                = "RDS_CPU_UTIL_MIN"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "2"
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/RDS"
  period                    = "60"
  statistic                 = "Average"
  threshold                 = "5"
  alarm_description         = "This metric monitors RDS CPU utilization & raises an alarm if CPU Usage is too low"
  alarm_actions       = aws_sns_topic.slack_cloudwatch_alerts.*.arn
  ok_actions          = aws_sns_topic.slack_cloudwatch_alerts.*.arn

  tags = {
    Owner = "Mandy Arthur"
    Team = "Data Insights"
    Project-Type = "Proof of Concept"
    Terraform = "Y"
    Repo = "Local/aws_cloudwatch_notification_POC" # Ideally "Multiverse/Github link"

  }
}