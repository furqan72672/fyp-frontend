const mongoose = require('mongoose')

const incentiveSchema = new mongoose.Schema({
    _id: {
        type: mongoose.Schema.Types.ObjectId
    },
    user: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User',
        required: true,
    },
    amount: {
        type: Number,
    }
},
    { timestamps: true }
)

module.exports = mongoose.model('Incentive', incentiveSchema)