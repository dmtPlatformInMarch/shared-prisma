-- DropForeignKey
ALTER TABLE "WatchedVideo" DROP CONSTRAINT "WatchedVideo_content_id_fkey";

-- AlterTable
ALTER TABLE "WatchedVideo" ADD COLUMN     "quize_idx" INTEGER,
ALTER COLUMN "content_id" DROP NOT NULL;

-- AddForeignKey
ALTER TABLE "WatchedVideo" ADD CONSTRAINT "WatchedVideo_content_id_fkey" FOREIGN KEY ("content_id") REFERENCES "Content"("content_id") ON DELETE SET NULL ON UPDATE CASCADE;
