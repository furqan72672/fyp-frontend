const mongoose = require('mongoose')

const branchSchema = new mongoose.Schema({
    _id: {
        type: mongoose.Schema.Types.ObjectId
    },
    store_name: {
        type: String,
        required: true
    },
    rent: {
        type: Number,
    },
    user: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User',
        required: true,
    },
    location: {
        lat: {
            type: Number,
        },
        long: {
            type: Number,
        }
    },
},
    { timestamps: true }
)

module.exports = mongoose.model('Branch', branchSchema)