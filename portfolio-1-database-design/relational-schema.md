# Relational Schema — FitCore Gym Management System

## 1. Members

**Members**(
member_id PK,
first_name,
last_name,
email UNIQUE,
phone,
join_date,
account_status
)

## 2. Membership Plans

**Membership_Plans**(
plan_id PK,
plan_name UNIQUE,
duration_days,
price
)

## 3. Memberships

**Memberships**(
membership_id PK,
member_id FK → Members.member_id,
plan_id FK → Membership_Plans.plan_id,
start_date,
end_date,
membership_status
)

## 4. Payments

**Payments**(
payment_id PK,
membership_id FK → Memberships.membership_id,
amount,
payment_date,
payment_method,
payment_status,
transaction_reference UNIQUE
)

## 5. Check-ins

**Check_Ins**(
check_in_id PK,
member_id FK → Members.member_id,
checked_in_at,
checked_out_at
)

## 6. Trainers

**Trainers**(
trainer_id PK,
first_name,
last_name,
email UNIQUE
)

## 7. Training Sessions

**Training_Sessions**(
session_id PK,
member_id FK → Members.member_id,
trainer_id FK → Trainers.trainer_id,
scheduled_at,
session_status
)

## 8. Equipment

**Equipment**(
equipment_id PK,
equipment_name,
serial_number UNIQUE,
purchase_date,
equipment_status
)

## 9. Maintenance Requests

**Maintenance_Requests**(
request_id PK,
equipment_id FK → Equipment.equipment_id,
issue_description,
priority,
request_status,
reported_date
)
