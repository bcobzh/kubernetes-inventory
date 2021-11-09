#!/usr/bin/env python3 
import os
import boto3
import logging
from botocore.config import Config
boto3.set_stream_logger('', logging.INFO)

CLUSTER = os.getenv('CLUSTER')
BUCKET = os.getenv('S3_BUCKET')
FOLDER = os.getenv('S3_FOLDER')
PROXY = os.getenv('PROXY')
REGION = os.getenv('S3_REGION')
ENDPOINT = os.getenv('S3_ENDPOINT')

config = Config(
	s3={
		'addressing_style': 'path',
	},
	proxies={
		'http': PROXY,
		'https': PROXY,
	}
)

s3 = boto3.client('s3',
        endpoint_url=ENDPOINT,
	config=config,
)

print(f'push s3://{BUCKET}/{FOLDER}/{CLUSTER}.json')
s3.upload_file('inventory.json', BUCKET, f'{FOLDER}/{CLUSTER}.json')

