/*
  Warnings:

  - A unique constraint covering the columns `[enrollment_id]` on the table `WatchedVideo` will be added. If there are existing duplicate values, this will fail.

*/
-- DropIndex
DROP INDEX "WatchedVideo_enrollment_id_content_id_key";

-- CreateIndex
CREATE UNIQUE INDEX "WatchedVideo_enrollment_id_key" ON "WatchedVideo"("enrollment_id");
