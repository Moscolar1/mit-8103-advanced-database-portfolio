
-- MIT 8103: Advanced Database Systems
-- P3 Experiment 3: Transaction Consistency
--Test a valid transaction
BEGIN;

INSERT INTO membership_plans (
    plan_name,
    duration_days,
    price
)
VALUES (
    'P3 Consistency Valid Plan 2026',
    14,
    2500.00
);

COMMIT;



-- Attempt to insert a membership plan with an invalid duration

BEGIN;

INSERT INTO membership_plans (
    plan_name,
    duration_days,
    price
)
VALUES (
    'P3 Consistency Invalid Plan 2026',
    0,
    2500.00
);

ROLLBACK;


--Verify the database state
SELECT
    plan_name,
    duration_days,
    price
FROM membership_plans
WHERE plan_name IN (
    'P3 Consistency Valid Plan 2026',
    'P3 Consistency Invalid Plan 2026'
)
ORDER BY plan_name;

