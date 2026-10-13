# Business Rules — FitCore Gym Management System

**BR01:** Every gym member must have a unique member ID and email address.

**BR02:** The gym offers multiple membership plans, each with a defined duration and price.

**BR03:** A member can have multiple membership records over time.

**BR04:** Each membership must belong to exactly one member and one membership plan.

**BR05:** A membership can have multiple payment records, and each payment must be linked to one membership.

**BR06:** Each gym check-in must be associated with one registered member.

**BR07:** A trainer can conduct multiple training sessions, and a member can attend multiple training sessions.

**BR08:** Each training session must be assigned to one trainer and one member.

**BR09:** Each equipment item can have multiple maintenance requests, and each request must be associated with one equipment item.

**BR10:** All essential relationships must be enforced using foreign keys, and invalid values must be rejected using appropriate database constraints.
