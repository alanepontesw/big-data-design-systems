Index Topics

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
        * > You can also have **a role tied to the ARN of a user from a different organization**. This allows the external user to assume that role as a part of your organization. **This is typically used when you have a third party service that is acting on your AWS Organization**. You’ll be asked to create a Cross-Account IAM Role and **add the external user as a Trust Relationship**.** The Trust Relationship is telling AWS that the specified external user can assume this role**.
        ![RolesUserExternal](./images/roles_as_user_and_external_user.png)
      * Groups
        * A bunch of users then each user in the group automatically has the permissions that are assigned to the group 
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
    
    * S3 has:
      * objects or files 
        * has tags and prefix
        ![Tags and Prefix](./images/s3_monitor_analyze_optimize.png)

      * keys(are objects names)
      * values, it means, a simple sequence of bytes.
      * version id (it allow a s3 to have multiples versions of a file)
      * metadata, it means, data about data.
      * subresources
        *  Access Control List
        *  Torrent
    * Data consistency in s3:
      * Read after write consistency for PUTS of new objects. (if you write the file and read it immediately afterwards you will be able to view the data)
      * Eventual Consistency for overwrites PUTS and Deletes (if you update an existing file or delete a file and read it immediately, you may get the older version, or yoy may not. It means, can take some time to propagate)
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
    * Utils Links
      * Amazon Storage Class and Cost Optimization[*](https://www.youtube.com/watch?v=wFSv2gSQADI)
  * Cloud Front 
    * A content delivery network (CDN) is a system of distributed systems servers (networks) that delivery webpages and other web content to a user based on the geographic locations of the user, the origin of the webpage,and a content delivery server.
    * Key terminologies:
      * Edge Location: 
        * This is the location where the content will be cached.     
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
    ![Cloud Front](./images/cloud_front.png)




    
    

