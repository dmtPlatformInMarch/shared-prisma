-- AddForeignKey
ALTER TABLE "UserQuizAttempt" ADD CONSTRAINT "UserQuizAttempt_quize_id_fkey" FOREIGN KEY ("quize_id") REFERENCES "Quize"("quize_id") ON DELETE CASCADE ON UPDATE CASCADE;
