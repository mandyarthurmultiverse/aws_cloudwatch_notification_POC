AWS Cloudwatch Notifications POC
================================

AWS Cloudwatch Notifications POC allows a user with access to terraform on their local machine to spin up cloudwatch alarms on any AWS account

Key notes

1.  Alarms created include
    1.  RDS CPU usage in Region (London)
    2.  Billing alerts in us-east-1
2.  The architecture for this project is as follows

```
![image](files/alarm-architecture.png)

```

It creates

-   Cloudwatch alarms
-   SNS Topic
-   Lambda function + Execution roles with IAM policy
-   Link to an existing Slack channel `data_insight_resource_alert` with existing Webhook

This project is created specifically for Data Insights and therefore may only be currently relevant to AWS Accounts `data-sandbox` and `data-warehouse`. 

Future improvements 
-[] Variablize tags
-[] Variablize REGION so that Billing can have it's own cloudwatch alarm <----- !!!
-[] Put Webhook url in secrets manager and call from there
-[] Makefile to automate creation of alerting & monitoring resources incase we wish to switch them off an schedule them 
-[] RDS instance autoscaling feature based on cloudwatch alerts 
-[] Terraform lambda test for slack 
```json
{
  "Records": [
    {
      "EventSource": "aws:sns",
      "EventVersion": "1.0",
      "EventSubscriptionArn": "arn:aws:sns:us-east-1:{{{accountId}}}:ExampleTopic",
      "Sns": {
        "Type": "Notification",
        "MessageId": "95df01b4-ee98-5cb9-9903-4c221d41eb5e",
        "TopicArn": "arn:aws:sns:us-east-1:123456789012:ExampleTopic",
        "Subject": "example subject",
        "Message": {
          "AlarmName": "RDS_CPU_UTIL_MIN",
          "AlarmDescription": null,
          "AWSAccountId": "335418736740",
          "AlarmConfigurationUpdatedTimestamp": "2022-09-07T14:32:21.020+0000",
          "NewStateValue": "ALARM",
          "NewStateReason": "Threshold Crossed: 1 out of the last 1 datapoints [7.258333333333333 (07/09/22 14:31:00)] was greater than the threshold (1.0) (minimum 1 datapoint for OK -> ALARM transition).",
          "StateChangeTime": "2022-09-07T14:33:43.328+0000",
          "Region": "EU (London)",
          "AlarmArn": "arn:aws:cloudwatch:eu-west-2:335418736740:alarm:RDS_CPU_UTIL_MIN",
          "OldStateValue": "OK",
          "OKActions": [],
          "AlarmActions": [
            "arn:aws:sns:eu-west-2:335418736740:Default_CloudWatch_Alarms_Topic"
          ],
          "InsufficientDataActions": [],
          "Trigger": {
            "MetricName": "CPUUtilization",
            "Namespace": "AWS/RDS",
            "StatisticType": "Statistic",
            "Statistic": "AVERAGE",
            "Unit": null,
            "Dimensions": [],
            "Period": 60,
            "EvaluationPeriods": 1,
            "DatapointsToAlarm": 1,
            "ComparisonOperator": "GreaterThanThreshold",
            "Threshold": 1,
            "TreatMissingData": "missing",
            "EvaluateLowSampleCountPercentile": ""
          }
        },
        "Timestamp": "1970-01-01T00:00:00.000Z",
        "SignatureVersion": "1",
        "Signature": "EXAMPLE",
        "SigningCertUrl": "EXAMPLE",
        "UnsubscribeUrl": "EXAMPLE",
        "MessageAttributes": {
          "Test": {
            "Type": "String",
            "Value": "TestString"
          },
          "TestBinary": {
            "Type": "Binary",
            "Value": "TestBinary"
          }
        }
      }
    }
  ]
}

```