const mongoose = require('mongoose')
const User = require('../models/user')
const serverError = require('../utils/internalServerError')
const bcrypt = require('bcrypt')
const authError = require('../utils/unauthorizedError')
const jwt = require('jsonwebtoken')

exports.getAll = (req, res, next) => {
    User.find({ email: req.userData.email }).exec().then(docs => {
        if (docs[0].guard === 2) {
            User.find().exec().then(docs => {
                return res.status(200).json(docs)
            })
        }
        else {
            return res.status(406).json({ error: "Permission Error" })
        }
    }).catch(err => {
        serverError(err, req, res)
    })
}

exports.getProfile = (req, res, next) => {
    User.find({ _id: req.params.userId }).exec().then(docs => {
        if (docs.length >= 1) return res.status(200).json(docs)
        res.status(404).json({ Error: "Profile Not found" })
    })
}

exports.signUp = (req, res, next) => {
    User.find({ email: req.body.email }).exec().then(docs => {
        if (docs.length >= 1) return res.status(406).json({ error: 'Email already exists' })
        else {
            bcrypt.hash(req.body.password, 10, (err, hash) => {
                if (err) return serverError(err, req, res)
                else {
                    const user = new User({
                        _id: mongoose.Types.ObjectId(),
                        name: req.body.name,
                        email: req.body.email,
                        password: hash,
                        guard: req.body.guard,
                        target: req.body.target,
                        salary: req.body.salary,
                        phone: req.body.phone,
                        visa: req.body.visa,
                        address: req.body.address,
                        shift: req.body.shift,
                    })
                    user.save().then(response => {
                        res.status(201).json(response)
                    }).catch(err => {
                        serverError(err, req, res)
                    })
                }
            })
        }
    }).catch(err => {
        serverError(err, req, res)
    })
}

exports.signIn = (req, res, next) => {
    User.find({ email: req.body.email }).exec().then(docs => {
        if (docs.length < 1) return authError(req, res)
        bcrypt.compare(req.body.password, docs[0].password, (err, same) => {
            if (err) return authError(req, res)
            const token = jwt.sign(
                {
                    email: docs[0].email,
                    id: docs[0]._id
                },
                "49486553965335887759405095625744323",
                {
                    expiresIn: "24h"
                }
            )
            return res.status(201).json({ AccessToken: token })
        })
    })
}