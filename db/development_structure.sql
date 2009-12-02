CREATE TABLE "admins" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "user_id" integer);
CREATE TABLE "courses" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "title" varchar(255) NOT NULL, "description" varchar(255), "time" varchar(255), "teacher_id" integer NOT NULL, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "marks" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "value" varchar(255), "date" date, "student_id" integer, "course_id" integer, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "schema_migrations" ("version" varchar(255) NOT NULL);
CREATE TABLE "students" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "user_id" integer);
CREATE TABLE "teachers" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "user_id" integer);
CREATE TABLE "users" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255) NOT NULL, "password" varchar(255), "created_at" datetime, "updated_at" datetime);
CREATE UNIQUE INDEX "unique_schema_migrations" ON "schema_migrations" ("version");
INSERT INTO schema_migrations (version) VALUES ('20091202153205');

INSERT INTO schema_migrations (version) VALUES ('20091202000703');

INSERT INTO schema_migrations (version) VALUES ('20091202014803');

INSERT INTO schema_migrations (version) VALUES ('20091202014935');

INSERT INTO schema_migrations (version) VALUES ('20091202152845');

INSERT INTO schema_migrations (version) VALUES ('20091202153107');