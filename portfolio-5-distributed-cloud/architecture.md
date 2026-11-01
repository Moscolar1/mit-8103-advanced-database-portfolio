# Portfolio 5: Distributed and Cloud Database Architecture

## 1. Introduction

This document describes the proposed distributed and cloud database architecture for the FitCore Gym Management System.

The objective is to examine how cloud database technologies can support availability, scalability, data consistency, and reliable access to gym management information.

## 2. Proposed Architecture

The FitCore system uses a combination of relational and document-oriented database technologies.

- **Neon PostgreSQL:** Stores structured relational information such as members, membership plans, payments, check-ins, trainers, and equipment records.
- **MongoDB Atlas:** Stores document-oriented member information and supports flexible document queries and aggregation.
- **Application Layer:** Provides access to database services for authorised gym staff and management.
- **Cloud Infrastructure:** Provides managed database hosting and remote database access.

## 3. Data Distribution

The system separates its database workloads according to their data requirements.

PostgreSQL supports structured records and relationships, while MongoDB supports flexible document-based records.

The two databases are treated as separate data stores in this proposed architecture. No automatic synchronisation between them is assumed.

## 4. Replication

Database replication involves maintaining copies of data across multiple database nodes.

For FitCore, replication can improve data availability and support recovery when a database node becomes unavailable.

Managed cloud database services may provide replication capabilities as part of their infrastructure. The actual replication configuration should be verified from the relevant provider settings before claiming that it has been implemented.

## 5. Sharding

Sharding involves dividing a large dataset into smaller portions distributed across multiple database servers.

For FitCore, member records could conceptually be distributed using a suitable shard key, such as a member identifier or geographic branch identifier, if the system expands to multiple gym branches.

Sharding can support horizontal scalability, although it introduces additional complexity in query routing and data management.

## 6. Availability and Consistency

Availability means ensuring that authorised users can access database services when required.

Consistency means maintaining accurate and reliable data across database operations.

For example, FitCore must ensure that membership and payment records remain accurate when users access the system.

Transactions, appropriate replication policies, backups, and recovery procedures can help support these requirements.

## 7. Conclusion

The proposed architecture demonstrates how relational and NoSQL databases can support different workloads within the FitCore Gym Management System.

Cloud-hosted database services provide opportunities for scalability, availability, and managed infrastructure. Replication and sharding are important techniques to consider as the system grows.

Further implementation and testing would be required to validate these capabilities in a production environment.
