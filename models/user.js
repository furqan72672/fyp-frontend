const mongoose = require('mongoose')

const userSchema = new mongoose.Schema({
    _id: mongoose.Schema.Types.ObjectId,
    email: {
        type: String,
        required: true,
        unique: true,
        match: /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
    },
    name: {
        type: String,
        required: true
    },
    password: {
        type: String,
        required: true,
    },
    guard: {
        type: Number,
        required: true,
    },
    shift: {
        from: Number,
        to: Number,
    },
    address: {
        line1: String,
        line2: String,
        city: String,
        state: String,
        country: String,
        zip: Number,
    },
    target: {
        type: Number,
    },
    salary: {
        type: Number,
    },
    phone: {
        type: String,
    },



    //not sure about visa yet
    visa: {
        type: Number,
    },
},
    { timestamps: true }
)

module.exports = mongoose.model('User', userSchema)