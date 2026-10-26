
-- P3 Experiment 4: Prepare isolation test data
--Create a test record in Session B

INSERT INTO membership_plans (
    plan_name,
    duration_days,
    price
)
VALUES (
    'P3 Isolation Test Plan 2026',
    30,
    3000.00
)
ON CONFLICT (plan_name) DO NOTHING;

SELECT plan_id, plan_name, duration_days, price
FROM membership_plans
WHERE plan_name = 'P3 Isolation Test Plan 2026';


--Start Transaction A
BEGIN ISOLATION LEVEL READ COMMITTED;

SELECT plan_id, plan_name, price
FROM membership_plans
WHERE plan_name = 'P3 Isolation Test Plan 2026';


--Update the record in Session B
BEGIN;

UPDATE membership_plans
SET price = 3500.00
WHERE plan_name = 'P3 Isolation Test Plan 2026';

COMMIT;

--Read the record again in Session A

SELECT plan_id, plan_name, price
FROM membership_plans
WHERE plan_name = 'P3 Isolation Test Plan 2026';


COMMIT;
