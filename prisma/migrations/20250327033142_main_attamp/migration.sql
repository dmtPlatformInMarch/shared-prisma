/*
  Warnings:

  - Added the required column `total_correct_answers` to the `UserQuizAttempt` table without a default value. This is not possible if the table is not empty.
  - Added the required column `total_questions` to the `UserQuizAttempt` table without a default value. This is not possible if the table is not empty.
  - Added the required column `total_wrong_answers` to the `UserQuizAttempt` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "UserQuizAttempt" ADD COLUMN     "total_correct_answers" INTEGER NOT NULL,
ADD COLUMN     "total_questions" INTEGER NOT NULL,
ADD COLUMN     "total_wrong_answers" INTEGER NOT NULL;

-- CreateTable
CREATE TABLE "UserQuizAttemptAnswer" (
    "id" TEXT NOT NULL,
    "attempt_id" TEXT NOT NULL,
    "option_name" TEXT NOT NULL,
    "is_correct" BOOLEAN NOT NULL,
    "question_name" TEXT NOT NULL,

    CONSTRAINT "UserQuizAttemptAnswer_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "UserQuizAttemptAnswer" ADD CONSTRAINT "UserQuizAttemptAnswer_attempt_id_fkey" FOREIGN KEY ("attempt_id") REFERENCES "UserQuizAttempt"("attempt_id") ON DELETE RESTRICT ON UPDATE CASCADE;
