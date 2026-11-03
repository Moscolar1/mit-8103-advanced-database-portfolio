# AKINOLA MOSES - m.akinola8507@miva.edu.ng

# MIT-8103-advanced-database-portfolio
MIT 8103 Advanced Database Systems — Individual Practical Database Portfolio, 2026/2027

# MIT 8103 – Advanced Database Systems
## Individual Technical Reflection

**Case Study: FitCore Gym Management System**

### Technical Reflection

Working on the FitCore Gym Management System has helped me understand how database concepts are applied to practical business situations. I approached the assessment by developing the system across five portfolio activities, using PostgreSQL, MongoDB, Neon and MongoDB Atlas.

**Portfolio 1: Database Design and Modelling**

I began by identifying the major data requirements of a gym management system. I designed a relational database consisting of nine tables: members, membership plans, memberships, payments, check-ins, trainers, training sessions, equipment and maintenance requests. I applied primary keys, foreign keys, unique constraints and other integrity rules to maintain relationships and prevent invalid records. I also considered normalisation from first normal form to third normal form. This activity taught me the importance of proper database planning before implementation.

**Portfolio 2: Query Processing and Optimisation**

In this portfolio, I worked with SQL queries, inserted 1,000 fictional member records and examined query execution plans using `EXPLAIN ANALYZE`. I experimented with indexes, including an email index and a join-date index. One important observation was that PostgreSQL used an index scan for the email search, while a query involving the join-date field still showed a sequential scan after indexing. This helped me understand that creating an index does not automatically guarantee that the database will use it. Query performance depends on factors such as the query, available data and the database query planner.

**Portfolio 3: Transactions and Concurrency**

This activity introduced me to transaction management and the importance of maintaining reliable database operations. I worked with transaction commands, including `COMMIT` and `ROLLBACK`, and explored the READ COMMITTED isolation level using separate database sessions. In one experiment, I observed that an uncommitted price update was not visible to another session. After the update was committed, the other session could see the new value in a subsequent query. This demonstrated how transaction isolation helps prevent dirty reads and supports data consistency.

**Portfolio 4: NoSQL and Advanced Data Models**

I implemented a document-oriented database using MongoDB Atlas. I created the `fitcore` database and the `members` collection, inserted sample member documents, and performed CRUD operations. I also tested filtering using equality conditions and operators such as `$in`, `$gt` and `$lt`. Finally, I created an aggregation pipeline to group members by account status and count the records in each group. The aggregation returned three active members in the tested dataset. This activity helped me understand the flexibility of document databases and how they differ from relational databases.

**Portfolio 5: Distributed and Cloud Databases**

For this activity, I explored cloud database deployment using Neon PostgreSQL and MongoDB Atlas. I verified the Neon PostgreSQL connection and executed a query that returned 1,001 member records. I also used my MongoDB Atlas Fitcore cluster, which displayed a three-node replica-set deployment. I documented the architecture, cloud deployment, PostgreSQL verification and replication and fault-tolerance concepts. This activity improved my understanding of cloud-hosted databases, database availability and the importance of reliable infrastructure.

### Challenges and Lessons Learned

One of my major challenges was becoming familiar with database tools and interfaces, particularly MongoDB Atlas aggregation pipelines and cloud database configuration. I also had to interpret execution plans and understand why an index was not always selected by PostgreSQL. Working through these challenges improved my troubleshooting, analytical and problem-solving skills.

The most important lesson I gained is that database development involves more than writing SQL statements. Good database systems require appropriate design, data integrity, performance optimisation, transaction management, suitable data models and reliable deployment. I also learned the importance of testing database operations and retaining screenshots and documentation as evidence of implementation.

Overall, this assessment has strengthened my practical understanding of advanced database systems and increased my confidence in working with relational, NoSQL and cloud database technologies.
