const express = require('express')
const router = express.Router()
const auth = require('../middlewares/authenticate')
const ProductController = require('../controllers/products')


router.get('/', ProductController.getAll)

router.get('/:productId', ProductController.getOne)

router.get('/barcode/:barcode', ProductController.getBarcode)

router.post('/', auth, ProductController.createOne)

module.exports = router