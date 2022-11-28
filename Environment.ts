import * as dotenv from 'dotenv';
dotenv.config()

export const getPrivateKey = () => process.env.PRIVATE_KEY;
export const getApiUrl = () => process.env.API_URL;
export const getPolygonScanApiKey = () => process.env.POLYGON_SCAN_API_KEY;