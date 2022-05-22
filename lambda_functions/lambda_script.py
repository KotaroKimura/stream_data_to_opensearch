import ast
import boto3
import base64
import requests

from requests.auth import HTTPBasicAuth

region  = 'ap-northeast-1'
service = 'es'
awsauth = HTTPBasicAuth('admin', 'admin')

host  = 'https://opensearch-sample:9200'
index = 'opensearch_sample'
type  = '_doc'
url   = host + '/' + index + '/' + type + '/'

headers = { "Content-Type": "application/json" }

def lambda_handler(event, context):

    count = 0
    for record in event['Records']:
        decoded_massage = base64.b64decode(record['kinesis']['data']).decode('utf-8')
        dict_message    = ast.literal_eval(decoded_massage)

        method   = dict_message['method']
        document = dict_message['document']

        id = str(document['id'])

        if method == 'DELETE':
            r = requests.delete(url + id, auth=awsauth, verify=False)
        else:
            r = requests.put(url + id, auth=awsauth, json=document, headers=headers, verify=False)

        count += 1

    print(str(count) + ' records processed.')
    return "success!!!"
