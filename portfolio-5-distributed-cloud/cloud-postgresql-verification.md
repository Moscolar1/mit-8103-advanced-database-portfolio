# Cloud PostgreSQL Deployment and Verification

## 1. Introduction

This experiment verifies the deployment and accessibility of the FitCore Gym Management System relational database using Neon PostgreSQL.

The objective is to demonstrate that the cloud-hosted database can establish a connection, execute SQL queries and retrieve stored records.

## 2. Cloud Database Configuration

- **Cloud provider:** Neon
- **Database technology:** PostgreSQL
- **Database name:** neondb
- **Database user:** neondb_owner
- **Branch:** production
- **PostgreSQL version:** 18.6
- **Cloud region:** AWS Europe Central 1 (Frankfurt)

## 3. Connection Verification

The following SQL query was executed to verify the database connection and retrieve database information:

```sql
SELECT
    current_database() AS database_name,
    current_user AS database_user,
    version() AS postgresql_version,
    NOW() AS verification_time;
```

The query executed successfully and returned the database name, database user, PostgreSQL version and verification timestamp.

## 4. Data Retrieval Verification

The following SQL query was executed to confirm that member records could be retrieved from the cloud database:

```sql
SELECT
    COUNT(*) AS total_members
FROM members;
```

**Result:** 1,001 member records.

The query executed successfully and confirmed that the FitCore members table contained 1,001 records at the time of verification.

## 5. Evidence Collected

The following screenshots document the experiment:

- `07-neon-postgresql-cloud-verification.png` — Database connection and PostgreSQL version.
- `08-neon-member-count-verification.png` — Successful member count query.

## 6. Conclusion

The experiment successfully demonstrated connectivity to the Neon-hosted PostgreSQL database and the execution of SQL queries against the FitCore members table.

The successful retrieval of 1,001 member records confirms that the cloud database is accessible and its stored data can be queried.
