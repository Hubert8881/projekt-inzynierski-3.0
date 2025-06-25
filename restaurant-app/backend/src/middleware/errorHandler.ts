import { Request, Response, NextFunction } from 'express';

export const errorHandler = (
  error: Error,
  req: Request,
  res: Response,
  next: NextFunction
): void => {
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