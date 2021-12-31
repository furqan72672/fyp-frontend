module.exports = (err, req, res) => {
    return res.status(500).json({ error: err.message })
}