const mongoose = require('mongoose')
const Product = require('../models/product')
const User = require('../models/user')
const serverError = require('../utils/internalServerError')
const authError = require('../utils/unauthorizedError')

exports.getAll = (req, res, next) => {
    Product.find().exec().then(docs => {
        if (docs.length > 0) {
            return res.status(200).json(docs)
        }
        return res.status(200).json({ message: "DB is empty" })
    }).catch(err => {
        return res.status(500).json({ error: err.message })
    })
}

exports.getOne = (req, res, next) => {
    Product.find({ _id: req.params.productId }).exec().then(docs => {
        if (docs.length > 0) {
            return res.status(200).json(docs[0])
        }
        return res.status(200).json({ message: "Product not found" })
    }).catch(err => {
        return res.status(500).json({ error: err.message })
    })
}

exports.getBarcode = (req, res, next) => {
    Product.find({ barcode: req.params.barcode }).exec().then(docs => {
        if (docs.length > 0) {
            return res.status(200).json(docs[0])
        }
        else {
            return res.status(200).json({ message: "Product not found" })
        }
    }).catch(err => {
        serverError(err, req, res)
    })
}

exports.createOne = (req, res, next) => {
    User.find({ _id: req.userData.id }).exec().then(docs => {
        if (docs[0].guard == 2) {
            const product = new Product({
                _id: mongoose.Types.ObjectId(),
                name: req.body.name,
                barcode: req.body.barcode,
                purchase_price: req.body.purchase_price,
                sale_price: req.body.sale_price,
                seige_code: req.body.seige_code,
                supplier: req.body.supplier,
                brand: req.body.brand,
            })
            product.save().then(doc => {
                return res.status(201).json(doc)
            }).catch(err => {
                serverError(err, req, res)
            })
        }
        else {
            return res.status(406).json({ message: "Privilege error" })
        }
    }).catch(err => {
        serverError(err, req, res)
    })

}

