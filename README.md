Index Topics

* AWS
* NIFI

## AWS
 > I’ve always been a software engineer. I used to have a general understanding of what Data Science and Analytics were. **What I didn’t know** was how **important it is** for the data **to respect a few requirements in order to be used effectively**, and how engineers can help make the data readily accessible.
 [*](https://medium.com/bolt-labs/want-to-be-a-data-engineer-heres-what-you-need-to-know-68f7575dc6d8)

* AWS Stuffs
  * Pricing Principles:
  ![Princing Principles](./images/pricing.png)
  * History:
    * > Inventions requires two things: 1. The ability to try a lot of experiments and 2. Not to having to live with the collateral damages of failed experiments. Andy Jassy
  * Services overview
  ![Global Infrastruture](./images/overview_services_aws.png)
  * Core concepts
    * The oldest region is the US East (Virginia) and this is where all the news services come out first
    * Availability zone vs Region vs Edge location
    * Global Infrastruture
    ![Global Infrastruture](./images/global_infra.png)
    * Availability Zone is essentially a big data center each with redundant power, networking and connectivity and etc.
    * Availability Zone may have a lot of data center but cuz them are so close, they counted as 1 AZ.
    ![AZ](./images/data_center.png)
    * Region is a geografical area, each region has 2 or more AZ
    ![Region what](./images/what_region.png)
    * Region is a physical location spread across the globe to host your data to reduce **latency**.
    ![Region overview](./images/regions.png)
    * Edge Location are used for caching content
    ![Region overview](./images/edge_locations.png)
    * Edge Location are located in most of the major cities around the world and are specifically used by CloudFront(Content Delivery Network - CDN) to distribute content to end user to reduce **latency**.
    ![Region overview](./images/regional_edges.png)
    * There are more Edge Location than Regions.
  * IAM (Identity and Access Management)
    
    * Enables you to manage access to AWS services and resources securely. Using IAM, you can create and manage AWS users and groups, and use permissions to allow and deny their access to AWS resources.
    ![SpiderMan](./images/great_power.png)
    * Everything you do here is in global region, itsn't belong to a one specific region.
    * Enables you to manage users and their level of access for aws stuffs.
    * Features[*](https://info.acloud.guru/team-cloud-technology-training?adchannel=Google&paidcampaign=1648420462&paidadgroup=64616557178&paidkeyword=kwd-411849373105&paidad=315261896152&gclid=EAIaIQobChMIpseVr-394QIVCCaGCh1zSQNmEAAYASAAEgIr8PD_BwE):
      * Shared Access to your AWS Account
      ![Shared Access](./images/shared_access.png)
      * Centralised Control of your AWS Account
      ![Centralised Access](./images/centralised_control.png)
      * **Granular** Permission 
      * **Identity Federation** (Active Diretory, Facebook, Linkedin etc)
      * **Multifactor Authentication**
      * Provide temporary access for users/devices and services where necesssary
      * Allows you to set up your own password **rotation policy**
      * Integrates with many different AWS services
      * Support **PCI DSS Compliance** 
    *  ARN (Amazon Resource Name)[TODO] 
    * Users, Groups, Policies and Roles
      * > AWS Identity and Access Management (IAM) is a web service that helps you securely control access to AWS resources for your users. You use IAM to control who can use your AWS resources (authentication) and what resources they can use and in what ways (authorization).[*](https://serverless-stack.com/chapters/what-is-iam.html)
      * >When you first create an AWS account, you are the **root user**. The email address and password you used to create the account is called your root account credentials. You can use them to sign in to the AWS Management Console. When you do, **you have complete, unrestricted access to all resources in your AWS account**, including access to your billing information and the ability to change your password.[*](https://serverless-stack.com/chapters/what-is-iam.html)
      * Users
        * Users as people, organizations or something like that, and IAM user consists of a name, a password to sign into a AWS console. (Remember, Itsn't a good pratice give your root creadencials for someone, that's why you will prefer to create IAM users). 
        * By default users can't access anything in your account then you will to create policies to the users. 
        ![Users](./images/users.png)
        * New users are assigned **Access Key ID** and **Secret Access Key** when first created.
          * **Access Key ID** and **Secret Access Key** you get to view these just once time. If you lose them, you have to regenerate them. So, save them in a secure location.
        * These are not the same as a password, you cannot use **Access Key ID** and **Secret Access Key** to login into the console, you just can use theses to access API's and Command Line.
      * Policies
        * Polices as essentially documents theses documents are in a format called JSON and they give permissions as to what a User, Group or Role is able to do.  
        * You can attach a policy to a User, a Role or a Group.
        * ***Here a policy that grants all operations to all S3 buckets:***
            ```
            {
                "Version": "2012-10-17",
                "Statement": {
                    "Effect": "Allow",
                    "Action": "s3:*",
                    "Resource": "*"
                }
            }
            ```
        * ***Here a policy that grants more granular access, only allowing retrieval of files prefixed by the string Alanes- in the bucket called Hello-World***:
            ```
                {
                    "Version": "2012-10-17",
                    "Statement": {
                        "Effect": "Allow",
                        "Action": ["s3:GetObject"],
                        "Resource": "arn:aws:s3:::Hello-World/*",
                        "Condition": {"StringEquals": {"s3:prefix": "Alanes-"}}
                    }
                }
            ``` 
        * An IAM policy is **a rule** or **set of rules** defining the operations **allowed/denied** to be performed on **an AWS resource.**
      * Roles
        * Roles are permitions for resources. 
        ![Roles](./images/roles.png)
        * > Sometimes your **AWS resources need to access other resources** in your account. For example, you have a **Lambda function that queries your DynamoDB** to retrieve some data, process it, and then send Bob an email with the results. In this case, **we want Lambda to only be able to make read queries** so it does not change the database by mistake. We also want to restrict Lambda to be able to email Bob so it does not spam other people. **While this could be done by creating an IAM user and putting the user’s credentials to the Lambda function or embed the credentials in the Lambda code, this is just not secure.** If somebody was to get hold of these credentials, they could make those calls on your behalf. This is where IAM role comes in to play.[*](https://serverless-stack.com/chapters/what-is-iam.html)
        * A role does not have any credentials (password or access keys) associated with it
        * You need to associate policies for your roles.
        * Roles can be applied for Users.
        * > You can also have **a role tied to the ARN of a user from a different organization**. This allows the external user to assume that role as a part of your organization. **This is typically used when you have a third party service that is acting on your AWS Organization**. You’ll be asked to create a Cross-Account IAM Role and **add the external user as a Trust Relationship**. **The Trust Relationship is telling AWS that the specified external user can assume this role**.
        ![RolesUserExternal](./images/roles_as_user_and_external_user.png)
      * Groups
        * A bunch of users. Each user in the group automatically has the permissions that are assigned to the group 
        * >  **If a new user joins your organization** and should have administrator privileges, you can assign the appropriate permissions by adding the user to that group. Similarly, if a person changes jobs in your organization, instead of editing that user’s permissions, you can remove him or her from the old groups and add him or her to the appropriate new groups.
        ![Group](./images/group.png)
      * MFA
        * > AWS Multi-Factor Authentication (MFA) **is a simple best practice that adds an extra layer of protection on top of your user name and password**. With MFA enabled, when a user signs in to an AWS website, **they will be prompted for their user name and password (the first factor— what they know)**, as well as for **an authentication response from their AWS MFA device (the second factor— what they have).** Taken together, these multiple factors provide increased security for your AWS account settings and resources. 
        You can enable MFA for your AWS account and for individual IAM users you have created under your account. MFA can be also be used to control access to AWS service APIs.
  * Billing Alarm
    * > You can monitor your **estimated AWS charges** using Amazon CloudWatch.
    **Billing metric data is stored in the US East (N. Virginia)** region and represents worldwide charges. This data includes the estimated charges for every service in AWS that you use, in addition to the estimated overall total of your AWS charges. **The alarm triggers when your account billing exceeds the threshold you specify**. **It triggers only when actual billing exceeds the threshold.** It does **not use projections based on your usage so far in the month.**[*](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/monitor_estimated_charges_with_cloudwatch.html)
  * S3 [*](https://www.amazonaws.cn/en/s3/faqs/)
    * **Offers a highly-scalable, reliable, and low-latency data storage** infrastructure at very low costs.
 
    * **A simple webservice interface** you can use to **store and retrieve any amount of data**, at any time, from anywhere on the web. 
 
    * The total **volume of data** and number of objects **you can store are unlimited**.
 
    * Individual Amazon **S3 objects can range in size from 0 bytes to 5 terabytes**. 
    * Not suitible by to install an OS
    * Successful uploads will generate 
 a HTTP 200 status code.
    * **The largest object that can be uploaded in a single PUT is 5 gigabytes.**

    * Multipart Upload (for objects larger than 100 megabytes is essential, but you should consider to use it even in object > 5MB)[*](http://docs.amazonaws.cn/en_us/AmazonS3/latest/dev/mpuoverview.html):
      * Upload objects in parts that **can be uploaded independently**, **in any order**, **and in parallel**.
      * When you should consider to user Multipart Upload
        * > If you're uploading large objects over a stable high-bandwidth network, use multipart uploading to maximize the use of your available bandwidth by uploading object parts in parallel for multi-threaded performance.
        * > If you're uploading over a spotty network, use multipart uploading to increase resiliency to network errors by avoiding upload restarts. When using multipart uploading, you need to retry uploading only parts that are interrupted during the upload. You don't need to restart uploading your object from the beginning.
      * Advantages:
        * > Improved throughput - You can upload parts in parallel to improve throughput.
        * > Quick recovery from any network issues - Smaller part size minimizes the impact of restarting a failed upload due to a network error.
        * > Pause and resume object uploads - You can upload object parts over time. Once you initiate a multipart upload there is no expiry; you must explicitly complete or abort the multipart upload.
        * > Begin an upload before you know the final object size - You can upload an object as you are creating it.
      *  **Multi-Object Delete to delete large numbers of objects from Amazon S3.** This feature allows you to send **multiple object keys in a single request to speed up your deletes**.
     *  Key-based object store. When you store data, you assign a unique object key that can later be used to retrieve the data.
     *  **S3 Standard is designed for 99.99% availability** and **Amazon guarantee is 99.9% availability**
     *  **S3 Standard IA is designed for 99.99% availability**
     *  Amazon guarantee 99.999999999% of durability
     *  Stored redundantly accross devices in multiples facilities (instalações)
     *  Files are storage in buckets (it means, folders are you put your files)
        *  S3 use a global namespace so bucket must be uniques.
    * Monitor, analyze and optimize
    ![Monitoring](./images/s3_monitor_analyze_optimize.png)    
    * S3 has:
      * objects or files 
        * has tags and prefix
        ![Tags and Prefix](./images/tags_and_prefixes.png)  

      * keys(are objects names)
      * values, it means, a simple sequence of bytes.
      * version id (it allow a s3 to have multiples versions of a file)
      * metadata, it means, data about data.
      * subresources
        *  Access Control List
        *  Torrent
    * Data consistency in s3:
      * Read after write consistency for PUTS of new objects. (if you write the file and read it immediately afterwards you will be able to view the data)
      * Eventual Consistency for overwrites PUTS and Deletes (if you update an existing file or delete a file and read it immediately, you may get the older version, or you may not. It means, can take some time to propagate)
    * S3 Storage Class:
      * It's import choice the right storage class
      ![S3 Storage Class](./images/the_right_storage_class.png)
      * IA
        *  IA means infrequently accessed
        *  Used mainly when data is less accessed but requires rapid access. Lower fee than S3 Stardand but you will be charged for retrieval. 
      * Standard
      * One Zone
      * Intelligent Tiering
        * ![S3 Int](./images/s3_int.png)
      * Glacier
      * Glacier Deep Archive
      ![S3 Storage Class](./images/s3-storage-classes-comparison.png)
      ![S3 Choice Storage Class](./images/choices_storage_class.png)
      ![Overview](./images/storage-overview.png)
      
    * S3 features:
      * Tiered Storage Available
      * Lifecycle Management
      * Security and Encryption
      * Version Control
      * Cross Region Replication
      * Transfer Acceleration
      * MFA Delete
      * Secure your data using Access Control List or Bucket Policies
    * Pricing
      * Storage
      * Requests
      * Storage Management
      * Cross Region Replication
      * Data Transfer
      * Transfer Acceleration
    * Security and Encryption
      * By default, all created bucket all PRIVATES
      * S3 Buckets can be configured to create access logs which logs all requests made to the s3 Bucket or even other Bucket in another account.
      * Encrypt In Transit:
        * SSL/TLS
      * Encrypt At Rest:
        * S3 Managed Keys - SSE-S3
        * Server Side Encryption With Customer - Provided Keys - SSE-C 
        * AWS Key Management Services, Managed Keys-SSE-KMS
      * Client Side
    * Versioning
      * Store all version of an object (including all writes and even if you delete an object)
      * Great backup tool
      * One time enabled cannot be disable, only suspended.
      * Integrates with lifecycle rules.
      * Versining's MFA DELETE capabilities. 
    * Lifecycle management
      * Automates moving your objects between the differents storage tiers.
      * Can be used in conjuction with versioning.
      * Can be applied to current and previous versions.
    * Cross Regions Replication
      * Version must be enabled on both the source and destination bucket.
      * Regions must be unique
      * Files in an existing bucket are not replicated automatically.
      * All subsequent files will be replicated automatically.
      * Delete markers are not replicated.
      * Delete individual versions or delete markers will not be replicated.
    * S3 Transfer Acceleration 
      * HIPAA compliant
      * utilises the CLoud Front Edge Network to accelerate your uploads to S3. Instead of uploading directly to your bucket S3, you can use a distinct URL to upload directly to an edge location which will then transfer that file to S3.  
      ![TRANSFER ACCELERATION](./images/transfer_acceleration.png)
      * Trasfer Acceleration Tool[*](https://aws.amazon.com/premiumsupport/knowledge-center/upload-speed-s3-transfer-acceleration/)

    * Workloads Patterns
      * Frequently accessed data
      ![S3 Pattern1](./images/s3_pattern1.png)
      * Infrequently accessed data
      ![S3 Pattern2](./images/s3_pattern2.png)
      * Infrequently accessed data
      ![S3 Pattern3](./images/s3_pattern3.png)
      * Unknown Access Patterns
      ![S3 Pattern4](./images/s3_pattern4.png)
  * Cloud Front 
    * A content delivery network (CDN) is a system of distributed systems servers (networks) that delivery webpages and other web content to a user based on the geographic locations of the user, the origin of the webpage,and a content delivery server.
    * Key terminologies:
      * Edge Location: 
        * This is the location where the content will be cached. This is separate to an AWS Region/AZ  
      * Origin:
          * This is the origin of all files that the CDN will distribute. This can be an S3 Bucket, an EC2 Instance, an Elastic Load Balancer, or Route53
      * Distribuition 
        * This is the name given the CDN, which consists of a collection of Edge Locations. 
    * What it's mean?
      * CF can be used to delivery your entire website, including dynamic, static, streaming, and interactive content using a global network of edge locations. Requests for your content are automatically routed to the nearest Edge Location, so content is delivered with the best possible performace.
    * Types of Distribuition
      * RTMP:    
        * Used for media streaming
      * Web Distribuition:
        * Typically used for Websites
    * Tips
      * Edge Location are not just READ ONLY - you can write to them.
      * Objects are cached for the Time To Live (TTL)
      * You can invalidate cached objects, but you will be charged.
    ![Cloud Front](./images/cloud_front.png) 
  * Snowball
    * is a petabyte-scale data transport solution that uses secure appliances to transfer large amounts of data into and out of Amazon. Using Snowball addresses common challenges with large-scale data transfer including high networks costs, long transfer times, and security concerns. Tranfering data with Snowball is simple, fast, secure, and can be as little as one-fifth the cost of high speed internet.
    ![Cloud Front](./images/snowball_image.png) 
    * Comes in either a 50TB or 80TB
    * Uses a multiple layers of security designed to protect your data including tamper-resistant enclusures.
    * import and export to s3.
    * 256-bit encryption.
    * and a industry-standard Trusted Platform Module (TPM) to ensure both security anf full chain of custody of your data. 
    * AWS Snowball Edge is a 100TM data transfer device with on-board storage and compute capabilities. You can use Snowball Edge to move large amounts of data into and out AWS, as a temporary storage tier for large local datasets or support local workloads in remoto or offline locations.
    * Snowmobile
      ![Snowmobile](./images/snowmobile.png)
      * Exabyte-scale data transfer used to move extremely large amounts of data to AWS.
      * up to 100PB by snowmobile.
      * Makes easy to move massive volumes of data to the cloud (videos, libraries, images, or even a complete datacerter migration)
      * secure, fast and cost effective
    * When should I consider using Snowball instead of the Internet?
    ![SnowmobilevsInterned](./images/when_use_snowball.png)
  
  * Storage Gateway
    * Essentialy a manner of replication your local data to AWS.
    * Is a service that connects an on-promises softwares to provide seamless and secure integration between an organization's on promises IT enviroment and AWS's Storage Infrastructure. 
    * This will replicate your data to AWS.
    * It's available for download as a Virtual Machine (VM) image then you can install on a host in your data center.
    * It's support either ESXi or Microsoft Hyper-V.
    * There are three differentes types of SG:
      * File Gateway (NFS)
        * for flat files, stored directly on S3 
      * Volume Gateway (iSCI)
        * Store Volumes
          * Entire Dataset is stored on site and is assynchronously backed up to S3.
          * Entire Dataset is stored on S3 and the most frequently accessed data is cached on site.
        * Cached Volumes
      * Tape Gateway (VTL - Virtual Tape Library)
    * File Gateway (NFS - Network File System)
      * Files are storage in your S3 Buckets, accessed through a Network File System (NFS) mount point. Ownership, permissions, and timestamps are durably stored in S3 in the user-metadata of the object associated with the file. 
      * Once objects are transferred to S3 they can managed as native S3 objects.
      ![NFS](./images/file_gateway_nfs.png)
    * Volume Gateway (Small Computer System Interface (iSCSI) )
      * The volume interface presents you application with disks volumes using the iSCI block protocol
      * Data written to these volumes can be assynchronously backed up as point-in-time snapshots of your volumes, and stored in the cloud as Amazon EBS snapshots.
      * Snapshots are incremental backups that capture only changed blocks. All snapshots storage is all compressed to minimize your storage charges. 
      * Stored Volumes:
        * > If you need low-latency access to your entire dataset, first configure your on-premises gateway to store all your data locally. Then asynchronously back up point-in-time snapshots of this data to Amazon S3. This configuration provides durable and inexpensive offsite backups that you can recover to your local data center or Amazon EC2. For example, if you need replacement capacity for disaster recovery, you can recover the backups to Amazon EC2. [*](https://docs.aws.amazon.com/storagegateway/latest/userguide/WhatIsStorageGateway.html)
        * 1GB - 16TB in size for Stored Volumes.
      * Cached volumes: 
        * > You store your data in Amazon Simple Storage Service (Amazon S3) and retain a copy of frequently accessed data subsets locally. Cached volumes offer a substantial cost savings on primary storage and minimize the need to scale your storage on-premises. You also retain low-latency access to your frequently accessed data.
        * 1GB - 32TB in size for Cached Volumes.
        * ![VOLUMES](./images/stored_volume.png)
    * Tape Gateway 
        * > With a tape gateway, you can cost-effectively and durably archive backup data in Amazon S3 Glacier or S3 Glacier Deep Archive. A tape gateway provides a virtual tape infrastructure that scales seamlessly with your business needs and eliminates the operational burden of provisioning, scaling, and maintaining a physical tape infrastructure.
        ![Tape Gateway](./images/tape_gateway.png)
  * EC2 (Elastic Compute Cloud)
    * It's a Virtual Machine (VM) in the cloud.
    * Is a web service that provides resizable compute capacity in the cloud. 
    * Reduce the time required to obtain and boot new server instances to minutes, allowing you to quickly scale capacity, both up and down, as your computing requirements change. 
    * The AWS Pricing 
    ![Pricing Principles](./images/pricing_principles.png)
    * EC2 Pricing Models 
      * On demand
        * Allows you to pay a fixed rate by the hour (or by the second) with no commitment
      * Reserved
        * Provides you with a capacity reservation, and offer a significant discount on the hourly charge for an instance. Contract Terms are 1 Year or 3 Year Terms  
      * Spot
        * Enables you to bid whatever price you want for instance capacity, providing for even greater savings if your applications have flexible start and end times.
      * Dedicated Hosts
        * Physical EC2 server dedicated for your use. Dedicated Hosts can help you reduce costs by allowing you to use your existing server-bound software licenses.
    * When to use one or other?
      * On demand
        * Users that want the low cost and flexibily of Amazon EC2 without any up front payment or long-term commitment.
        * Applications with short term, spike, or unpredictable workloads that cannot be interrupted. 
        * Applications being developed or tested on Amazon EC2 for the first time.
      * Reserved 
        * Applications with steady state or predictable usage.
        * Applications that require reserved capacity.
        * Users able to make upfront payments to reduce their total computing costs even futher.
        * Types:
          * Standard Reserved Instances
            * These offer up to 75% off on demand instances. The more you pay up front and the longer the contracts, the greater the discount. 
          * Convertible Reserved Instances
            * These offer up to 54% off on demand capability to change the attributes of the RI as long as the exchange results in the creation of RI of equal or greater value.
          * Scheduled Reserved Instances
            * These are available to launch within the time windows you reserve. This option allows you to match your capacity reservation to a predictable recurring schedule that only requires a fraction of a day, a week, o a month.
      * Spot
        * Applications that have flexible start and end times.
        * Applications that are only feasible at very low compute prices.
        * Users with urgent computing needs for large amounts of additional capacity.
        * If the Spot instance is terminated by Amazon EC2, you will not be charged for a partial hour of usage. However, if you terminate the instance yourself, you will be charged for any hour in which the instance ran.
      * Dedicated Hosts 
        * Useful for regulatory requirements that may not support multi-tenant virtualization.
        * Great for licensing which does not support multi-tenancy or cloud deployments.
        * Can be purchased On-Demand (hourly)
        * Can be purchased as a Reservation up to 70% off the On-Demand price.
    * EC2 Instances Types:
      * Tip: the number doesn't matter, It's just about generation.
      ![EC2 Instances Types](./images/ec2_instance_types.png)
    * EC2 Instances Types 
      * Fight DoRctor MaC PiXels ZAU
      ![EC2 Instances Types Mnemonic](./images/instance_types_mnemonic.png)
    * Tips
      * Termination Protection is **turned off** by default, you must turn it on.
      * On an EBS-Backed instance, the **default action is for the root EBS volume to be deleted** when the instance is terminated. 
      * EBS Root Volumes of your DEFAULT AMI's cannot be encrypted. You can also use a third party tool (such as bit locker etc) to encrypt the root volume, or this can be done when creating AMI's in the AWS console or using API.
      * Additional volumes can be encrypted.
    * Security Group
      * If you apply any change in security group this change take effect immediately.
      * All inbound traffic is blocked by default.
      * All Outbound traffic is allowed.
      * You can have any nymber of EC2 instances within a security group. 
      * You can have multiple security groups attached to EC2 Instances.
      * Security group are STATEFUL
        * If you create an inbound rule allowing traffic in, that traffic is automatically allowed back out again. 
      * You cannot block specific IP addresses using Security Groups, instead use Network Access Control Lists.
      * You can specify allow rules, but not deny rules.
    * What's EBS?
      * Amazon Elastic Block Store (EBS).
      * Provides persistent block storage volumes for use with Amazon EC2 Instances.  
      ![EBS](./images/ebs.png) 
      * Each EBS volume is automatically replicated within its Availability Zone to protect you from component failure, offering high availability and durability.
    * 5 Differents Types of EBS Storage
      * General Purpose (SSD)
      * Provisioned IOPS (I/O per second) (SDD)
      * Throughput Optimised Hard Drive Disk
      * Cold Hard Disk Drive
      * Magnetic
      ![EBS](./images/compare_ebs_types.png) 

      

## Nifi
 * What is a Data Flow, Data Pipeline and ETL?
   * Data Flow
     * Essentialy moving data/content from Source to Destination. (Batch or Stream)
   * Data Pipeline
     * Movement and Transformation of Data/content from Source to Destionation. (Batch or Stream)
   * ETL 
     * Extract, Transform and Load (Batch)
   * What problem Nifi resolve? 
     * Source -> Transform -> Destination
     * You can use a lot of differentes tools, but, you need to remember the 4 V's
     * 4 V's
       * Volume
         * refers to the vast amount of data generated each second.
       * Velocity
         * refers to the speed which each data is generated and the speed which data moving from one point to other.
       * Variety
         * refers a vast types of data you have treat.
       * Veracity
         * refers to the trustness of data.
     * Support for various input/output formats
     * Scalable and Reliable for large amount of data and high velocity data. 
     * etc.
   * > Apache nifi supports powerful and scalable directed graphs of data routing, transformation and system mediation logic.
   * > Nifi was built to automate the flow of data between systems. It can propagate any data content from any Source to any Destination.
  




## Utils Links
     
  * Amazon Storage Class and Cost Optimization[*](https://www.youtube.com/watch?v=wFSv2gSQADI)
  * S3 Faqs[*](https://www.amazonaws.cn/en/s3/faqs/)
  * Snowball Faqs[*](https://aws.amazon.com/snowball/faqs/)
  * AWS Pricing Overview[*](https://d1.awsstatic.com/whitepapers/aws_pricing_overview.pdf)
  * Apache Nifi Overview[*](https://nifi.apache.org/docs/nifi-docs/html/overview.html)





    
    

