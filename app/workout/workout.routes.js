import express from 'express'
import { checkAuth } from '../middleware/auth.middleware.js'
import {
	createWorkoutLog,
	getWorkoutLog,
	updateCompleteWorkoutLog
} from './log/workout-log.controller.js'
import {
	createWorkout,
	deleteWorkout,
	getWorkout,
	getWorkouts,
	updateWorkout
} from './workout.controller.js'

const router = express.Router()

router.route('/').post(checkAuth, createWorkout).get(checkAuth, getWorkouts)
router
	.route('/:id')
	.get(checkAuth, getWorkout)
	.put(checkAuth, updateWorkout)
	.delete(checkAuth, deleteWorkout)

router
	.route('/log/:id')
	.post(checkAuth, createWorkoutLog)
	.get(checkAuth, getWorkoutLog)
router.route('/log/complete/:id').put(checkAuth, updateCompleteWorkoutLog)

export default router
