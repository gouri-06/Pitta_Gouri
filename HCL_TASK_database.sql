

'''database name - fund_transfer'''
''' derby sql database'''


CREATE TABLE "account_transactions" (
  "transaction_id" int NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
  "transaction_date" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "amount" int NOT NULL,
  "to_account" int NOT NULL,
  "from_account" int NOT NULL,
  PRIMARY KEY ("transaction_id")
);

CREATE TABLE "account_details" (
  "sl.no" int NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
  "account_no" int NOT NULL,
  "holder_name" varchar(50) NOT NULL,
  "balance" int NOT NULL,
  PRIMARY KEY ("sl.no")
);

INSERT INTO "account_details" ("account_no","holder_name","balance") VALUES (53937828,'anusha',10000),(53937829,'shan',20000),(53937830,'vidya',100000);