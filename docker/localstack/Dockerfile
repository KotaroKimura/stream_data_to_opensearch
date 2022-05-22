FROM localstack/localstack:0.14.2

RUN aws configure set aws_access_key_id hogehoge
RUN aws configure set aws_secret_access_key hogehoge
RUN aws configure set region ap-northeast-1
RUN aws configure set output json

CMD ["/bin/sh"]
