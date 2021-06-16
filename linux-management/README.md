## User Management

![UID Ranges](../images/uid_ranges.png)

### What is the Linux User Account?

User accounts provide access to the Linux system, and all activities in that system are owned and managed by user accounts. 

That means the system processes are also owned and ran by specific users.

There are three kinds of users in Linux:
* System Account (Service Account)
* Regular User Account 
* Super-User Account

The UID (User Identifier) is a numeric value to identify users in the system.

The GID (Group Identifier) is a numeric value to identify groups in the system.

The system assigns the UID and the GID, and those determine which resources a user or a group of users has access to

```
# check user's id
$ id 

# check user's groups
$ groups 
```

### What is a group?
A group is just a collection of user accounts who share the same access. Users can be added to a group to obtain privileges to files, directories, and so on

### Files

```
Holds every user on the system and also their attributes, except the password
$ cat /etc/passwd

The user password is actually encrypted into
$ cat /etc/shadow

The group information is stored into
$ cat /etc/group

The group password is actually encrypted into
$ cat /etc/gshadow
```

### What is a Shell?

A shell is a program that acts as an interface between the user and the operating system kernel. A shell is started each time a user logs in and is responsible for executing programs based on user input. The shell also provides a user environment that can be customized by configuring the profile initialization files for each user. These files contain user settings for:

- Paths where commands are located
- Defining variable
- Customizable values, such as terminal prompt

### Available Shells
- The Bourne Shell (/bin/sh)
- The Korn Shell (/bin/ksh)
- The C Shell (/bin/csh)
- The Bourne-Again Shell (/bin/bash)

This above shell's are generelly used for service accounts that run system processes and don't require a user to login.

User shell set to /sbin/nologin when a user try to login it will get a "this account is currently no available"

User shell set to /bin/false when a user try to login is immediately logged out.

### User Home Directories

Each user on a Linux system is created with a user home directory. 