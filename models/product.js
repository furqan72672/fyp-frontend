const mongoose = require('mongoose')

const productSchema = new mongoose.Schema({
    _id: {
        type: mongoose.Schema.Types.ObjectId
    },
    name: {
        type: String,
        required: true
    },
    barcode: {
        type: String,
        required: true,
    },
    purchase_price: {
        type: Number,
    },
    sale_price: {
        type: Number,
    },
    seige_code: {
        type: String,
    },
    supplier: {
        type: String,
    },
    brand: {
        type: String,
    }
},
    { timestamps: true }
)

module.exports = mongoose.model('Product', productSchema)