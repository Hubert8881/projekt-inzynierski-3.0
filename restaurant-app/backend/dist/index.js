"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.authenticateToken = void 0;
const express_1 = __importDefault(require("express"));
const cors_1 = __importDefault(require("cors"));
const jsonwebtoken_1 = __importDefault(require("jsonwebtoken"));
const helmet_1 = __importDefault(require("helmet"));
const dotenv_1 = __importDefault(require("dotenv"));
const database_1 = require("./config/database");
const restaurantRoutes_1 = __importDefault(require("./routes/restaurantRoutes"));
const cityRoutes_1 = __importDefault(require("./routes/cityRoutes"));
const reservationRoutes_1 = __importDefault(require("./routes/reservationRoutes"));
const menuRoutes_1 = __importDefault(require("./routes/menuRoutes"));
dotenv_1.default.config();
const app = (0, express_1.default)();
const PORT = 5001;
const JWT_SECRET = process.env.JWT_SECRET || 'fallback_secret_key_123';
const ADMIN_PASSWORD = process.env.ADMIN_PASSWORD || 'admin123';
app.use((0, helmet_1.default)());
app.use((0, cors_1.default)({
    origin: 'http://localhost:5173',
    methods: ['GET', 'POST', 'PUT', 'DELETE'],
    allowedHeaders: ['Content-Type', 'Authorization']
}));
app.use(express_1.default.json());
app.use('/uploads', express_1.default.static('public/uploads'));
const authenticateToken = (req, res, next) => {
    const authHeader = req.headers['authorization'];
    const token = authHeader && authHeader.split(' ')[1];
    if (!token)
        return res.status(401).json({ success: false, message: 'Access Denied' });
    jsonwebtoken_1.default.verify(token, JWT_SECRET, (err, user) => {
        if (err)
            return res.status(403).json({ success: false, message: 'Invalid Token' });
        req.user = user;
        next();
    });
};
exports.authenticateToken = authenticateToken;
app.post('/api/login', (req, res) => {
    const { password } = req.body;
    if (password === ADMIN_PASSWORD) {
        const token = jsonwebtoken_1.default.sign({ role: 'admin' }, JWT_SECRET, { expiresIn: '2h' });
        res.json({ success: true, token });
    }
    else {
        res.status(401).json({ success: false, message: 'Błędne hasło administratora' });
    }
});
app.use('/api/restaurants', restaurantRoutes_1.default);
app.use('/api/cities', cityRoutes_1.default);
app.use('/api/reservations', reservationRoutes_1.default);
app.use('/api/menu', menuRoutes_1.default);
app.get('/api/health', (req, res) => {
    res.json({ success: true, message: 'API is running' });
});
const startServer = async () => {
    try {
        await (0, database_1.initDatabase)();
        app.listen(PORT, '0.0.0.0', () => {
            console.log(`Backend listening on http://localhost:${PORT}`);
        });
    }
    catch (err) {
        console.error('Failed to start server:', err);
    }
};
void startServer();
//# sourceMappingURL=index.js.map