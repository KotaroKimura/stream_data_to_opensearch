#!/bin/sh
set -e

HOST=localstack-playground
PORT=4566

rm -rf /src/lambda_functions/packages

rm /opt/code/localstack/lambda.zip

UUID=`aws --endpoint-url="http://$HOST:$PORT" lambda list-event-source-mappings --function-name streamSampleFunction --query "EventSourceMappings[0].UUID"`
UUID=`echo $UUID | sed 's/"//g'`

aws --endpoint-url="http://$HOST:$PORT" lambda delete-event-source-mapping \
    --uuid $UUID

aws --endpoint-url="http://$HOST:$PORT" kinesis delete-stream \
    --stream-name lambda-stream-sample

aws --endpoint-url="http://$HOST:$PORT" lambda delete-function \
    --function-name streamSampleFunction

aws --endpoint-url="http://$HOST:$PORT" logs delete-log-group \
    --log-group-name /aws/lambda/streamSampleFunction
