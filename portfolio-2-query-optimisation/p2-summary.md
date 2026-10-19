# Portfolio 2 Summary — Query Processing and Optimisation

**Course:** MIT 8103 — Advanced Database Systems  
**Case Study:** FitCore Gym Management System  
**Database:** Neon PostgreSQL

## 1. Overview

This portfolio investigated PostgreSQL query execution plans and indexing techniques using the FitCore Gym Management System. The experiments used `EXPLAIN ANALYZE` to examine execution strategies and record query performance measurements.

## 2. Experiment One: Indexing the Join Date

An index named `idx_members_join_date` was created on the `members.join_date` column.

The initial query plan showed a Sequential Scan, with an execution time of 0.097 ms and planning time of 0.107 ms. A later execution plan showed a Bitmap Index Scan followed by a Bitmap Heap Scan, with an execution time of 1.96 ms and planning time of 5.14 ms.

These results demonstrate that PostgreSQL selected different execution strategies. The measurements do not establish that indexing improved performance, because the execution times varied and further controlled testing would be needed.

## 3. Experiment Two: Multi-Table JOIN

A query joining `members`, `memberships`, and `membership_plans` was examined using `EXPLAIN ANALYZE`. An index named `idx_memberships_start_date` was created on `memberships.start_date` and verified through PostgreSQL's system catalogue.

The initial baseline recorded an execution time of 0.875 ms and planning time of 0.231 ms. A later baseline rerun recorded 9.31 ms and 12.7 ms respectively. A subsequent run with the index present recorded 5.13 ms and 10.8 ms.

The visible execution plans continued to show Sort, Hash Join, and Sequential Scan operators. The results therefore do not establish a consistent performance improvement from the index.

## 4. Lessons Learned

The experiments provided practical experience with:

- Writing SQL queries involving multiple related tables.
- Using `EXPLAIN ANALYZE` to inspect execution plans.
- Creating and verifying PostgreSQL indexes.
- Recognising Sequential Scan, Index Scan, Bitmap Index Scan, Bitmap Heap Scan, Hash Join, and Sort operators.
- Comparing execution and planning times.
- Understanding that indexes do not guarantee improved performance for every query.

## 5. Conclusion

The portfolio demonstrated how PostgreSQL executes queries and how indexes can influence query planning. The experiments also showed the importance of recording actual measurements and interpreting results carefully. Further repeated tests under comparable conditions would be required to establish reliable performance conclusions.

## 6. Evidence

Supporting SQL scripts, execution-plan screenshots, index-verification results, and detailed experimental notes are maintained in the P2 GitHub folder.
