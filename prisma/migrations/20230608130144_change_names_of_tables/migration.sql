/*
  Warnings:

  - You are about to drop the column `exercise_log_id` on the `Exercise` table. All the data in the column will be lost.
  - You are about to drop the `ExerciseLog` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `ExerciseTime` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `WorkoutLog` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "Exercise" DROP CONSTRAINT "Exercise_exercise_log_id_fkey";

-- DropForeignKey
ALTER TABLE "ExerciseLog" DROP CONSTRAINT "ExerciseLog_user_id_fkey";

-- DropForeignKey
ALTER TABLE "ExerciseLog" DROP CONSTRAINT "ExerciseLog_workout_log_id_fkey";

-- DropForeignKey
ALTER TABLE "ExerciseTime" DROP CONSTRAINT "ExerciseTime_exercise_log_id_fkey";

-- DropForeignKey
ALTER TABLE "WorkoutLog" DROP CONSTRAINT "WorkoutLog_user_id_fkey";

-- DropForeignKey
ALTER TABLE "WorkoutLog" DROP CONSTRAINT "WorkoutLog_workout_id_fkey";

-- AlterTable
ALTER TABLE "Exercise" DROP COLUMN "exercise_log_id";

-- DropTable
DROP TABLE "ExerciseLog";

-- DropTable
DROP TABLE "ExerciseTime";

-- DropTable
DROP TABLE "WorkoutLog";

-- CreateTable
CREATE TABLE "Exercise_log" (
    "id" SERIAL NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "is_completed" BOOLEAN NOT NULL DEFAULT false,
    "user_id" INTEGER,
    "workout_log_id" INTEGER,
    "exercise_id" INTEGER,

    CONSTRAINT "Exercise_log_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Exercise_time" (
    "id" SERIAL NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "is_completed" BOOLEAN NOT NULL DEFAULT false,
    "repeat" INTEGER NOT NULL DEFAULT 0,
    "weight" INTEGER NOT NULL DEFAULT 0,
    "exercise_log_id" INTEGER,

    CONSTRAINT "Exercise_time_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Workout_log" (
    "id" SERIAL NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "is_completed" BOOLEAN NOT NULL DEFAULT false,
    "user_id" INTEGER,
    "workout_id" INTEGER,

    CONSTRAINT "Workout_log_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "Exercise_log" ADD CONSTRAINT "Exercise_log_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Exercise_log" ADD CONSTRAINT "Exercise_log_workout_log_id_fkey" FOREIGN KEY ("workout_log_id") REFERENCES "Workout_log"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Exercise_log" ADD CONSTRAINT "Exercise_log_exercise_id_fkey" FOREIGN KEY ("exercise_id") REFERENCES "Exercise"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Exercise_time" ADD CONSTRAINT "Exercise_time_exercise_log_id_fkey" FOREIGN KEY ("exercise_log_id") REFERENCES "Exercise_log"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Workout_log" ADD CONSTRAINT "Workout_log_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Workout_log" ADD CONSTRAINT "Workout_log_workout_id_fkey" FOREIGN KEY ("workout_id") REFERENCES "Workout"("id") ON DELETE SET NULL ON UPDATE CASCADE;
