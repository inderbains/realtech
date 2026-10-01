import { cookies } from "next/headers";
import { SignJWT, jwtVerify } from "jose";
import bcrypt from "bcryptjs";
import { rows } from "@/lib/db";

const key = () => new TextEncoder().encode(process.env.AUTH_SECRET || "dev-only-change-me");
export type SessionUser={id:number;username:string;email:string|null;role:"admin"|"agent";brokerageId:number;canViewAllCrm:boolean;receivesLeads:boolean;isTeamLead:boolean};
export async function signSession(u:SessionUser){return new SignJWT(u as any).setProtectedHeader({alg:"HS256"}).setIssuedAt().setExpirationTime("7d").sign(key());}
export async function session():Promise<SessionUser|null>{try{const c=(await cookies()).get("mrd_session")?.value;if(!c)return null;const {payload}=await jwtVerify(c,key());return payload as unknown as SessionUser;}catch{return null;}}
export async function requireUser(){const u=await session();if(!u)throw new Error("UNAUTHENTICATED");return u;}
export async function authenticate(login:string,password:string){
 const r:any[]=await rows("SELECT id,username,email,password,role,brokerage_id,can_view_all_crm,receives_leads,is_team_lead,status FROM users WHERE (username=? OR email=?) LIMIT 1",[login,login]);
 const u=r[0]; if(!u || u.status!=="active") return null; const hash=String(u.password||"").replace(/^\$2y\$/,"$2b$"); if(!await bcrypt.compare(password,hash))return null;
 return {id:u.id,username:u.username,email:u.email,role:u.role,brokerageId:u.brokerage_id||1,canViewAllCrm:!!u.can_view_all_crm,receivesLeads:!!u.receives_leads,isTeamLead:!!u.is_team_lead} as SessionUser;
}
