-- CreateEnum
CREATE TYPE "Role" AS ENUM ('ADMIN', 'USER', 'ROOT_ADMIN');

-- CreateEnum
CREATE TYPE "Visibility" AS ENUM ('PUBLIC', 'PRIVATE', 'PARTIALLY_PUBLIC');

-- CreateEnum
CREATE TYPE "curriculum_level" AS ENUM ('BEGINNER', 'INTERMEDIATE', 'ADVANCED');

-- CreateEnum
CREATE TYPE "SubtitleStatus" AS ENUM ('WAITING', 'IN_PROGRESS', 'PUBLISHED', 'CANCELED');

-- CreateEnum
CREATE TYPE "Status" AS ENUM ('PENDING', 'APPROVED', 'REJECTED');

-- CreateEnum
CREATE TYPE "PriceType" AS ENUM ('FREE', 'PAID');

-- CreateEnum
CREATE TYPE "ContentType" AS ENUM ('VIDEO', 'TEXT');

-- CreateEnum
CREATE TYPE "CourseType" AS ENUM ('PUBLIC', 'PRIVATE');

-- CreateTable
CREATE TABLE "Admin" (
    "id" TEXT NOT NULL,
    "role" "Role" NOT NULL DEFAULT 'USER',
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "created_at" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Admin_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Users" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "role" "Role" NOT NULL DEFAULT 'USER',
    "email" TEXT NOT NULL,
    "created_at" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Users_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Curriculum" (
    "curriculum_id" TEXT NOT NULL,
    "curriculum_name" TEXT NOT NULL,
    "curriculum_description" TEXT NOT NULL,
    "curriculum_duration" TEXT NOT NULL,
    "curriculum_tags" TEXT[],
    "curriculum_order" TEXT NOT NULL,
    "curriculum_requirements" TEXT[],
    "curriculum_learning" TEXT[],
    "curriculum_level" "curriculum_level" NOT NULL DEFAULT 'BEGINNER',
    "category" TEXT NOT NULL,
    "curriculum_visibility" "Visibility" NOT NULL DEFAULT 'PRIVATE',
    "curriculum_updated_at" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "curriculum_created_at" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "curriculum_course_number" INTEGER NOT NULL,
    "owner_id" TEXT NOT NULL,
    "curriculum_markdown" TEXT DEFAULT '',
    "average_views" INTEGER NOT NULL DEFAULT 0,
    "average_likes" INTEGER NOT NULL DEFAULT 0,
    "average_rating" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "status" "Status" NOT NULL DEFAULT 'PENDING',
    "curriculum_price" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "curriculum_discount" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "curriculum_price_type" "PriceType" NOT NULL DEFAULT 'FREE',
    "currency" TEXT NOT NULL DEFAULT 'KRW',
    "is_paid" BOOLEAN NOT NULL DEFAULT false,
    "curriculum_password" TEXT,
    "private_link" TEXT,
    "is_allowed" BOOLEAN NOT NULL DEFAULT false,
    "website_discount" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "Curriculum_pkey" PRIMARY KEY ("curriculum_id")
);

-- CreateTable
CREATE TABLE "Section" (
    "section_id" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "curriculum_id" TEXT NOT NULL,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Section_pkey" PRIMARY KEY ("section_id")
);

-- CreateTable
CREATE TABLE "Content" (
    "content_id" TEXT NOT NULL,
    "content_type" "ContentType" NOT NULL,
    "lesson_id" TEXT,
    "text_id" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "section_id" TEXT NOT NULL,

    CONSTRAINT "Content_pkey" PRIMARY KEY ("content_id")
);

-- CreateTable
CREATE TABLE "TextContent" (
    "text_id" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "TextContent_pkey" PRIMARY KEY ("text_id")
);

-- CreateTable
CREATE TABLE "Quize" (
    "quize_id" TEXT NOT NULL,
    "quize_title" TEXT NOT NULL,
    "quize_owner" TEXT NOT NULL,
    "section_id" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Quize_pkey" PRIMARY KEY ("quize_id")
);

-- CreateTable
CREATE TABLE "QuizQuestion" (
    "question_id" TEXT NOT NULL,
    "question" TEXT NOT NULL,
    "quize_id" TEXT NOT NULL,
    "correct_option_id" TEXT NOT NULL,

    CONSTRAINT "QuizQuestion_pkey" PRIMARY KEY ("question_id")
);

-- CreateTable
CREATE TABLE "QuizOption" (
    "option_id" TEXT NOT NULL,
    "text" TEXT NOT NULL,
    "question_id" TEXT NOT NULL,

    CONSTRAINT "QuizOption_pkey" PRIMARY KEY ("option_id")
);

