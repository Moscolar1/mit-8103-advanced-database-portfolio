# P3 — Transactions and Concurrency

**Course:** MIT 8103 — Advanced Database Systems  
**Case Study:** FitCore Gym Management System  
**Database:** Neon PostgreSQL

## Experiment 1: Transaction Commit

### 1. Objective

The objective of this experiment was to demonstrate how PostgreSQL transactions save database changes using the `COMMIT` command.

### 2. Procedure

The experiment was performed in Neon PostgreSQL using the following steps:

1. Started a transaction using `BEGIN`.
2. Inserted a fictional membership plan into the `membership_plans` table.
3. Used the `RETURNING` clause to display the inserted record.
4. Executed `COMMIT` to save the transaction.
5. Ran a separate `SELECT` query to verify that the record remained in the database.

### 3. SQL Implementation

```sql
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
```

### 4. Results

The transaction executed successfully in Neon PostgreSQL. The interface showed the three transaction statements: `BEGIN`, `INSERT 1`, and `COMMIT`.

The subsequent verification query returned one matching record with the following values:

| Field | Verified value |
|---|---|
| `plan_id` | 2 |
| `plan_name` | P3 Commit Test Plan 2026 |
| `duration_days` | 30 |
| `price` | 5000.00 |

The verification query confirmed that the inserted record remained available after the transaction was committed.

### 5. Discussion

The experiment demonstrated the purpose of the `COMMIT` command in PostgreSQL. A transaction groups database operations into a unit of work, and committing the transaction makes its changes permanent under normal transaction processing.

The separate verification query provided evidence that the membership plan had been saved successfully. The `RETURNING` clause also made it possible to inspect the inserted record immediately.

### 6. Evidence

The following screenshots provide supporting evidence:

- `Run-transaction.png` — shows the successful execution of `BEGIN`, `INSERT`, and `COMMIT`.
- `Verify-committed-record.png` — shows the record returned by the verification query.

### 7. Conclusion

The transaction commit experiment was successful. PostgreSQL accepted the insertion and commit operations, and a separate query confirmed that the membership plan remained in the database. This demonstrates how transactions can be used to save database changes reliably.


## Experiment 3: Transaction Consistency and Constraint Enforcement

### 1. Objective

The objective was to demonstrate how PostgreSQL enforces database consistency using `CHECK` constraints and prevents invalid data from being stored.

### 2. Procedure

The experiment was conducted in Neon PostgreSQL using the `membership_plans` table.

1. Started a transaction using `BEGIN`.
2. Inserted a valid membership plan with a duration of 14 days and a price of 2500.00.
3. Committed the valid transaction using `COMMIT`.
4. Attempted to insert an invalid membership plan with a duration of zero days.
5. PostgreSQL rejected the invalid insertion because it violated the `chk_plan_duration` constraint.
6. Rolled back the failed transaction.
7. Executed a verification query to confirm which records were stored.

### 3. SQL Implementation

**Valid transaction**

```sql
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
```

**Invalid transaction**

```sql
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
```

**Verification query**

```sql
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
```

### 4. Results

The valid transaction executed successfully. Neon displayed `BEGIN`, `INSERT 1`, and `COMMIT`.

The invalid transaction failed because the supplied duration of zero violated the database's positive-duration requirement. Neon displayed the message `Failed transaction: ROLLBACK required`, indicating that the transaction needed to be rolled back before further operations could proceed.

After the failed transaction was handled, the verification query returned exactly one row.

| Field | Verified result |
|---|---|
| `plan_name` | P3 Consistency Valid Plan 2026 |
| `duration_days` | 14 |
| `price` | 2500.00 |
| Total matching rows | 1 |

The invalid membership plan did not appear in the verification results.

### 5. Discussion

The experiment demonstrated the importance of database constraints in maintaining data integrity. The `chk_plan_duration` constraint prevents membership plans with zero or negative durations from being inserted.

The valid membership plan was committed successfully, while the invalid insertion was rejected. The verification query returned only the valid plan, confirming that the invalid record was not stored.

The `ROLLBACK` requirement message also demonstrated that PostgreSQL marks a transaction as failed when an operation violates a constraint. The failed transaction must be rolled back before the session can continue with normal transaction operations.

### 6. Evidence

The following screenshots document the experiment:

- `exp3-Test-valid-transaction.png` — successful insertion and commit of the valid membership plan.
- `exp3-Test-invalid-transaction.png` — failed transaction and PostgreSQL's rollback requirement message.
- `exp3-Verify-database-state.png` — verification query showing only the valid membership plan.

### 7. Conclusion

The transaction consistency experiment was successful. PostgreSQL accepted and committed the valid membership plan but rejected the invalid insertion because its duration violated the `CHECK` constraint.

The verification query returned one matching record, confirming that the valid plan was stored and the invalid plan was absent. This experiment demonstrates how constraint enforcement and transaction rollback help preserve database consistency.
