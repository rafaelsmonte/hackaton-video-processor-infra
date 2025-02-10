# Terraform

This project uses terraform to provision resources on AWS.This document presents how to use terraform as well as the resource provisioned.

## Usage

```
// Go to terraform directory
cd terraform

// Init Terraform
terraform init

// Before running the command below for the first time
1. Go to amazon account and create secrets manager repository with all environment variables
2. Comment out the kubernetes-drivers repository to be applyed later

// Create terraform resources
terraform apply -var-file values.tfvars

// Apply kubernetes drivers
1. Uncoment the kubernetes-drivers module
2. Run: aws eks describe-cluster --name <CLUSTER_NAME> --query "cluster.identity.oidc.issuer" --output text
3. Update the autoscaler/cluster-autoscaler-aws-role.json with the oidc id of the clsuter
4. Run: eksctl utils associate-iam-oidc-provider --region=$AWS_REGION --cluster=$EKS_CLUSTER_NAME --approve
5. Run: aws eks update-kubeconfig --name $EKS_CLUSTER_NAME --region $AWS_REGION --profile default
6. Run: terraform apply -target=module.kubernetes-drivers -var-file values.tfvars
```

## AWS Resources Provisioned via Terraform

### 1. API Gateway

AWS API Gateway is used to expose the endpoints:
- `/api/videos` → Routes requests to the load balancer managing Video Processor APIs.
- `/api/v1/accounts` → Routes requests to the AWS Lambda function handling user accounts.

### 2. Cognito for Identity Management

- **User Pool**: Manages authentication and identity verification.
- **App Client**: Provides secure authentication tokens for users.

### 3. Amazon Elastic Container Registry (ECR)

Two ECR repositories are created to manage container images:

- **video-processor-api**: Exposes APIs for end-users.
- **video-processor-worker**: Extracts images from video files.

### 4. Amazon Elastic Kubernetes Service (EKS)

An EKS cluster is deployed to manage the containers of the two services.
Additionally, the following Kubernetes drivers are installed:
- **metrics-server**: Enables active metric collection used in Horizontal Pod Autoscaler (HPA).
- **external-secrets**: Binds Kubernetes secrets to AWS Secrets Manager.
- **cluster-autoscaler**: Enables node group auto-scaling.

### 5. AWS Lambda Functions

Two Lambda functions are deployed:
- **User Accounts & Authentication Service**
- **Email Notification Service**

### 6. Amazon S3 Storage
Two S3 buckets are created:
- **Video Storage Bucket**: Stores uploaded video files.
- **Extracted Images Bucket**: Stores ZIP archives containing extracted images.

### 7. SNS and SQS for Asynchronous Communication
Each service communicates asynchronously via SNS topics and SQS queues:
#### **Video Processor API**
- **SNS Topic**: Emits messages.
- **SQS Queue**: Receives messages.

#### **Video Processor Worker**
- **SNS Topic**: Emits messages.
- **SQS Queue**: Receives messages.

### 8. Amazon DynamoDB
A dedicated repository manages database infrastructure using DynamoDB:
[Database Infrastructure Repository](https://github.com/rafaelsmonte/hackaton-video-processor-db)

## Terraform Organization

To enhance modularity and flexibility, Terraform configurations are organized as follows:
- **Modules**: Each AWS resource is managed within its own module.
- **Variables**: Deployment is parameterized to support dynamic environments (test, production, etc.).

## Deployment Considerations
- **Scalability**: Kubernetes autoscaling ensures optimal resource utilization.
- **Security**: IAM roles, security groups, and encrypted storage ensure data protection.
- **Reliability**: SNS and SQS facilitate fault-tolerant messaging.
- **Observability**: Metrics collection and logging mechanisms are in place.

This structured approach ensures a highly maintainable and scalable infrastructure for the Video Processor Service.

