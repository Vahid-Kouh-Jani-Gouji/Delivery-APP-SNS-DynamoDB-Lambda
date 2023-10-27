import json
import boto3
import os
from uuid import uuid4


# Initialize the DynamoDB 
dynamodb = boto3.client('dynamodb', region_name='YourRegion')


# Define the DynamoDB table name
dynamodb_table = 'delivery'


def lambda_handler(event, context):
    
#   body = json.loads(event["body"])
#    name = body.get("name", "Name not provided")
#    email = body.get("email", "Email not provided")

   # Generate a unique ID for the DynamoDB item
   unique_id = str(uuid4())
    
   #if event from sqs 
   # print (event["Records"][0]["Sns"]["Message"])
   messageofs3 =json.loads(json.loads(event["Records"][0]["body"])["Message"])["Records"][0]["s3"]["object"]
   message=messageofs3["key"]
   
    
   # Save information to DynamoDB
   dynamodb.put_item(
       TableName=dynamodb_table,
       Item={
           'id': {'S': unique_id},
           'name': {'S': message},
           
          
       }
   )

   
   # You can customize the response as needed
   response = {
       "statusCode": 200,
       "body": json.dumps(event),
   }

   return response