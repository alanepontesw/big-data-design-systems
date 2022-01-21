# Table of Contents
1. [Data Flow](#data-flow)


## Data Flow

![Images](../images/data-steps.png)

## Simple Storage Service (S3)

### Overview
S3 uses an object called the bucket (bucket is the atomic unit for s3). 
S3 organizes the data into buckets, it is going to have prefixes and a huge amount of utility.

### Transfer Acceleration 
(Provides a global content **ingestion** network)
Allow us to reduce the latency of upload files for users across the world using AWS Edge locations.
(Cloud front do almost the same, but in case of cloud front, it reduces the latency in
downloading content to users)

* It's enable per bucket
* It has its own endpoints
  - bucketname.s3-accelerate.amazonaws.com
  - bucketname.s3-accelerate.dualstack.amazonaws.com
- It has additional cost
  - $0.04/GB Unit States, Europe, Japan
  - $0.08/GB all other AWS Edge Locations

![Acceleration](../images/transfer-acceleration.png)

### S3 Multipart Upload

Uploading a big file to s3
- Single S3 Put can be up to 5GiB
- S3 Objects can be up to 5TiB

So how to upload that?? 

Prepare Data ->
Move Pieces  ->
S3 Puts It Together

There's 3 Multipart Upload API Calls
- Create MultipartUpload
- UploadPart
- CompleteMultipartUpload

Considerations

- Parts in Multipart uploads can be made up to 10000 parts
- Specifying the same part number as a previously uploaded part can be utilized to overwrite that part
- A bucket lifecycle policy that can be utilized to automatically abort multipart uploads
after a specified time period.

Best Practices
- Utilize Multipart Upload for files larger than 100MiB
- All parts except the final part must be at least 5MiB

So parts should be between 5MiB and 100MiB

### S3 Storage Classes 

A bucket for every use case

![Class Storage per bucket](../images/class-storage-per-bucket.png)

All these Nines!

- **Durability**: Eleven 9's 99.999999999%
- **Availability**: Two to Four 9's - 99.5% to 99.99%

Service Level Agreement (SLA)
- **Availability**: Two to Three 9's - 99% to 99.9%

Deep Overview

#### S3 Standard Class

![Standard](../images/s3-stardand-class.png)

#### S3 Infrequent Access

We might use Standard to the Data Collection Bucket, but use Infrequent Access Bucket to 
bucket which hold the data after the processing flow. 

![Infrequent](../images/s3-infrequent-access.png)

**Infrequently Accessed Data**

- [!!] Additional Data Write Charge - $0.01 per 1000 requests
- [!!] Additional Data Retrieval Charge - $0.01 per GB
- [!] Objects smaller than 128KB are billed as 128KB objects


#### Standard Infrequent Access vs One Zone Infrequent Access

- Standard IA - 3 or more Availability Zones - $0.0125 per GB stored
- One Zone IA - 1 Availability Zone          - $0.0100 per GB stored

Design

- **Durability**: Eleven 9's 99.999999999%
- **Availability**: Three 9's - 99.9%

Service Level Agreement (SLA)
- **Availability**: Two 9's - 99%