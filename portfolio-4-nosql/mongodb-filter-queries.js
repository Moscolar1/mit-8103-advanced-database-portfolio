// MIT 8103 - Portfolio 4
// FitCore Gym Management System
// MongoDB Filtering Queries

use("fitcore");

const members = db.members;

// ==========================================
// 1. Retrieve all active members
// ==========================================

members.find({
    account_status: "active"
}).pretty();

// ==========================================
// 2. Retrieve members with member_id 103
// ==========================================

members.find({
    member_id: 103
}).pretty();

// ==========================================
// 3. Retrieve members with active or inactive status
// Using the $in operator
// ==========================================

members.find({
    account_status: {
        $in: ["active", "inactive"]
    }
}).pretty();

// ==========================================
// 4. Retrieve members with member_id greater than 101
// Using the $gt operator
// ==========================================

members.find({
    member_id: {
        $gt: 101
    }
}).pretty();

// ==========================================
// 5. Retrieve members with member_id less than 103
// Using the $lt operator
// ==========================================

members.find({
    member_id: {
        $lt: 103
    }
}).pretty();
