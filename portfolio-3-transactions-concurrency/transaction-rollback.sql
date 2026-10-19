
-- MIT 8103: Advanced Database Systems
-- Portfolio 3: Transactions and Concurrency
-- Experiment 2: Transaction Rollback

BEGIN;

INSERT INTO membership_plans (
    plan_name,
    duration_days,
    price
)
VALUES (
    'P3 Rollback Test Plan 2026',
    7,
    1500.00
)
RETURNING plan_id, plan_name, duration_days, price;

-- Undo the uncommitted insertion
ROLLBACK;
