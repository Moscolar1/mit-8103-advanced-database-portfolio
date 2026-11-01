# Portfolio 4: NoSQL and Advanced Data Models

## 1. Introduction

This portfolio explores the implementation of a NoSQL database using MongoDB Atlas for the FitCore Gym Management System.

The objective is to demonstrate how a document-oriented database can store, retrieve, update, delete, filter and aggregate gym member information.

## 2. Database Technology

- **Database:** MongoDB
- **Platform:** MongoDB Atlas
- **Database name:** `fitcore`
- **Collection:** `members`
- **Data model:** Document-oriented model

## 3. Practical Experiments

The following activities were implemented:

1. MongoDB database and collection creation.
2. Inserting member documents.
3. CRUD operations (Create, Read, Update and Delete).
4. Filtering and retrieving documents using MongoDB query operators.
5. Aggregation using the `$group` and `$sum` operators to calculate member totals by account status.

## 4. Aggregation Implementation

The aggregation pipeline groups member records according to their account status and counts the documents in each group.

```javascript
[
  {
    "$group": {
      "_id": "$account_status",
      "total_members": {
        "$sum": 1
      }
    }
  }
]
```

The executed pipeline returned three active member records in the current test result.

## 5. Suitability of MongoDB

MongoDB is suitable for FitCore because its document-oriented structure supports flexible storage of member information. It also provides query and aggregation capabilities for retrieving and analysing gym membership data.

Unlike a traditional relational model, MongoDB allows related information to be represented within flexible documents where appropriate.

## 6. Evidence

Screenshots of the MongoDB Atlas configuration, collection, document operations, filtering queries and aggregation results are maintained in the evidence folder.

## 7. Conclusion

The implementation demonstrates the practical use of MongoDB as a NoSQL database for the FitCore Gym Management System. The experiments provide experience with document storage, CRUD operations, query filtering and aggregation.


