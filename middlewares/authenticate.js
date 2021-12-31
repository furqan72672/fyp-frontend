const jwt = require('jsonwebtoken')
const authError = require('../utils/unauthorizedError')

module.exports = (req, res, next) => {
    try {
        const token = req.headers.authorization.split(" ")[1]
        const decodedToken = jwt.verify(token, "49486553965335887759405095625744323")
        req.userData = decodedToken
        next()
    }
    catch (err) {
        authError(req, res, next)
    }
}