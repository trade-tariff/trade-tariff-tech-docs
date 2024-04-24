#!/bin/sh
echo "Initializing localstack s3"


echo "Creating dynamodb tables..."
aws dynamodb create-table \
    --table-name CustomerApiKeys \
    --attribute-definitions \
        AttributeName=CustomerApiKeyId,AttributeType=S \
        AttributeName=FpoId,AttributeType=S \
    --key-schema \
        AttributeName=CustomerApiKeyId,KeyType=HASH \
        AttributeName=FpoId,KeyType=RANGE \
    --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5

echo "Creating API Gateway..."
# TODO: Create API Gateway
