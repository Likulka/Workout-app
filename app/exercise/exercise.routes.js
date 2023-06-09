import express from 'express'
import { checkAuth } from '../middleware/auth.middleware.js'
import {
	createExercise,
	deleteExercise,
	getExercises,
	updateExercise
} from './exercise.controller.js'
import {
	createExerciseLog,
	getExerciseLog
} from './log/exercise-log.controller.js'
import {
	updateCompletedExerciseLog,
	updateExerciseLogTime
} from './log/update-exercise-log.controller.js'

const router = express.Router()

router.route('/').post(checkAuth, createExercise).get(checkAuth, getExercises)
router
	.route('/:id')
	.put(checkAuth, updateExercise)
	.delete(checkAuth, deleteExercise)

router
	.route('/log/:id')
	.post(checkAuth, createExerciseLog)
	.get(checkAuth, getExerciseLog)

router.route('/log/time/:id').put(checkAuth, updateExerciseLogTime)

router.route('/log/complete/:id').patch(checkAuth, updateCompletedExerciseLog)

export default router
