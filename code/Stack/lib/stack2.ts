import * as cdk from 'aws-cdk-lib';
import { BlockPublicAccess } from 'aws-cdk-lib/aws-s3';
import { Construct } from 'constructs';
import { aws_s3 as s3 } from 'aws-cdk-lib';
// import * as sqs from 'aws-cdk-lib/aws-sqs';

export class Stack2 extends cdk.Stack {
  constructor(scope: Construct, id: string, props?: cdk.StackProps) {
    super(scope, id, props);

    new s3.Bucket(this, 'bucket-Vol3', {
      versioned: true, //version control of an object in bucket
      bucketName: 'bucket-n.3', //provide name to my bucket
      blockPublicAccess: BlockPublicAccess.BLOCK_ALL, //build to block public access
      removalPolicy: cdk.RemovalPolicy.DESTROY,
      autoDeleteObjects: true,
    });
    new s3.Bucket(this, 'bucket-Vol4', {
      versioned: true, //version control of an object in bucket
      bucketName: 'bucket-n.4', //provide name to my bucket
      blockPublicAccess: BlockPublicAccess.BLOCK_ALL, //build to block public access
      removalPolicy: cdk.RemovalPolicy.DESTROY,
      autoDeleteObjects: true,
    });

    new s3.Bucket(this, 'bucket-Vol5', {
      versioned: true, //version control of an object in bucket
      bucketName: 'bucket-n.5', //provide name to my bucket
      blockPublicAccess: BlockPublicAccess.BLOCK_ALL, //build to block public access
      removalPolicy: cdk.RemovalPolicy.DESTROY,
      autoDeleteObjects: true,
    });


    // The code that defines your stack goes here

    // example resource
    // const queue = new sqs.Queue(this, 'StackQueue', {
    //   visibilityTimeout: cdk.Duration.seconds(300)
    // });
  }
}
