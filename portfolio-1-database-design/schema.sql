
-- MIT 8103: Advanced Database Systems
-- Portfolio 1: FitCore Gym Management System
-- PostgreSQL relational schema

CREATE TABLE members (
    member_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    phone VARCHAR(25),
    join_date DATE NOT NULL DEFAULT CURRENT_DATE,
    account_status VARCHAR(20) NOT NULL DEFAULT 'active',
    CONSTRAINT chk_member_status
        CHECK (account_status IN ('active', 'inactive', 'suspended'))
);

CREATE TABLE membership_plans (
    plan_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    plan_name VARCHAR(50) NOT NULL UNIQUE,
    duration_days INTEGER NOT NULL,
    price NUMERIC(10,2) NOT NULL,
    CONSTRAINT chk_plan_duration CHECK (duration_days > 0),
    CONSTRAINT chk_plan_price CHECK (price >= 0)
);

CREATE TABLE memberships (
    membership_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    member_id INTEGER NOT NULL REFERENCES members(member_id),
    plan_id INTEGER NOT NULL REFERENCES membership_plans(plan_id),
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    membership_status VARCHAR(20) NOT NULL DEFAULT 'active',
    CONSTRAINT chk_membership_dates CHECK (end_date >= start_date),
    CONSTRAINT chk_membership_status
        CHECK (membership_status IN ('active', 'expired', 'cancelled', 'pending'))
);

CREATE TABLE payments (
    payment_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    membership_id INTEGER NOT NULL REFERENCES memberships(membership_id),
    amount NUMERIC(10,2) NOT NULL,
    payment_date TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    payment_method VARCHAR(20) NOT NULL,
    payment_status VARCHAR(20) NOT NULL DEFAULT 'pending',
    transaction_reference VARCHAR(100) UNIQUE,
    CONSTRAINT chk_payment_amount CHECK (amount > 0),
    CONSTRAINT chk_payment_method
        CHECK (payment_method IN ('cash', 'card', 'transfer', 'online')),
    CONSTRAINT chk_payment_status
        CHECK (payment_status IN ('pending', 'successful', 'failed', 'refunded'))
);

CREATE TABLE check_ins (
    check_in_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    member_id INTEGER NOT NULL REFERENCES members(member_id),
    checked_in_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    checked_out_at TIMESTAMPTZ,
    CONSTRAINT chk_checkin_times
        CHECK (checked_out_at IS NULL OR checked_out_at >= checked_in_at)
);

CREATE TABLE trainers (
    trainer_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE
);

CREATE TABLE training_sessions (
    session_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    member_id INTEGER NOT NULL REFERENCES members(member_id),
    trainer_id INTEGER NOT NULL REFERENCES trainers(trainer_id),
    scheduled_at TIMESTAMPTZ NOT NULL,
    session_status VARCHAR(20) NOT NULL DEFAULT 'scheduled',
    CONSTRAINT chk_session_status
        CHECK (session_status IN ('scheduled', 'completed', 'cancelled'))
);

CREATE TABLE equipment (
    equipment_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    equipment_name VARCHAR(100) NOT NULL,
    serial_number VARCHAR(100) UNIQUE,
    purchase_date DATE,
    equipment_status VARCHAR(20) NOT NULL DEFAULT 'operational',
    CONSTRAINT chk_equipment_status
        CHECK (equipment_status IN ('operational', 'under_maintenance', 'retired')),
    CONSTRAINT chk_purchase_date
        CHECK (purchase_date IS NULL OR purchase_date <= CURRENT_DATE)
);

CREATE TABLE maintenance_requests (
    request_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    equipment_id INTEGER NOT NULL REFERENCES equipment(equipment_id),
    issue_description TEXT NOT NULL,
    priority VARCHAR(20) NOT NULL DEFAULT 'medium',
    request_status VARCHAR(20) NOT NULL DEFAULT 'open',
    reported_date DATE NOT NULL DEFAULT CURRENT_DATE,
    CONSTRAINT chk_maintenance_priority
        CHECK (priority IN ('low', 'medium', 'high', 'urgent')),
    CONSTRAINT chk_maintenance_status
        CHECK (request_status IN ('open', 'in_progress', 'resolved', 'closed'))
);

-- Verify table creation
SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public'
  AND table_type = 'BASE TABLE'
ORDER BY table_name;
