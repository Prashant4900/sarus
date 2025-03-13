ALTER TABLE "admins"
  ADD COLUMN "id" serial NOT NULL,
  ADD COLUMN "first_name" text NOT NULL,
  ADD COLUMN "last_name" text NOT NULL,
  ADD COLUMN "password" text NOT NULL,
  ADD COLUMN "email" text NOT NULL,
  ADD COLUMN "role" text NOT NULL,
  ADD COLUMN "status" boolean NOT NULL,
  ADD COLUMN "created_at" text NOT NULL,
  ADD COLUMN "updated_at" text NOT NULL;

ALTER TABLE "admins"
  ADD PRIMARY KEY ( "id" );