const mongoose = require('mongoose')

const saleSchema = new mongoose.Schema({
    _id: {
        type: mongoose.Schema.Types.ObjectId
    },
    product: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Product',
        required: true,
    },
    user: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User',
        required: true,
    },
    sales: {
        type: Number,
    },
},
    { timestamps: true }
)

module.exports = mongoose.model('Sale', saleSchema)