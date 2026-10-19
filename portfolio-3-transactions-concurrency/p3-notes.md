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

