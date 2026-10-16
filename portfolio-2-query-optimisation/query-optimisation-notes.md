
# Query Optimisation Notes — FitCore Gym Management System

**Course:** MIT 8103 — Advanced Database Systems  
**Portfolio:** P2 — Query Processing and Optimisation  
**Database:** Neon PostgreSQL  
**Experiment:** Indexing the `members.join_date` column

## 1. Objective

The objective of this experiment is to investigate how adding an index to the `join_date` column affects PostgreSQL's execution plan and the performance of a query that filters members by their join date.

## 2. Test Environment

- Database: PostgreSQL hosted on Neon
- Table: `members`
- Approximate number of member records: 1,001
- Query filter: `join_date = CURRENT_DATE - 100`
- Index created: `idx_members_join_date`

## 3. Baseline Results — Before Indexing

**SQL query:**

```sql
EXPLAIN ANALYZE
SELECT *
FROM members
WHERE join_date = CURRENT_DATE - 100;
```

- Scan type: [Fill in: Sequential Scan, Index Scan, or other]
- Execution time: [Fill in] ms
- Actual rows returned: [Fill in]
- Planning time: [Fill in] ms

### Baseline execution plan

Paste or summarise the original execution plan here.

## 4. Results — After Indexing

The following index was created:

```sql
CREATE INDEX IF NOT EXISTS idx_members_join_date
ON members(join_date);
```

The table statistics were updated using:

```sql
ANALYZE members;
```

The same query was then executed again using `EXPLAIN ANALYZE`.

- Scan type: [Fill in: Sequential Scan, Index Scan, or other]
- Execution time: [Fill in] ms
- Actual rows returned: [Fill in]
- Planning time: [Fill in] ms

### Execution plan after indexing

Paste or summarise the new execution plan here.

## 5. Comparison

| Measurement | Before Indexing | After Indexing |
|---|---|---|
| Scan type | [Fill in] | [Fill in] |
| Execution time | [Fill in] ms | [Fill in] ms |
| Actual rows returned | [Fill in] | [Fill in] |
| Planning time | [Fill in] ms | [Fill in] ms |

**Did the scan type change?** [Yes/No]

**Did execution time increase or decrease?** [Describe using your measurements.]

## 6. Discussion

An index can help PostgreSQL locate matching rows without scanning every row in a table. However, creating an index does not guarantee that PostgreSQL will use it for every query.

In this experiment, the table contains approximately 1,001 member records. PostgreSQL may choose a sequential scan if it estimates that scanning the table is cheaper than accessing the index and then retrieving the matching rows.

The `ANALYZE` command updates table statistics that help the query planner estimate the cost of different execution plans.

The actual effect of indexing must be evaluated using the recorded execution plans and measurements rather than assuming that the index improved performance.

## 7. Conclusion

This experiment demonstrates how to create and verify an index in PostgreSQL and how to inspect query execution using `EXPLAIN ANALYZE`.

The final conclusion will be completed after comparing the measured execution plans and execution times before and after indexing.
