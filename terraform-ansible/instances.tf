# Get Linux AMI ID using SSM Parameter endpoint in us-east-1
data "aws_ssm_parameter" "linuxAmiMaster" {
  provider = aws.region-master
  name     = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

# Get Linux AMI ID using SSM Parameter endpoint in us-wast-2
data "aws_ssm_parameter" "linuxAmiWorker" {
  provider = aws.region-worker
  name     = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

# Create key-pair for logging into EC2 in us-east-1
resource "aws_key_pair" "masterKey" {
  provider   = aws.region-master
  key_name   = "jenkins"
  public_key = file("~/.ssh/id_rsa.pub")
}

# Create key-pair for logging into EC2 in us-west-2
resource "aws_key_pair" "workerKey" {
  provider   = aws.region-worker
  key_name   = "jenkins"
  public_key = file("~/.ssh/id_rsa.pub")
}