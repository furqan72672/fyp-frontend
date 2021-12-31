module.exports = (req, res) => {
    return res.status(401).json({ error: "Access Denied", reason: "Unauthorized" })
}