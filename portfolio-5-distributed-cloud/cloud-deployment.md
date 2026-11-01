# Cloud Database Deployment Evidence – FitCore

## 1. Overview

This document records the cloud database services selected for the FitCore Gym Management System.

Two managed cloud database platforms are used:

1. Neon PostgreSQL for relational data.
2. MongoDB Atlas for NoSQL document data.

## 2. Neon PostgreSQL Deployment

**Platform:** Neon  
**Database technology:** PostgreSQL  
**Purpose:** Store structured FitCore records.

The relational database supports information such as members, membership plans, memberships, payments, trainers, check-ins, and equipment.

The PostgreSQL schema was previously created and verified.

## 3. MongoDB Atlas Deployment

**Platform:** MongoDB Atlas  
**Cluster name:** Fitcore  
**Database name:** fitcore  
**Collection:** members  
**Database version:** MongoDB 8.0.36  
**Cluster tier:** Free  
**Cloud provider:** AWS  
**Region configuration:** One region

The cluster was created successfully, and the current client IP address was added through Network Access.

The `members` collection was populated with sample documents and tested using MongoDB queries and an aggregation pipeline.

## 4. Cloud Connectivity and Security

MongoDB Atlas provides a connection string for applications to connect to the cluster.

Network Access was configured to allow the current client IP address.

Database credentials and connection strings must be stored securely and must not be uploaded to a public repository.

## 5. Deployment Benefits

The cloud-hosted databases provide:

- Remote database access.
- Managed database infrastructure.
- Opportunities for future scalability.
- Support for different database workloads.
- Reduced need to maintain local database servers.

## 6. Limitations

The current implementation uses separate PostgreSQL and MongoDB databases.

Automatic synchronisation between the two databases has not been implemented.

Replication and sharding are discussed as architectural options, but their actual configuration has not yet been demonstrated.

## 7. Conclusion

The FitCore project demonstrates the use of managed cloud database services through Neon PostgreSQL and MongoDB Atlas.

The deployment provides a foundation for examining cloud database availability, scalability, security, and distributed data management.
