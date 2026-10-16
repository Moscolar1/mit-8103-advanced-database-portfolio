
-- MIT 8103: Advanced Database Systems
-- Portfolio 2: Query Processing and Optimisation
-- Case Study: FitCore Gym Management System
-- Experiment: Indexing the members.join_date column

-- 1. BASELINE: Run before creating the index.
-- Record the scan type and execution time.
EXPLAIN ANALYZE
SELECT *
FROM members
WHERE join_date = CURRENT_DATE - 100;


-- 2. CREATE INDEX: Add an index on join_date.
CREATE INDEX IF NOT EXISTS idx_members_join_date
ON members(join_date);


-- 3. UPDATE STATISTICS: Help PostgreSQL estimate query costs.
ANALYZE members;


-- 4. AFTER INDEX: Run the same query for comparison.
EXPLAIN ANALYZE
SELECT *
FROM members
WHERE join_date = CURRENT_DATE - 100;


-- 5. VERIFY INDEX: Confirm that the index exists.
SELECT
    indexname,
    indexdef
FROM pg_indexes
WHERE schemaname = 'public'
  AND tablename = 'members'
ORDER BY indexname;
