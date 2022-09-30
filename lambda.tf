resource "aws_iam_role" "lambda_slack_notifier" {
  name = "lambda_slack_notifier"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

data "archive_file" "zip_the_python_code" {
type        = "zip"
source_dir  = "${path.module}/lambda_function_payload/"
output_path = "${path.module}/lambda_function_payload.zip"
}


resource "aws_lambda_function" "cloudwatch_slack_notification" {
  filename      = "${path.module}/lambda_function_payload.zip"
  function_name = "TF-cloudwatch-slack-notification"
  role          = aws_iam_role.lambda_slack_notifier.arn
  handler       = "main.lambda_handler"
  runtime       = "python3.8"

}