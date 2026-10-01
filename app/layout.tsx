import "./globals.css"; import type { Metadata } from "next";
export const metadata:Metadata={title:"MyRealDesk",description:"Real estate brokerage CRM, back office and e-sign platform"};
export default function RootLayout({children}:{children:React.ReactNode}){return <html lang="en"><body>{children}</body></html>}
