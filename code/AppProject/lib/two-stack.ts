import * as cdk from 'aws-cdk-lib';
import { BlockPublicAccess } from 'aws-cdk-lib/aws-s3';
import { aws_s3 as s3 } from 'aws-cdk-lib';
import { Construct } from 'constructs';
// import * as sqs from 'aws-cdk-lib/aws-sqs';

export class TwoStack extends cdk.Stack {
  constructor(scope: Construct, id: string, props?: cdk.StackProps) {
    super(scope, id, props);
    
    
    new s3.Bucket(this, 'bucket-2in', {
      versioned: true, //version control of an object in bucket
      bucketName: 'sub-bucket1', //provide name to my bucket
      blockPublicAccess: BlockPublicAccess.BLOCK_ALL, //build to block public access
      removalPolicy: cdk.RemovalPolicy.DESTROY,
      autoDeleteObjects: true,
    });
  }
}
