"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = __importDefault(require("express"));
const cors_1 = __importDefault(require("cors"));
const database_1 = require("./config/database");
const restaurantRoutes_1 = __importDefault(require("./routes/restaurantRoutes"));
const cityRoutes_1 = __importDefault(require("./routes/cityRoutes"));
const reservationRoutes_1 = __importDefault(require("./routes/reservationRoutes"));
const app = (0, express_1.default)();
const PORT = process.env.PORT || 5000;
app.use((0, cors_1.default)());
app.get('/test-count', async (req, res) => {
    try {
        const result = await database_1.pool.query('SELECT COUNT(*) FROM restaurants');
        const count = parseInt(result.rows[0].count, 10);
        res.json({ success: true, count });
    }
    catch (error) {
        console.error('Database error:', error);
        res.status(500).json({ success: false, message: 'Błąd serwera' });
    }
});
app.use(express_1.default.json());
app.use('/api/restaurants', restaurantRoutes_1.default);
app.use('/api/cities', cityRoutes_1.default);
app.use('/api/reservations', reservationRoutes_1.default);
app.get('/api/health', (req, res) => {
    res.json({
        success: true,
        message: 'API is running',
        timestamp: new Date().toISOString(),
    });
});
void (async () => {
    try {
        await (0, database_1.initDatabase)();
        console.log('Database initialized');
        app.listen(PORT, () => {
            console.log(`Server listening on port ${PORT}`);
        });
    }
    catch (err) {
        console.error('Failed to initialize database:', err);
        process.exit(1);
    }
})();
//# sourceMappingURL=index.js.map