#!/bin/sh
set -e

HOST=opensearch-sample
PORT=9200

INDEX_INFO=`curl -s -u 'admin:admin' --insecure -XGET "https://$HOST:$PORT/opensearch_sample"`
if [ `echo $INDEX_INFO | grep 'opensearch_sample_v1'` ] ; then
  exit 0
fi

curl -s -u 'admin:admin' --insecure -H 'Content-Type: application/json' -XPUT "https://$HOST:$PORT/opensearch_sample_v1" -d @search.json
curl -s -u 'admin:admin' --insecure -H 'Content-Type: application/json' -XPOST "https://$HOST:$PORT/_aliases" -d '
{
  "actions" : [
    {
      "add" : {
        "index" : "opensearch_sample_v1",
        "alias" : "opensearch_sample"
      }
    }
  ]
}
'
