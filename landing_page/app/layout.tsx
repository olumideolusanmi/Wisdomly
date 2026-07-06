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
  title: "Wisdomly – Wisdom, one quote at a time",
  description: "Wisdomly delivers hand-picked wisdom in bite-sized quotes. Calm, ad-free, and offline-friendly.",
  icons: {
    icon: "/app_logo.svg",
  },
  verification: {
    google: "8ZKSuPzuICo9kM0DDLId-4G7pOhkbcUOBtHoP9G2pbc",
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
