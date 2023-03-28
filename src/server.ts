import express, { Request, Response } from 'express';
import bodyParser from 'body-parser';
import cors from 'cors';
import morgan from 'morgan';
import winston from 'winston';

const app = express();
const port = process.env.PORT || 8000;

// Middleware
app.use(bodyParser.json());
app.use(cors());
app.use(morgan('tiny'));

// Routes
app.get('/', (req: Request, res: Response) => {
    res.send('Hello World!');
});

// Logger
const logger = winston.createLogger({
    level: 'info',
    format: winston.format.json(),
    transports: [
        new winston.transports.Console({ format: winston.format.simple() }),
    ],
});

// Start the server
app.listen(port, () => {
    logger.info(`Server running at http://localhost:${port}`);
});
