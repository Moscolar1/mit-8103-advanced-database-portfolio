# P3 — Transactions and Concurrency

**Course:** MIT 8103 — Advanced Database Systems  
**Case Study:** FitCore Gym Management System  
**Database:** Neon PostgreSQL

## Experiment 1: Transaction Commit

### 1. Objective

The objective was to demonstrate how PostgreSQL transactions save database changes using the `COMMIT` command.

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

The transaction executed successfully. Neon displayed the statements `BEGIN`, `INSERT 1`, and `COMMIT`.

The verification query returned one matching record:

| Field | Verified value |
|---|---|
| `plan_id` | 2 |
| `plan_name` | P3 Commit Test Plan 2026 |
| `duration_days` | 30 |
| `price` | 5000.00 |

The record remained available after the transaction was committed.

### 5. Discussion

The experiment demonstrated how `COMMIT` saves changes made within a transaction. The separate verification query confirmed that the inserted membership plan persisted after the transaction completed.

The `RETURNING` clause also allowed the inserted record to be inspected immediately.

### 6. Evidence

- `Run-transaction.png` — successful execution of the transaction statements.
- `Verify-committed-record.png` — verification of the committed membership plan.

### 7. Conclusion

The transaction commit experiment was successful. PostgreSQL accepted the insertion and commit operations, and the subsequent query confirmed that the membership plan remained in the database.

---

## Experiment 2: Transaction Rollback

### 1. Objective

The objective was to demonstrate how PostgreSQL reverses uncommitted database changes using the `ROLLBACK` command.

### 2. Procedure

The experiment was performed using the following steps:

1. Started a transaction using `BEGIN`.
2. Inserted a fictional membership plan named `P3 Rollback Test Plan 2026`.
3. Used `RETURNING` to inspect the inserted record.
4. Executed `ROLLBACK` instead of `COMMIT`.
5. Queried the database to check whether the test plan remained.
6. Queried the database again to verify that the previously committed plan remained available.

### 3. SQL Implementation

```sql
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

ROLLBACK;
```

### 4. Results

The rollback script executed successfully. Neon displayed the statements `BEGIN`, `INSERT 1`, and `ROLLBACK`.

The verification queries produced the following results:

| Test | Expected result | Observed result |
|---|---|---|
| Verify rolled-back plan | Zero rows | Zero rows |
| Verify committed plan | One row | One row |

The query for `P3 Rollback Test Plan 2026` returned no rows, confirming that the insertion was undone.

The query for `P3 Commit Test Plan 2026` returned the existing record with these values:

| Field | Verified value |
|---|---|
| `plan_id` | 2 |
| `plan_name` | P3 Commit Test Plan 2026 |
| `duration_days` | 30 |
| `price` | 5000.00 |

### 5. Discussion

The experiment demonstrated that `ROLLBACK` cancels changes made within an uncommitted transaction. Although the `INSERT` statement executed successfully and returned a record during the transaction, the subsequent rollback prevented that insertion from remaining in the database.

The previously committed membership plan was unaffected. This illustrates the difference between committing and rolling back a transaction.

### 6. Evidence

- `Run-rollback-experiment-2.png` — successful execution of `BEGIN`, `INSERT 1`, and `ROLLBACK`.
- `Verify-rollback.png` — verification query showing no matching row for the rolled-back plan.
- `Verify-committed-record-remains.png` — confirmation that the previously committed plan remained available.

### 7. Conclusion

The rollback experiment was successful. PostgreSQL reversed the uncommitted insertion, and the test plan was absent from the database after rollback. The previously committed membership plan remained available.

The experiment demonstrated that `ROLLBACK` can undo uncommitted changes while preserving changes committed in an earlier transaction.

---

## Overall Progress

The following transaction concepts have been demonstrated:

1. **COMMIT:** Saves changes made within a transaction.
2. **ROLLBACK:** Reverses uncommitted changes.
3. **Verification:** Uses subsequent queries to confirm the resulting database state.


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

## Experiment 4: Transaction Isolation and Concurrent Transactions

### 1. Objective

The objective was to explore how PostgreSQL handles transactions in separate SQL Editor sessions when they access and update the same membership plan.

### 2. Procedure

The experiment was conducted in Neon PostgreSQL using two SQL Editor sessions.

1. Created or verified the test plan `P3 Isolation Test Plan 2026`.
2. Started a transaction in Session A using `BEGIN ISOLATION LEVEL READ COMMITTED`.
3. Queried the test plan in Session A.
4. Updated the plan's price to 3500.00 in Session B and executed `COMMIT`.
5. Queried the test plan again in Session A.
6. Attempted to commit Session A. Neon displayed a message indicating that no transaction was in progress.

### 3. Results

The screenshots confirm the following:

| Item | Observed result |
|---|---|
| Test plan ID | 6 |
| Test plan name | P3 Isolation Test Plan 2026 |
| Price after Session B's update | 3500.00 |
| Session B update | Successful |
| Session B commit | Executed successfully |
| Session A commit attempt | Neon reported that no transaction was in progress |

