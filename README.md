# Terraform-S3-bucket

Terraform stores state file locally in a file named terraform.tfstate. When working with Terraform in a team, use of a local file makes Terraform usage complicated because each user must make sure they always have the latest state file data before running terraform apply and make sure that nobody else runs terraform apply at the same time.

With remote state, Terraform writes the state data to a remote data store, which can then be shared between all members of a team. Terraform supports storing state in variety of backends. we are now going to use AWS S3 as our backend to configure our remote state.


### Pre-requisites for this project

-  Need to have S3 bucket created
-  IAM User with S3 Admin access
-  IAM User with Privilege to access s3 bucket

The Following policy will allow an exisiting IAM user to get access to S3 Bucket.

```sh

{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "s3:ListBucket",
      "Resource": "arn:aws:s3:::mybucket"
    },
    {
      "Effect": "Allow",
      "Action": ["s3:GetObject", "s3:PutObject"],
      "Resource": "arn:aws:s3:::mybucket/path/to/my/key"
    }
  ]
}

```

### S3 Bucket

I have already created an S3 bucket with versioning enabled.

![](01.jpg)

### Creating Backend

We now add the following code to our main.tf file (or any other)terraform file in our working directory

```sh
terraform {
  backend "s3" {
    bucket = "your-bucket-name"
    key    = "network/terraform.state"
    region = "provide-your-region"
    access_key = "provide-your-access-key"
    secret_key = "provide-your-secret-key"
  }
}
```

We have to provide bucket name and the key which is the location where the state file will be kept, After providing the necessary details we now move to initialize our backend with the following command.

```sh
terraform init
```
- _Screenshot_


![](screenshot.jpg)

As there was a pre existing terraform state file, terraform will now copy our state file to our backend S3 bucket.

Further checking on our S3 bucket we could see that the tfstate file has appeared in it.

![](02.jpg)
