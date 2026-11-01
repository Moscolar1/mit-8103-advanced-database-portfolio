// MIT 8103 - Portfolio 4
// FitCore Gym Management System
// MongoDB Aggregation Pipeline

use("fitcore");

const members = db.members;

// ==========================================
// Group members by account status
// Count the number of members in each group
// ==========================================

members.aggregate([
    {
        $group: {
            _id: "$account_status",
            total_members: {
                $sum: 1
            }
        }
    }
]);

// ==========================================
// Optional: Sort results by account status
// ==========================================

members.aggregate([
    {
        $group: {
            _id: "$account_status",
            total_members: {
                $sum: 1
            }
        }
    },
    {
        $sort: {
            _id: 1
        }
    }
]);
