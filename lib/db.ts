import mysql, { ResultSetHeader, RowDataPacket } from "mysql2/promise";

const globalForDb = globalThis as unknown as { mrdPool?: mysql.Pool };

export const db =
  globalForDb.mrdPool ??
  mysql.createPool({
    host: process.env.DB_HOST || "localhost",
    port: Number(process.env.DB_PORT || 3306),
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME,
    waitForConnections: true,
    connectionLimit: 10,
    maxIdle: 10,
    idleTimeout: 60_000,
    enableKeepAlive: true,
    charset: "utf8mb4",
  });

if (process.env.NODE_ENV !== "production") {
  globalForDb.mrdPool = db;
}

export async function rows<T extends RowDataPacket[] = RowDataPacket[]>(
  sql: string,
  params: unknown[] = [],
): Promise<T> {
  const [result] = await db.execute<T>(sql, params as any);
  return result;
}

export async function exec(
  sql: string,
  params: unknown[] = [],
): Promise<ResultSetHeader> {
  const [result] = await db.execute<ResultSetHeader>(sql, params as any);
  return result;
}