The screenshots establish that the update to 3500.00 was committed. However, the evidence does not conclusively establish the price Session A observed before Session B committed or whether Session A's second read occurred within the same open transaction.

### 4. Discussion

The experiment demonstrated that a change to the test membership plan was successfully committed in Session B.

PostgreSQL's READ COMMITTED isolation level normally gives each SQL statement a snapshot of data committed before that statement begins. Therefore, a transaction that remains open can see a newly committed update in a later SELECT statement under this isolation level.

However, the transaction sequence in this experiment was not fully confirmed. The message indicating that no transaction was in progress suggests that Session A may already have ended its transaction before the COMMIT attempt. Consequently, the screenshots alone are insufficient to claim that the experiment conclusively demonstrated the visibility of a concurrent commit within an ongoing transaction.

### 5. Evidence

- `Create-test-record-in-Session-B.png` — creation or verification of the test membership plan.
- `Start-Transaction-A.png` — Session A transaction setup.
- `Start-run-Transaction-A.png` — additional Session A execution evidence.
- `Update-the-record-in-Session-B.png` — successful update and commit in Session B.
- `Read-the-record-again-in-Session-A.png` — query showing the test plan with a price of 3500.00.
- `Read-the-record-again-in-Session-A-commit.png` — additional Session A query and transaction feedback.

### 6. Conclusion

The update and commit in Session B were successful, and the test plan was shown with the updated price of 3500.00. The transaction isolation behavior itself remains inconclusive because the screenshots do not establish the exact ordering of the reads and commit across the two sessions.

A controlled rerun is needed to demonstrate conclusively how READ COMMITTED handles a concurrent update.

### Experiment 4 Retest: Preventing Dirty Reads

**Objective:** To test whether one database session can read changes made by another session before those changes are committed.

**Isolation level:** `READ COMMITTED`.

**Test record:** `P3 Isolation Test Plan 2026`, with `plan_id = 6`.

#### Procedure

1. Session A began a transaction and retrieved the membership plan's current price of `4000.00`.
2. Session B began a separate transaction and updated the price to `4500.00` without committing.
3. Session A reran the `SELECT` query while Session B's update was uncommitted.
4. Session A continued to return `4000.00`, rather than the uncommitted value of `4500.00`.
5. Session B's update was rolled back, and a subsequent query in Session A returned `4000.00`.

#### Results

| Test stage | Observed price |
|---|---:|
| Initial committed value | 4000.00 |
| Session B's uncommitted update | 4500.00 |
| Session A's query during the uncommitted update | 4000.00 |
| Session A's query after the rollback | 4000.00 |

#### Analysis

Session A did not see Session B's uncommitted update. This demonstrates that PostgreSQL's `READ COMMITTED` isolation level prevents dirty reads. After the update was rolled back, the original committed value remained `4000.00`.

**Conclusion:** The experiment demonstrated that uncommitted changes in one transaction are not visible to another transaction operating under `READ COMMITTED`.

**Evidence:** Screenshots of the initial query, Session B's update, Session A's query during the uncommitted update, and the subsequent price check.


### Experiment 5: Concurrent Transactions and READ COMMITTED Isolation

**Objective:** To observe how PostgreSQL handles concurrent transactions when one session updates a record and another session reads it.

**Test record:** Membership plan `P3 Isolation Test Plan 2026` (`plan_id = 6`).

**Isolation level:** `READ COMMITTED` in Session A.

#### Procedure and observations

1. Session A began a transaction using `BEGIN ISOLATION LEVEL READ COMMITTED` and queried the membership plan. The price was `3500.00`.
2. Session B began a transaction and updated the plan price to `4000.00`. The update remained uncommitted.
3. Session A queried the plan while Session B's update was uncommitted. Session A continued to see the previously committed price of `3500.00`.
4. Session B committed its transaction.
5. Session A reran the `SELECT` query and observed the updated price of `4000.00`. Session A remained in an open transaction.

#### Results

| Observation | Price |
|---|---:|
| Session A before Session B committed | 3500.00 |
| Session B after its update | 4000.00 |
| Session A after Session B committed and the query was rerun | 4000.00 |

#### Analysis

The experiment demonstrates that `READ COMMITTED` prevents Session A from reading Session B's uncommitted changes. Once Session B commits, a subsequent query in Session A can see the newly committed value, even though Session A's transaction has not ended.

This behavior helps maintain data consistency while allowing concurrent database activity. It also illustrates that, under `READ COMMITTED`, separate queries within the same transaction may return different values when other transactions commit changes between those queries.

**Conclusion:** The experiment successfully demonstrated PostgreSQL's `READ COMMITTED` behavior during concurrent transactions.

**Evidence:** Screenshots showing Session A's initial result, Session B's update and committed status, and Session A's subsequent query result.