-- CreateTable
CREATE TABLE "UserQuizAttempt" (
    "attempt_id" TEXT NOT NULL,
    "user_id" TEXT NOT NULL,
    "quize_id" TEXT NOT NULL,
    "score" INTEGER NOT NULL,
    "completed_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "UserQuizAttempt_pkey" PRIMARY KEY ("attempt_id")
);

-- CreateTable
CREATE TABLE "Lesson" (
    "lesson_id" TEXT NOT NULL,
    "lesson_name" TEXT NOT NULL,
    "lesson_description" TEXT NOT NULL,
    "lesson_video" TEXT NOT NULL,
    "lesson_duration" TEXT NOT NULL,
    "lesson_thumbnail" TEXT NOT NULL,
    "lesson_visibility" "Visibility" NOT NULL DEFAULT 'PRIVATE',
    "lesson_language" TEXT NOT NULL,
    "lesson_updated_at" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "lesson_created_at" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "videoId" TEXT,
    "owner_id" TEXT NOT NULL,

    CONSTRAINT "Lesson_pkey" PRIMARY KEY ("lesson_id")
);

-- CreateTable
CREATE TABLE "Invite" (
    "id" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "user_id" TEXT,
    "course_id" TEXT NOT NULL,
    "is_accepted" BOOLEAN NOT NULL DEFAULT false,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Invite_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CurriculumViews" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "curriculum_id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "CurriculumViews_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CurriculumLikes" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "curriculum_id" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "CurriculumLikes_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CurriculumRating" (
    "id" TEXT NOT NULL,
    "score" INTEGER NOT NULL,
    "review" TEXT,
    "user_id" TEXT NOT NULL,
    "curriculum_id" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "CurriculumRating_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CourseRelatedQuestions" (
    "id" TEXT NOT NULL,
    "question_title" TEXT NOT NULL,
    "body" TEXT,
    "course_id" TEXT NOT NULL,
    "owner_id" TEXT NOT NULL,
    "is_report" BOOLEAN NOT NULL DEFAULT false,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "CourseRelatedQuestions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "QuestionReport" (
    "id" TEXT NOT NULL,
    "question_id" TEXT NOT NULL,
    "reason" TEXT NOT NULL,
    "owner_id" TEXT NOT NULL,
    "is_report" BOOLEAN NOT NULL DEFAULT true,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "QuestionReport_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Comment" (
    "comment_id" TEXT NOT NULL,
    "comment_body" TEXT NOT NULL,
    "comment_likes" TEXT[],
    "comment_owner" TEXT NOT NULL,
    "question_id" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Comment_pkey" PRIMARY KEY ("comment_id")
);

-- CreateTable
CREATE TABLE "Likes" (
    "id" TEXT NOT NULL,
    "like_owner" TEXT NOT NULL,
    "question_id" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Likes_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Subtitle" (
    "id" SERIAL NOT NULL,
    "video_id" TEXT NOT NULL,
    "language" TEXT NOT NULL,
    "file_url" TEXT,
    "status" "SubtitleStatus" NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Subtitle_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "WatchedVideo" (
    "id" TEXT NOT NULL,
    "enrollment_id" TEXT NOT NULL,
    "content_id" TEXT NOT NULL,
    "isCompleted" BOOLEAN NOT NULL DEFAULT false,
    "percentage" INTEGER NOT NULL DEFAULT 0,
    "watched_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "section_idx" INTEGER NOT NULL DEFAULT 0,

    CONSTRAINT "WatchedVideo_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Enrollment" (
    "id" TEXT NOT NULL,
    "user_id" TEXT NOT NULL,
    "course_id" TEXT NOT NULL,
    "course_progress" INTEGER NOT NULL,
    "enrolled_at" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "is_rating" BOOLEAN NOT NULL DEFAULT false,
    "course_type" "CourseType" NOT NULL DEFAULT 'PUBLIC',

    CONSTRAINT "Enrollment_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Curriculum_private_link_key" ON "Curriculum"("private_link");

-- CreateIndex
CREATE UNIQUE INDEX "Content_text_id_key" ON "Content"("text_id");

-- CreateIndex
CREATE UNIQUE INDEX "Quize_section_id_key" ON "Quize"("section_id");

-- CreateIndex
CREATE UNIQUE INDEX "Lesson_videoId_key" ON "Lesson"("videoId");

-- CreateIndex
CREATE UNIQUE INDEX "Invite_email_course_id_id_key" ON "Invite"("email", "course_id", "id");

-- CreateIndex
CREATE UNIQUE INDEX "CurriculumViews_userId_curriculum_id_key" ON "CurriculumViews"("userId", "curriculum_id");

-- CreateIndex
CREATE UNIQUE INDEX "CurriculumLikes_userId_curriculum_id_key" ON "CurriculumLikes"("userId", "curriculum_id");

-- CreateIndex
CREATE UNIQUE INDEX "CurriculumRating_user_id_curriculum_id_key" ON "CurriculumRating"("user_id", "curriculum_id");

-- CreateIndex
CREATE UNIQUE INDEX "QuestionReport_owner_id_question_id_key" ON "QuestionReport"("owner_id", "question_id");

-- CreateIndex
CREATE UNIQUE INDEX "Likes_like_owner_question_id_key" ON "Likes"("like_owner", "question_id");

-- CreateIndex
CREATE UNIQUE INDEX "WatchedVideo_enrollment_id_content_id_key" ON "WatchedVideo"("enrollment_id", "content_id");

-- CreateIndex
CREATE UNIQUE INDEX "Enrollment_user_id_course_id_key" ON "Enrollment"("user_id", "course_id");

-- AddForeignKey
ALTER TABLE "Curriculum" ADD CONSTRAINT "Curriculum_owner_id_fkey" FOREIGN KEY ("owner_id") REFERENCES "Admin"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Section" ADD CONSTRAINT "Section_curriculum_id_fkey" FOREIGN KEY ("curriculum_id") REFERENCES "Curriculum"("curriculum_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Content" ADD CONSTRAINT "Content_lesson_id_fkey" FOREIGN KEY ("lesson_id") REFERENCES "Lesson"("lesson_id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Content" ADD CONSTRAINT "Content_text_id_fkey" FOREIGN KEY ("text_id") REFERENCES "TextContent"("text_id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Content" ADD CONSTRAINT "Content_section_id_fkey" FOREIGN KEY ("section_id") REFERENCES "Section"("section_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Quize" ADD CONSTRAINT "Quize_section_id_fkey" FOREIGN KEY ("section_id") REFERENCES "Section"("section_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "QuizQuestion" ADD CONSTRAINT "QuizQuestion_quize_id_fkey" FOREIGN KEY ("quize_id") REFERENCES "Quize"("quize_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "QuizOption" ADD CONSTRAINT "QuizOption_question_id_fkey" FOREIGN KEY ("question_id") REFERENCES "QuizQuestion"("question_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Lesson" ADD CONSTRAINT "Lesson_owner_id_fkey" FOREIGN KEY ("owner_id") REFERENCES "Admin"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Invite" ADD CONSTRAINT "Invite_course_id_fkey" FOREIGN KEY ("course_id") REFERENCES "Curriculum"("curriculum_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CurriculumViews" ADD CONSTRAINT "CurriculumViews_curriculum_id_fkey" FOREIGN KEY ("curriculum_id") REFERENCES "Curriculum"("curriculum_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CurriculumLikes" ADD CONSTRAINT "CurriculumLikes_curriculum_id_fkey" FOREIGN KEY ("curriculum_id") REFERENCES "Curriculum"("curriculum_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CurriculumRating" ADD CONSTRAINT "CurriculumRating_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "Users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CurriculumRating" ADD CONSTRAINT "CurriculumRating_curriculum_id_fkey" FOREIGN KEY ("curriculum_id") REFERENCES "Curriculum"("curriculum_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CourseRelatedQuestions" ADD CONSTRAINT "CourseRelatedQuestions_course_id_fkey" FOREIGN KEY ("course_id") REFERENCES "Curriculum"("curriculum_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CourseRelatedQuestions" ADD CONSTRAINT "CourseRelatedQuestions_owner_id_fkey" FOREIGN KEY ("owner_id") REFERENCES "Users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "QuestionReport" ADD CONSTRAINT "QuestionReport_question_id_fkey" FOREIGN KEY ("question_id") REFERENCES "CourseRelatedQuestions"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Comment" ADD CONSTRAINT "Comment_question_id_fkey" FOREIGN KEY ("question_id") REFERENCES "CourseRelatedQuestions"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Likes" ADD CONSTRAINT "Likes_question_id_fkey" FOREIGN KEY ("question_id") REFERENCES "CourseRelatedQuestions"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Subtitle" ADD CONSTRAINT "Subtitle_video_id_fkey" FOREIGN KEY ("video_id") REFERENCES "Lesson"("lesson_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "WatchedVideo" ADD CONSTRAINT "WatchedVideo_content_id_fkey" FOREIGN KEY ("content_id") REFERENCES "Content"("content_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "WatchedVideo" ADD CONSTRAINT "WatchedVideo_enrollment_id_fkey" FOREIGN KEY ("enrollment_id") REFERENCES "Enrollment"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Enrollment" ADD CONSTRAINT "Enrollment_course_id_fkey" FOREIGN KEY ("course_id") REFERENCES "Curriculum"("curriculum_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Enrollment" ADD CONSTRAINT "Enrollment_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "Users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
