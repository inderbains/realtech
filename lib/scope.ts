import type { SessionUser } from "@/lib/auth";
export function brokerageWhere(u:SessionUser, alias=""){ const p=alias?alias+".":""; return {sql:`${p}brokerage_id = ?`,params:[u.brokerageId]}; }
export function crmWhere(u:SessionUser, alias=""){ const p=alias?alias+".":""; if(u.role==="admin"||u.canViewAllCrm)return brokerageWhere(u,alias); return {sql:`${p}brokerage_id = ? AND (${p}assigned_to = ? OR ${p}created_by = ?)`,params:[u.brokerageId,u.id,u.id]}; }
