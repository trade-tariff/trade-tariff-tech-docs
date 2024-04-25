#!/bin/sh
echo "Initializing localstack s3"

# You must specify a region. You can also configure your region by running "aws configure".

echo "Creating dynamodb tables..."
aws --endpoint-url=http://localhost:4566  dynamodb create-table \
    --region eu-west-2 \
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
