# stream_data_to_opensearch
opensearch へstreaming でデータをロードするアーキテクチャサンプル
kinesis data stream -> lambda function -> opensearch でロードする

# セットアップ
```
$ docker-compose up
$ docker exec -it localstack-playground /bin/bash
$ cd /opt/code/localstack/scripts/
$ sh create_services.sh

$ cd /opt/code/localstack/scripts/
$ sh refresh_services.sh
```

# クリーンアップ
```
$ docker-compose stop

$ docker rm opensearch-sample-initializer
$ docker rm localstack-playground
$ docker rm opensearch-sample
$ docker rm -f localstack-playground_lambda_arn_aws_lambda_ap-northeast-1_000000000000_function_streamSampleFunction
$ docker rmi stream_data_to_opensearch_localstack-playground
$ docker rmi stream_data_to_opensearch_initializer
$ docker rmi stream_data_to_opensearch_opensearch-sample

$ rm -rf .local
```

# kinesis からデータ挿入
```
aws --endpoint-url=http://localstack-playground:4566 kinesis put-record \
    --stream-name lambda-stream-sample \
    --partition-key 000 \
    --data '{
        "method": "POST",
        "document": {
            "id": 1,
            "title": "前半、お休みすることについてのお話、後半につれてダラダラゲームの話などしている配信。"
        }
    }'

aws --endpoint-url=http://localstack-playground:4566 kinesis put-record \
    --stream-name lambda-stream-sample \
    --partition-key 000 \
    --data '{
        "method": "DELETE",
        "document": {
            "id": 1
        }
    }'
```
