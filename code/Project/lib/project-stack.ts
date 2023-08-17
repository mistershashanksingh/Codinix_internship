import { Construct } from 'constructs';
import * as cdk from 'aws-cdk-lib/core';
import * as lambda from 'aws-cdk-lib/aws-lambda';
import * as s3 from 'aws-cdk-lib/aws-s3';
import * as dynamodb from 'aws-cdk-lib/aws-dynamodb';
import * as ec2 from 'aws-cdk-lib/aws-ec2';
import * as rds from 'aws-cdk-lib/aws-rds';



export class ProjectStack extends cdk.Stack {
  constructor(scope: Construct, id: string, props?: cdk.StackProps) {
    super(scope, id, props);

    // Create a VPC with two public subnets and two private subnets
    const vpc = new ec2.Vpc(this, 'VPC-Vol1', {
      maxAzs: 2,
      subnetConfiguration: [
        {
          name: 'public',
          subnetType: ec2.SubnetType.PUBLIC,
        },
        {
          name: 'private',
          subnetType: ec2.SubnetType.PRIVATE_ISOLATED,
        },
      ],
    });

    // Create a Lambda function
    const lambdaFunction = new lambda.Function(this, 'LambdaSetOne', {
      runtime: lambda.Runtime.NODEJS_14_X,
      code: lambda.Code.fromAsset('lambda'),
      handler: 'hello.handler',
      vpc: vpc,
      vpcSubnets: {
        subnetGroupName: 'private',
      },
      environment: {
        TABLE_NAME: 'my-dynamodb-tab-One',
      },
    });
  
    

    // Create an S3 bucket
    new s3.Bucket(this, 'bucket-Set1', {
      versioned: true, //version control of an object in bucket
      bucketName: 'bucket-1.10', //provide name to my bucket
      blockPublicAccess: s3.BlockPublicAccess.BLOCK_ALL, //build to block public access

    });

    // Create a DynamoDB table
    const dynamoDbTable = new dynamodb.Table(this, 'DynamoDbTabOne', {
      partitionKey: { name: 'id', type: dynamodb.AttributeType.STRING },
      billingMode: dynamodb.BillingMode.PAY_PER_REQUEST,
      encryption: dynamodb.TableEncryption.AWS_MANAGED,
    });

    // Create an RDS database instance
    const dbInstance = new rds.DatabaseInstance(this, 'DbInstaOne', {
      engine: rds.DatabaseInstanceEngine.mysql({ version: rds.MysqlEngineVersion.VER_8_0_23 }),
      instanceType: ec2.InstanceType.of(ec2.InstanceClass.BURSTABLE2, ec2.InstanceSize.SMALL),
      vpc: vpc,
      vpcSubnets: {
        subnetGroupName: 'private',
      },
      allocatedStorage: 20,
      storageEncrypted: true,
      
    });
  }
}
