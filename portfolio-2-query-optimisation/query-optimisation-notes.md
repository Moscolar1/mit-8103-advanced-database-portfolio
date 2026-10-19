# Query Optimisation Notes — FitCore Gym Management System

**Course:** MIT 8103 — Advanced Database Systems  
**Portfolio:** P2 — Query Processing and Optimisation  
**Database:** Neon PostgreSQL  
**Experiment:** Indexing the `members.join_date` Column

## 1. Objective

The objective of this experiment is to investigate how indexing affects PostgreSQL query execution plans and performance. The experiment uses `EXPLAIN ANALYZE` to inspect query execution before and after creating an index on the `join_date` column.

## 2. Test Environment

- Database platform: Neon PostgreSQL
- Table: `members`
- Approximate number of member records: 1,001
- Indexed column: `join_date`
- Index name: `idx_members_join_date`
- Test data: Fictional member records

## 3. Query Used in the Experiment

The same query was used to investigate how PostgreSQL retrieves members who joined 100 days before the current date.

```sql
EXPLAIN ANALYZE
SELECT *
FROM members
WHERE join_date = CURRENT_DATE - 100;
```

## 4. Baseline Results — Sequential Scan

The initial execution plan showed a sequential scan on the `members` table.

**Recorded measurements:**

- Scan type: Sequential Scan
- Execution time: 0.097 ms
- Planning time: 0.107 ms
- Actual rows returned: Not recorded in the available screenshot

### Interpretation

PostgreSQL examined the `members` table using a sequential scan to locate rows matching the date condition. This approach can be efficient for relatively small tables because scanning the table may cost less than accessing an index and retrieving the matching records.

## 5. Index Creation

The following SQL command was executed successfully:

```sql
CREATE INDEX idx_members_join_date
ON members(join_date);
```

The table statistics were then updated using:

```sql
ANALYZE members;
```

The index was verified through the PostgreSQL system catalogue. The results showed three indexes associated with the `members` table:

1. `idx_members_join_date`
2. `members_email_key`
3. `members_pkey`

This confirmed that the new index was present alongside the existing indexes for email uniqueness and the primary key.

## 6. Results — After Indexing

After creating the index, the same date-filtering query produced an index-assisted execution plan.

**Recorded measurements:**

- Scan type: Bitmap Index Scan followed by Bitmap Heap Scan
- Execution time: 1.96 ms
- Planning time: 5.14 ms
- Actual rows shown in the plan: 3

### Interpretation

The Bitmap Index Scan used `idx_members_join_date` to identify matching records. PostgreSQL then used a Bitmap Heap Scan to retrieve the corresponding rows from the `members` table.

This demonstrates that PostgreSQL selected an index-assisted execution plan for the query. However, using an index does not automatically mean that a query will execute faster.

## 7. Comparison of Execution Plans

| Measurement | Before Indexing | After Indexing |
|---|---|---|
| Scan type | Sequential Scan | Bitmap Index Scan + Bitmap Heap Scan |
| Execution time | 0.097 ms | 1.96 ms |
| Planning time | 0.107 ms | 5.14 ms |
| Actual rows returned | Not recorded | 3 |

### Did the scan type change?

Yes. The initial execution plan showed a Sequential Scan. After the index was created, the plan showed a Bitmap Index Scan followed by a Bitmap Heap Scan.

### Did execution time improve?

No improvement was observed in the two recorded runs. The initial execution time was 0.097 ms, while the later execution time was 1.96 ms.

The later run also reported a higher planning time. These results describe the observed runs, but they do not establish that the index generally reduces performance. Execution timings can vary because of caching, database activity, and other environmental factors. The runs should be repeated under comparable conditions before drawing a firm performance conclusion.

## 8. Discussion

The experiment demonstrates that PostgreSQL can choose different execution strategies for the same query. Initially, it used a Sequential Scan. After the index was created, it selected a Bitmap Index Scan and Bitmap Heap Scan.

A sequential scan may be appropriate when a table is small or when a significant proportion of its rows must be retrieved. An index-assisted plan may be beneficial when it allows PostgreSQL to locate a smaller subset of rows efficiently.

The results also show that indexing involves trade-offs. Indexes require storage and introduce maintenance overhead when data is inserted, updated, or deleted. Therefore, indexes should be evaluated against actual query patterns and measured performance rather than added without analysis.

The experiment used approximately 1,001 member records. Repeated tests with consistent conditions and a larger dataset could provide a stronger basis for evaluating the index's performance.

## 9. Limitations

The available measurements come from individual executions, and the baseline and indexed runs may have been affected by different cache or database conditions. The original screenshot did not record the baseline row count.

Consequently, the results are sufficient to document the observed change in execution plan, but further controlled testing would be needed to establish a reliable performance comparison.

## 10. Conclusion

The experiment successfully created and verified an index on `members.join_date`. The observed execution plan changed from a Sequential Scan to a Bitmap Index Scan followed by a Bitmap Heap Scan.

The indexed run had a higher recorded execution time than the baseline run. This illustrates why query optimisation should be evaluated using execution plans and measurements rather than assuming that adding an index always improves performance.

The experiment provided practical experience with PostgreSQL indexing, `EXPLAIN ANALYZE`, execution-plan interpretation, and performance evaluation.

## 11. Additional Experiment: Optimising a Multi-Table JOIN Query

### Objective

This experiment investigated the execution plan of a query joining the `members`, `memberships`, and `membership_plans` tables. An index was created on the membership start date to investigate whether it affected query execution.

### Baseline Query

```sql
EXPLAIN ANALYZE
SELECT
    m.member_id,
    m.first_name,
    m.last_name,
    p.plan_name,
    ms.start_date,
    ms.end_date,
    ms.membership_status
FROM memberships AS ms
JOIN members AS m
    ON ms.member_id = m.member_id
JOIN membership_plans AS p
    ON ms.plan_id = p.plan_id
ORDER BY ms.start_date DESC;
```

### Index Created

```sql
CREATE INDEX IF NOT EXISTS idx_memberships_start_date
ON memberships(start_date DESC);
```

The index was verified through PostgreSQL's `pg_indexes` catalogue and appeared in the results for the `memberships` table.

### Observed Results

| Measurement | Initial baseline | Later run with index present |
|---|---:|---:|
| Execution time | 0.875 ms | 5.13 ms |
| Planning time | 0.231 ms | 10.8 ms |
| Visible plan operators | Sort, Hash Join, Sequential Scan | Sort, Hash Join, Sequential Scan |

A separate baseline rerun reported an execution time of 9.31 ms and planning time of 12.7 ms.

### Discussion

The index on `memberships.start_date` was successfully created and verified. However, the visible execution plan after indexing continued to show Sort, Hash Join, and Sequential Scan operators. The screenshot did not clearly show the new index being used by the query plan.

The recorded execution and planning times varied between runs. Therefore, the measurements do not establish that the index improved or reduced overall performance. Database activity, caching, and other execution conditions may affect timings.

PostgreSQL's query planner selects an execution strategy based on estimated costs. An index may exist without being selected when the planner estimates that another plan is more suitable.

### Conclusion

This experiment demonstrated how to inspect a multi-table JOIN query, create an index, verify its existence, and compare execution plans. The results show that creating an index does not guarantee that PostgreSQL will use it or that execution time will decrease. Further repeated testing under comparable conditions would be required for a stronger performance conclusion.
