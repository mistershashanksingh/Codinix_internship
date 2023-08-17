/*code by :shashank singh
  created date 16-04-2023
  changes made is renaming  'MyFirstBucket'*/ 
import * as cdk from 'aws-cdk-lib';
import { aws_s3 as s3 } from 'aws-cdk-lib';
import { BlockPublicAccess, Bucket } from 'aws-cdk-lib/aws-s3';
// import * as sqs from 'aws-cdk-lib/aws-sqs';

export class HelloCdkStack extends cdk.Stack {
  constructor(scope: cdk.App, id: string, props?: cdk.StackProps) {
    super(scope, id, props);
    
    
    new s3.Bucket(this, 'MyFirstBucket', {
      versioned: true,
      bucketName: 'mybucket3.6', //rename my bucket
            // 👇 set removalPolicy to DESTROY
      removalPolicy: cdk.RemovalPolicy.DESTROY,
      autoDeleteObjects: true,
    });
    
    
    new s3.Bucket(this, 'MyThirdBucket', {
      versioned: true, //version control of an object in bucket
      bucketName: 'mybucket3.0', //provide name to my bucket
      blockPublicAccess: BlockPublicAccess.BLOCK_ALL, //build to block public access
      removalPolicy: cdk.RemovalPolicy.DESTROY,
      autoDeleteObjects: true,
    });
    new s3.Bucket(this, 'MyForthBucket', {
      versioned: true,
      bucketName: 'mybucket3.1',
      blockPublicAccess: BlockPublicAccess.BLOCK_ALL,
      removalPolicy: cdk.RemovalPolicy.DESTROY,
      autoDeleteObjects: true,
    });    
    new s3.Bucket(this, 'MyFifthBucket', {
      versioned: true,
      removalPolicy: cdk.RemovalPolicy.DESTROY,
      autoDeleteObjects: true,
      bucketName: 'mybucket3.2'
    });
    new s3.Bucket(this, 'MySixthBucket', {
      versioned: true,
      removalPolicy: cdk.RemovalPolicy.DESTROY,
      autoDeleteObjects: true,
      bucketName: 'mybucket3.3'
    });    
    new s3.Bucket(this, 'MySeventhBucket', {
      versioned: true,
      removalPolicy: cdk.RemovalPolicy.DESTROY,
      autoDeleteObjects: true,
      bucketName: 'mybucket3.4'
    });
    new s3.Bucket(this, 'MyEighthBucket', {
      versioned: true,
      removalPolicy: cdk.RemovalPolicy.DESTROY,
      autoDeleteObjects: true,
      bucketName: 'mybucket3.5'
    });
    // The code that defines your stack goes here
    // example resource
    // const queue = new sqs.Queue(this, 'HelloCdkQueue', {
      //   visibilityTimeout: cdk.Duration.seconds(300)
      // });

    }
  }


  