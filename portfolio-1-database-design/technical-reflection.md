# Technical Reflection — FitCore Gym Management System

## 1. Introduction

The FitCore Gym Management System was developed as part of Portfolio 1 for MIT 8103: Advanced Database Systems. The project applies relational database design principles to a gym environment that manages members, membership plans, payments, check-ins, trainers, training sessions, equipment and maintenance requests.

## 2. Design Decisions

PostgreSQL was selected to implement the relational database. The system contains nine tables, each representing a distinct entity. Primary keys identify records, while foreign keys establish relationships between related tables. UNIQUE, NOT NULL and CHECK constraints help maintain data integrity.

## 3. Implementation and Testing

The schema was executed in Neon PostgreSQL. Verification queries confirmed the presence of the nine tables and examined their foreign-key relationships. Test records were inserted for a membership plan and a fictional member. A membership, payment and check-in were then created and retrieved using SQL JOIN operations.

Negative tests demonstrated that PostgreSQL rejected an invalid membership status and a membership referencing a nonexistent member. These tests provided evidence that the relevant CHECK and foreign-key constraints were enforced.

## 4. Challenges and Learning

One important lesson was that successful table creation is only the beginning of database development. The database also needs to be tested with valid and invalid data. Writing JOIN queries improved my understanding of how related records can be retrieved from multiple tables.

## 5. Future Improvements

Future improvements could include broader testing of all tables and constraints, more sample records, performance analysis using EXPLAIN, and further review of normalisation. The system could also be extended to support more detailed payment reconciliation, trainer scheduling and equipment maintenance reporting.

## 6. Conclusion

This project provided practical experience in relational database modelling, PostgreSQL implementation, integrity constraints and SQL verification. The work provides a foundation for the subsequent portfolio activities on query optimisation, transaction management, NoSQL databases and distributed or cloud databases.
