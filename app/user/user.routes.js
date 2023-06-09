import express from 'express'
import { checkAuth } from '../middleware/auth.middleware.js'
import { getUserProfile } from './user.controller.js'

const router = express.Router()

router.route('/profile').get(checkAuth, getUserProfile)

export default router
