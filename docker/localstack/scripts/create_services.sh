#!/bin/sh
set -e

HOST=localstack-playground
PORT=4566

cd /src/lambda_functions
pip install --target ./packages -r requirements.txt

cd /src/lambda_functions/packages
zip -r ../lambda.zip .
cd ..
zip -g lambda.zip lambda_script.py
mv lambda.zip /opt/code/localstack
cd /opt/code/localstack

aws --endpoint-url="http://$HOST:$PORT" lambda create-function \
    --function-name streamSampleFunction \
    --runtime python3.9 \
    --handler lambda_script.lambda_handler \
    --role r1 \
    --zip-file fileb://lambda.zip

aws --endpoint-url="http://$HOST:$PORT" kinesis create-stream \
    --stream-name lambda-stream-sample \
    --shard-count 1

aws --endpoint-url="http://$HOST:$PORT" lambda create-event-source-mapping \
    --function-name streamSampleFunction \
    --batch-size 5 \
    --starting-position TRIM_HORIZON \
    --starting-position-timestamp 1541139109 \
    --event-source-arn arn:aws:kinesis:ap-northeast-1:000000000000:stream/lambda-stream-sample
