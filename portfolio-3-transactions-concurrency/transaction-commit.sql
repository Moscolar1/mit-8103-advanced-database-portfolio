
-- MIT 8103: Advanced Database Systems
-- Portfolio 3: Transactions and Concurrency
-- Experiment 1: Transaction Commit

BEGIN;

INSERT INTO membership_plans (
    plan_name,
    duration_days,
    price
)
VALUES (
    'P3 Commit Test Plan 2026',
    30,
    5000.00
)
RETURNING plan_id, plan_name, duration_days, price;

COMMIT;
