# Replication and Fault Tolerance — Portfolio 5

## 1. Introduction

This experiment documents the replication architecture and fault-tolerance features of the FitCore Gym Management System using MongoDB Atlas.

The MongoDB deployment uses a three-member replica set hosted on Amazon Web Services (AWS) in the Frankfurt region (`eu-central-1`).

## 2. Replica Set Configuration

The MongoDB Atlas monitoring dashboard displays three replica set members:

- **Primary node:** Responsible for receiving database write operations.
- **Secondary node 1:** Maintains replicated copies of data from the primary.
- **Secondary node 2:** Maintains replicated copies of data from the primary.

The three-member configuration provides data redundancy and supports database availability.

## 3. Data Replication

MongoDB replica sets use replication to maintain copies of the database across multiple members.

When data is written to the primary node, MongoDB records the changes in its operation log (oplog). Secondary members use this information to replicate the changes.

This arrangement helps maintain consistent copies of data across the replica set.

## 4. Fault Tolerance and Automatic Failover

A replica set provides fault tolerance through its election mechanism.

If the primary member becomes unavailable, the remaining eligible members can participate in an election to select a new primary.

Once a new primary is elected, the database can resume accepting write operations.

This mechanism reduces dependence on a single database server.

**Note:** The monitoring dashboard confirms the three-member replica set configuration. An actual primary-node failure and automatic failover test has not yet been performed.

## 5. Evidence Collected

The following evidence supports this experiment:

- MongoDB Atlas cluster overview.
- MongoDB Atlas replica set monitoring dashboard.
- Screenshot showing the Primary and Secondary member roles.

## 6. Conclusion

The FitCore MongoDB deployment demonstrates a three-member replica set architecture on MongoDB Atlas.

The configuration provides a foundation for data replication, redundancy and fault tolerance. The replica set election mechanism also supports automatic recovery from primary-node unavailability.

A controlled failover test would provide additional practical evidence of this capability.
