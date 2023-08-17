#!/usr/bin/env node
import 'source-map-support/register';
import * as cdk from 'aws-cdk-lib';
import { OneStack } from '../lib/one-stack';
import { TwoStack } from '../lib/two-stack';
import { ThreeStack } from '../lib/three-stack';


const app3 = new cdk.App();
new ThreeStack(app3, 'ThreeStack');
app3.synth()

const app2 = new cdk.App();
new TwoStack(app2, 'TwoStack');
app2.synth()

const app1 = new cdk.App();
new OneStack(app1, 'OneStack');
 app1.synth()

