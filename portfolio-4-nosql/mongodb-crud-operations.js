// MIT 8103 - Portfolio 4
// FitCore Gym Management System
// MongoDB CRUD Operations

// Select the database and collection
use("fitcore");

const members = db.members;

// ==========================================
// 1. CREATE - Insert a test member
// ==========================================

members.insertOne({
    member_id: 104,
    first_name: "Grace",
    last_name: "Williams",
    email: "grace.test@example.com",
    phone: "080300000004",
    join_date: "2026-11-01",
    account_status: "active"
});

// ==========================================
// 2. READ - Retrieve all members
// ==========================================

members.find().pretty();

// Retrieve one member by member ID
members.findOne({
    member_id: 104
});

// ==========================================
// 3. UPDATE - Change member account status
// ==========================================

members.updateOne(
    { member_id: 104 },
    {
        $set: {
            account_status: "inactive"
        }
    }
);

// Verify the update
members.findOne({
    member_id: 104
});

// ==========================================
// 4. DELETE - Remove the test member
// ==========================================

members.deleteOne({
    member_id: 104
});

// Verify deletion
members.findOne({
    member_id: 104
});
