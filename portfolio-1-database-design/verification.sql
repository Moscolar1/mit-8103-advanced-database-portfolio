-- MIT 8103: Advanced Database Systems
-- Portfolio 1: FitCore Gym Management System
-- Database verification and functional tests

-- 1. Verify that all nine tables exist
SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public'
  AND table_type = 'BASE TABLE'
ORDER BY table_name;

-- 2. Verify foreign-key relationships
SELECT
    tc.table_name,
    kcu.column_name,
    ccu.table_name AS referenced_table,
    ccu.column_name AS referenced_column
FROM information_schema.table_constraints AS tc
JOIN information_schema.key_column_usage AS kcu
    ON tc.constraint_name = kcu.constraint_name
   AND tc.constraint_schema = kcu.constraint_schema
JOIN information_schema.constraint_column_usage AS ccu
    ON ccu.constraint_name = tc.constraint_name
   AND ccu.constraint_schema = tc.constraint_schema
WHERE tc.constraint_type = 'FOREIGN KEY'
  AND tc.table_schema = 'public'
ORDER BY tc.table_name, kcu.column_name;

-- 3. Verify the membership, member and plan relationship
SELECT
    m.first_name,
    m.last_name,
    m.email,
    p.plan_name,
    ms.start_date,
    ms.end_date,
    ms.membership_status
FROM memberships AS ms
JOIN members AS m
    ON ms.member_id = m.member_id
JOIN membership_plans AS p
    ON ms.plan_id = p.plan_id
WHERE m.email = 'daniel.testmember@example.com';

-- 4. Verify payment and check-in records
SELECT
    m.first_name,
    m.last_name,
    p.amount,
    p.payment_method,
    p.payment_status,
    c.checked_in_at,
    c.checked_out_at
FROM members AS m
JOIN memberships AS ms
    ON m.member_id = ms.member_id
JOIN payments AS p
    ON ms.membership_id = p.membership_id
JOIN check_ins AS c
    ON m.member_id = c.member_id
WHERE m.email = 'daniel.testmember@example.com'
  AND p.transaction_reference = 'FITCORE-TEST-PAY-001';

-- 5. Negative tests performed separately:
-- Invalid membership status was rejected by the CHECK constraint.
-- A nonexistent member ID was rejected by the foreign key constraint.
-- Both tests were rolled back.
