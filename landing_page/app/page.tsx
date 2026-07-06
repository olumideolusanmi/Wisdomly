import { Hero } from "@/components/landing/Hero";
import { Features } from "@/components/landing/Features";
import { HowItWorks } from "@/components/landing/HowItWorks";
import { FAQ } from "@/components/landing/FAQ";
import { Footer } from "@/components/landing/Footer";
import Link from "next/link";
import { Sparkles, ArrowRight } from "lucide-react";

export default function Home() {
  return (
    <main className="min-h-screen bg-white dark:bg-zinc-950 selection:bg-brand-100 dark:selection:bg-brand-900 overflow-x-hidden">
      <Hero />

      {/* Trust Indicators */}
      <div className="py-12 border-y border-zinc-100 dark:border-zinc-900 bg-zinc-50/50 dark:bg-zinc-900/10">
        <div className="container mx-auto px-4 text-center">
          <p className="text-[10px] font-bold text-zinc-400 dark:text-zinc-500 mb-8 uppercase tracking-[0.2em]">
            Trust The Focus Of
          </p>
          <div className="flex flex-wrap justify-center gap-8 md:gap-20 opacity-40 grayscale hover:opacity-100 transition-opacity duration-500">
            <span className="text-xl md:text-2xl font-black text-zinc-900 dark:text-white tracking-tighter">DREAMERS</span>
            <span className="text-xl md:text-2xl font-black text-zinc-900 dark:text-white tracking-tighter">ACHIEVERS</span>
            <span className="text-xl md:text-2xl font-black text-zinc-900 dark:text-white tracking-tighter">THINKERS</span>
            <span className="text-xl md:text-2xl font-black text-zinc-900 dark:text-white tracking-tighter">CREATORS</span>
          </div>
        </div>
      </div>

      <Features />
      <HowItWorks />
      <FAQ />

      {/* Bottom CTA */}
      <section className="py-32 bg-ink-950 relative overflow-hidden">
        {/* Background Pattern */}
        <div className="absolute inset-0 opacity-25 bg-[radial-gradient(#f59e0b_1px,transparent_1px)] bg-[size:32px_32px]"></div>
        <div className="absolute inset-0 bg-linear-to-b from-transparent to-ink-950"></div>

        <div className="container mx-auto px-4 md:px-6 text-center relative z-10">
          <h2 className="text-4xl md:text-7xl font-black text-white mb-8 tracking-tight leading-tight">
            Ready for wisdom? <br /><span className="text-brand-400">Open the book.</span>
          </h2>
          <p className="text-xl text-ink-200 mb-12 max-w-2xl mx-auto font-medium">
            Wisdomly is the calm, ad-free way to keep timeless insight close at hand.
          </p>
          <div className="flex flex-col sm:flex-row justify-center gap-6">
            <Link
              href="#start"
              className="inline-flex items-center justify-center px-10 py-5 text-lg font-bold text-ink-950 bg-brand-400 rounded-2xl hover:bg-brand-300 transition-all shadow-2xl hover:scale-105 active:scale-95"
            >
              <Sparkles className="mr-3 fill-current text-ink-950" size={24} />
              Start Reading
            </Link>
          </div>
          <p className="mt-8 text-xs text-ink-300 font-bold tracking-[0.2em] uppercase">
            FREE TO USE • NO ADS
          </p>
        </div>
      </section>

      <Footer />
    </main>
  );
}
