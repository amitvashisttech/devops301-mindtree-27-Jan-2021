#To Setup Terraform follow the below steps: 

## Step1: Download Terraform
```
==>  wget https://releases.hashicorp.com/terraform/0.12.24/terraform_0.12.24_linux_amd64.zip
==>  apt-get install unzip -y 
==>  unzip terraform_0.12.24_linux_amd64.zip 
==>  mv terraform /usr/bin/terraform
==>  chmod +x /usr/bin/terraform
==>  export PATH=$PATH:/usr/bin/terraform
==>  echo "export PATH=$PATH:/usr/bin/terraform" >>  ~/.bashrc
==>  source  ~/.bashrc
==>  teraform --version
```

## Step2: Setup an AWS Account 
```
==> Register your AWS Account. 
==> Login to AWS Account 
==> Goto -> IAM -> User -> Add User
    UserName:  terraform
    Accesstype: [*]  Programmatic access

    -> Permission ->  Attach existing policies directly 
       [*]  AmazonEC2FullAccess
    -> Next -> Create User & Download Keys. 
```

## Step3: Export the AWS Key in Local Runtime Env 
```
==> export AWS_ACCESS_KEY_ID="XXXXXXXXXXXXXX"
==> export AWS_SECRET_ACCESS_KEY="YYYYYYYYYYYXXXXXXXXXXXXXX"
```
## Step4: Create Terraform Code. 

