BEGIN TRANSACTION;
ALTER TABLE "Students" ADD "Address" TEXT NOT NULL DEFAULT '';

INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
VALUES ('20250918112015_AddAddressToStudent', '9.0.9');

ALTER TABLE "Students" ADD "Gender" TEXT NOT NULL DEFAULT '';

INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
VALUES ('20250918114835_AddGenderToStudent', '9.0.9');

COMMIT;

