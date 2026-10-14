# Normalisation — FitCore Gym Management System

## First Normal Form (1NF)

Each table has a primary key, and attributes store individual values rather than repeating groups or lists. For example, member names and contact details are stored in separate columns in the Members table.

## Second Normal Form (2NF)

Each table uses a single-column primary key. Therefore, there are no partial dependencies on part of a composite primary key. Non-key attributes are associated with the primary key of their respective table.

## Third Normal Form (3NF)

The design separates distinct entities into their own tables. For example, membership plan names, durations, and prices are stored in Membership_Plans rather than being repeatedly stored in Members or Memberships. This reduces duplication and helps prevent update anomalies.

## Conclusion

The schema is designed to follow 1NF, 2NF, and 3NF by separating entities, defining keys, and maintaining relationships through foreign keys.
