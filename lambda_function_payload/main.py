import urllib3
import json

http = urllib3.PoolManager()


def lambda_handler(event, context):
    url = "https://hooks.slack.com/services/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"
    encoded_msg = json.dumps(event['Records'][0]['Sns']['Message'])

    message_dict = json.loads(encoded_msg)
    AlarmName = message_dict['AlarmName']
    AWSAccountId = message_dict['AWSAccountId']
    NewStateValue = message_dict['NewStateValue']

    if AlarmName == "RDS_CPU_UTIL_MIN":
        alert = f':money_with_wings: {AlarmName} in account {AWSAccountId} is in state {NewStateValue}.'
    elif AlarmName == "RDS_CPU_UTIL_MAX":
        alert = f':scream: FYI {AlarmName} in account {AWSAccountId} is in state {NewStateValue}. '
    else:
        pass
    # alert = f':fire: {AlarmName} in account {AWSAccountId} is in state {NewStateValue} because {NewStateReason}'
    # print(alert)

    slack_message = {
        'text': f'{alert}'
    }

    resp = http.request('POST', url, body=json.dumps(slack_message))
    print({
        "message": "slack_message",
        "status_code": resp.status,
        "response": resp.data
    })
