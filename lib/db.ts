import mysql, { RowDataPacket, ResultSetHeader } from "mysql2/promise";

const globalForDb = globalThis as unknown as { mrdPool?: mysql.Pool };
export const db = globalForDb.mrdPool ?? mysql.createPool({
  host: process.env.DB_HOST, port: Number(process.env.DB_PORT || 3306),
  user: process.env.DB_USER, password: process.env.DB_PASSWORD, database: process.env.DB_NAME,
  waitForConnections: true, connectionLimit: 10, maxIdle: 10, idleTimeout: 60000,
  enableKeepAlive: true, charset: "utf8mb4"
});
if (process.env.NODE_ENV !== "production") globalForDb.mrdPool = db;
export async function rows<T extends RowDataPacket = RowDataPacket[]>(sql:string, params:unknown[]=[]):Promise<T>{ const [r]=await db.execute(sql,params); return r as T; }
export async function exec(sql:string, params:unknown[]=[]){ const [r]=await db.execute<ResultSetHeader>(sql,params); return r; }
