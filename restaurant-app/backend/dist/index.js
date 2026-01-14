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
const PORT = 5001;
app.use((0, cors_1.default)({
    origin: 'http://localhost:5173',
    methods: ['GET', 'POST', 'PUT', 'DELETE'],
    allowedHeaders: ['Content-Type', 'Authorization']
}));
app.use(express_1.default.json());
app.use((req, res, next) => {
    console.log(`[DEBUG] ${req.method} ${req.url}`);
    next();
});
app.use('/api/restaurants', restaurantRoutes_1.default);
app.use('/api/cities', cityRoutes_1.default);
app.use('/api/reservations', reservationRoutes_1.default);
app.get('/api/health', (req, res) => {
    res.json({ success: true, message: 'API is running' });
});
const cleanOldReservations = async () => {
    try {
        const query = `
      DELETE FROM public.reservations 
      WHERE (reservation_date::timestamp + reservation_time::interval) < (NOW() - INTERVAL '1 hour')
    `;
        await database_1.pool.query(query);
        console.log('[CLEANUP] Stare rezerwacje zostaly usuniete');
    }
    catch (err) {
        console.error('[CLEANUP ERROR]', err);
    }
};
const startServer = async () => {
    try {
        await (0, database_1.initDatabase)();
        console.log('Database initialized');
        await cleanOldReservations();
        setInterval(cleanOldReservations, 30 * 60 * 1000);
        app.listen(PORT, '127.0.0.1', () => {
            console.log(`Backend listening on http://localhost:${PORT}`);
        });
    }
    catch (err) {
        console.error('Failed to start server:', err);
    }
};
void startServer();
//# sourceMappingURL=index.js.map