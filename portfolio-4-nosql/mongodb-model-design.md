# MongoDB Document Model Design

## 1. Overview

The FitCore Gym Management System uses MongoDB Atlas as its NoSQL database platform. MongoDB implements a document-oriented data model in which records are stored as BSON documents inside collections.

For this implementation, the database is named `fitcore`, and the collection used is `members`.

## 2. Document Structure

Each member is represented as an individual document containing the following fields:

| Field | Description |
|---|---|
| `_id` | MongoDB-generated unique document identifier |
| `member_id` | Unique gym member reference |
| `first_name` | Member's first name |
| `last_name` | Member's surname |
| `email` | Member's email address |
| `phone` | Member's phone number |
| `join_date` | Date the member joined the gym |
| `account_status` | Current member account status |

### Sample MongoDB Document

```json
{
  "member_id": 101,
  "first_name": "Daniel",
  "last_name": "Test",
  "email": "daniel@example.test",
  "phone": "080300000001",
  "join_date": "2026-10-01",
  "account_status": "active"
}
```

The sample represents a synthetic test record.

## 3. NoSQL Operations Implemented

The following operations were demonstrated:

- Document insertion using `insertOne()`.
- Document retrieval using `find()` and `findOne()`.
- Document modification using `updateOne()`.
- Document deletion using `deleteOne()`.
- Filtering using equality conditions and operators such as `$in`, `$gt` and `$lt`.
- Aggregation using `$group` and `$sum`.

## 4. Aggregation

An aggregation pipeline was implemented to group gym members according to their account status.

The `$group` stage identifies each account status, while `$sum: 1` counts the number of documents belonging to each group.

The executed test returned three active members.

## 5. Suitability of MongoDB for FitCore

MongoDB is suitable for the FitCore Gym Management System because it provides a flexible document structure for storing member information.

Its document-oriented approach allows additional member attributes to be introduced without requiring the same fixed relational table structure.

MongoDB also provides filtering and aggregation features that support retrieving and analysing member records.

## 6. Comparison with PostgreSQL

PostgreSQL was used for the relational database implementation, while MongoDB was used for the NoSQL implementation.

PostgreSQL organises information into related tables with defined relationships and constraints. MongoDB stores information as documents within collections.

Both technologies can support FitCore, but they provide different approaches to data organisation and retrieval.

## 7. Conclusion

The MongoDB implementation demonstrated the practical use of a document-oriented NoSQL database through CRUD operations, filtering and aggregation.

The experiment provided an understanding of how flexible document storage can support the data management requirements of the FitCore Gym Management System.

