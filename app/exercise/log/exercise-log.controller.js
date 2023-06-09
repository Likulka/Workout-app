import asyncHandler from 'express-async-handler'
import { prisma } from '../../prisma.js'
import { addPrevValues } from './add-prev-values.util.js'

// @desc    Create new exercise log
// @route 	POST /api/exercises/log/:exerciseId
// @access  Private
export const createExerciseLog = asyncHandler(async (req, res) => {
	const exerciseId = +req.params.id
	const exercise = await prisma.exercise.findUnique({
		where: {
			id: exerciseId
		}
	})

	if (!exercise) {
		res.status(404)
		throw new Error('Exercise not found!')
	}

	let timesDefault = []

	for (let i = 0; i < exercise.times; i++) {
		timesDefault.push({
			weight: 0,
			repeat: 0
		})
	}

	const exerciseLog = await prisma.exerciseLog.create({
		data: {
			user: {
				connect: {
					id: req.user.id
				}
			},
			exercise: {
				connect: {
					id: exerciseId
				}
			},
			times: {
				createMany: {
					data: timesDefault
				}
			}
		},
		include: {
			times: true
		}
	})

	res.json(exerciseLog)
})

export const getExerciseLog = asyncHandler(async (req, res) => {
	const exerciseLog = await prisma.exerciseLog.findUnique({
		where: {
			id: +req.params.id
		},
		include: {
			exercise: true,
			times: {
				orderBy: {
					id: 'asc'
				}
			}
		}
	})

	if (!exerciseLog) {
		res.status(404)
		throw new Error('Exercise log not found')
	}

	const prevExerciseLog = await prisma.exerciseLog.findFirst({
		where: {
			exerciseId: exerciseLog.exerciseId,
			userId: req.user.id,
			isCompleted: true
		},

		orderBy: {
			createdAt: 'desc'
		},
		include: {
			times: true
		}
	})

	res.json({
		...exerciseLog,
		times: addPrevValues(exerciseLog, prevExerciseLog)
	})
})
