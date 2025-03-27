/*
  Warnings:

  - You are about to drop the column `comment_owner` on the `Comment` table. All the data in the column will be lost.
  - Added the required column `comment_owner_id` to the `Comment` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "Comment" DROP COLUMN "comment_owner",
ADD COLUMN     "comment_owner_id" TEXT NOT NULL;

-- AddForeignKey
ALTER TABLE "Comment" ADD CONSTRAINT "Comment_comment_owner_id_fkey" FOREIGN KEY ("comment_owner_id") REFERENCES "Users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
