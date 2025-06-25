"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.errorHandler = void 0;
const errorHandler = (error, req, res, next) => {
    console.error('Error:', error.message);
    let statusCode = 500;
    let message = 'Internal Server Error';
    if (error.message.includes('connect ECONNREFUSED')) {
        statusCode = 503;
        message = 'Database connection failed';
    }
    if (error.message.includes('Validation failed')) {
        statusCode = 400;
        message = error.message;
    }
    res.status(statusCode).json({ error: message });
};
exports.errorHandler = errorHandler;
//# sourceMappingURL=errorHandler.js.map