import type { Metadata } from "next";
import { Geist, Geist_Mono } from "next/font/google";
import "./globals.css";
import { Navbar } from "@/components/layout/Navbar";

const geistSans = Geist({
  variable: "--font-geist-sans",
  subsets: ["latin"],
});

const geistMono = Geist_Mono({
  variable: "--font-geist-mono",
  subsets: ["latin"],
});

export const metadata: Metadata = {
  title: "Quotely - Daily Motivational Quotes",
  description: "Quotely gives you quick daily inspiration through short motivational quotes. Simple, harmless, and effective.",
  icons: {
    icon: "/app_logo.png",
  },
  verification: {
    google: "bPaHCADNvxARRv3dHBf4u6zyYCDRCB8dgj2k7gRCTVs",
  },
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en" className="scroll-smooth">
      <body
        className={`${geistSans.variable} ${geistMono.variable} antialiased bg-zinc-50 dark:bg-zinc-950`}
      >
        <Navbar />
        {children}
      </body>
    </html>
  );
}
