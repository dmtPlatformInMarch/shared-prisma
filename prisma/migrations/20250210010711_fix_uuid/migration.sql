-- CreateEnum
CREATE TYPE "Role" AS ENUM ('ADMIN', 'USER', 'ROOT_ADMIN');

-- CreateEnum
CREATE TYPE "Visibility" AS ENUM ('PUBLIC', 'PRIVATE', 'PARTIALLY_PUBLIC');

-- CreateTable
CREATE TABLE "Admin" (
    "id" TEXT NOT NULL,
    "role" "Role" NOT NULL DEFAULT 'USER',
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "createdAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Admin_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Users" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "role" "Role" NOT NULL DEFAULT 'USER',
    "email" TEXT NOT NULL,
    "createdAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

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
    "category" TEXT NOT NULL,
    "curriculum_likes" TEXT[] DEFAULT ARRAY[]::TEXT[],
    "curriculum_views" TEXT[] DEFAULT ARRAY[]::TEXT[],
    "curriculum_subscribers" TEXT[] DEFAULT ARRAY[]::TEXT[],
    "currriculum_rating" DOUBLE PRECISION[] DEFAULT ARRAY[]::DOUBLE PRECISION[],
    "curriculum_visibility" "Visibility" NOT NULL DEFAULT 'PRIVATE',
    "curriculum_updatedAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "curriculum_createdAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "curriculum_course_number" INTEGER NOT NULL,
    "owner_id" TEXT NOT NULL,
    "curriculum_markdown" TEXT DEFAULT '',

    CONSTRAINT "Curriculum_pkey" PRIMARY KEY ("curriculum_id")
);

-- CreateTable
CREATE TABLE "Section" (
    "section_id" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "curriculumId" TEXT NOT NULL,

    CONSTRAINT "Section_pkey" PRIMARY KEY ("section_id")
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
    "lesson_updatedAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "lesson_createdAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "lesson_views" INTEGER NOT NULL,
    "lesson_comments" INTEGER NOT NULL,
    "videoId" TEXT,
    "owner_id" TEXT NOT NULL,

    CONSTRAINT "Lesson_pkey" PRIMARY KEY ("lesson_id")
);

-- CreateTable
CREATE TABLE "LessonCurriculum" (
    "main_id" TEXT NOT NULL,
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "lesson_id" TEXT,

    CONSTRAINT "LessonCurriculum_pkey" PRIMARY KEY ("main_id")
);

-- CreateTable
CREATE TABLE "WatchedVideo" (
    "id" TEXT NOT NULL,
    "enrollment_id" TEXT NOT NULL,
    "course_video_id" TEXT NOT NULL,
    "watchedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "WatchedVideo_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Enrollment" (
    "id" TEXT NOT NULL,
    "user_id" TEXT NOT NULL,
    "course_id" TEXT NOT NULL,
    "course_progress" INTEGER NOT NULL,
    "enrolledAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Enrollment_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "_CurriculumLessons" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL,

    CONSTRAINT "_CurriculumLessons_AB_pkey" PRIMARY KEY ("A","B")
);

-- CreateTable
CREATE TABLE "_SectionVideos" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL,

    CONSTRAINT "_SectionVideos_AB_pkey" PRIMARY KEY ("A","B")
);

-- CreateIndex
CREATE UNIQUE INDEX "Lesson_videoId_key" ON "Lesson"("videoId");

-- CreateIndex
CREATE UNIQUE INDEX "WatchedVideo_enrollment_id_course_video_id_key" ON "WatchedVideo"("enrollment_id", "course_video_id");

-- CreateIndex
CREATE INDEX "_CurriculumLessons_B_index" ON "_CurriculumLessons"("B");

-- CreateIndex
CREATE INDEX "_SectionVideos_B_index" ON "_SectionVideos"("B");

-- AddForeignKey
ALTER TABLE "Curriculum" ADD CONSTRAINT "Curriculum_owner_id_fkey" FOREIGN KEY ("owner_id") REFERENCES "Admin"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Section" ADD CONSTRAINT "Section_curriculumId_fkey" FOREIGN KEY ("curriculumId") REFERENCES "Curriculum"("curriculum_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Lesson" ADD CONSTRAINT "Lesson_owner_id_fkey" FOREIGN KEY ("owner_id") REFERENCES "Admin"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LessonCurriculum" ADD CONSTRAINT "LessonCurriculum_lesson_id_fkey" FOREIGN KEY ("lesson_id") REFERENCES "Lesson"("lesson_id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "WatchedVideo" ADD CONSTRAINT "WatchedVideo_enrollment_id_fkey" FOREIGN KEY ("enrollment_id") REFERENCES "Enrollment"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "WatchedVideo" ADD CONSTRAINT "WatchedVideo_course_video_id_fkey" FOREIGN KEY ("course_video_id") REFERENCES "Lesson"("lesson_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Enrollment" ADD CONSTRAINT "Enrollment_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "Users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Enrollment" ADD CONSTRAINT "Enrollment_course_id_fkey" FOREIGN KEY ("course_id") REFERENCES "Curriculum"("curriculum_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_CurriculumLessons" ADD CONSTRAINT "_CurriculumLessons_A_fkey" FOREIGN KEY ("A") REFERENCES "Curriculum"("curriculum_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_CurriculumLessons" ADD CONSTRAINT "_CurriculumLessons_B_fkey" FOREIGN KEY ("B") REFERENCES "Lesson"("lesson_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_SectionVideos" ADD CONSTRAINT "_SectionVideos_A_fkey" FOREIGN KEY ("A") REFERENCES "Lesson"("lesson_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_SectionVideos" ADD CONSTRAINT "_SectionVideos_B_fkey" FOREIGN KEY ("B") REFERENCES "Section"("section_id") ON DELETE CASCADE ON UPDATE CASCADE;
