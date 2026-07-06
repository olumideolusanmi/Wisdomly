"use client";

import { useState } from "react";
import { motion } from "framer-motion";
import { Sparkles, ArrowRight, Quote, Share2 } from "lucide-react";

export function Hero() {
  const [isProcessing, setIsProcessing] = useState(false);
  const [quote, setQuote] = useState<null | string>(null);

  const handleInspire = () => {
    setIsProcessing(true);
    setQuote(null);

    setTimeout(() => {
      setQuote("The only true wisdom is in knowing you know nothing. - Socrates");
      setIsProcessing(false);
    }, 1000);
  };

  return (
    <section className="relative pt-32 pb-20 md:pt-40 md:pb-32 overflow-hidden bg-white dark:bg-zinc-950">
      {/* Background decoration */}
      <div className="absolute top-0 left-1/2 -translate-x-1/2 w-full h-full -z-10 overflow-hidden pointer-events-none">
        <div className="absolute top-[-10%] left-[-10%] w-[50%] h-[50%] bg-brand-400/15 blur-[120px] rounded-full mix-blend-multiply dark:mix-blend-normal" />
        <div className="absolute bottom-[10%] right-[-10%] w-[50%] h-[50%] bg-ink-500/20 blur-[120px] rounded-full mix-blend-multiply dark:mix-blend-normal" />
      </div>

      <div className="container mx-auto px-4 md:px-6">
        <div className="text-center max-w-4xl mx-auto mb-16">
          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            className="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-brand-50 dark:bg-brand-950/30 border border-brand-100 dark:border-brand-900/50 mb-6"
          >
            <Sparkles size={14} className="text-brand-600 dark:text-brand-400" />
            <span className="text-xs font-bold text-brand-700 dark:text-brand-300 uppercase tracking-wider">
              Daily Wisdom
            </span>
          </motion.div>

          <motion.h1
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ delay: 0.1 }}
            className="text-5xl md:text-7xl font-black text-ink-900 dark:text-white mb-6 tracking-tight leading-[1.1]"
          >
            Timeless wisdom. <br className="hidden md:block" />
            <span className="text-brand-500">One quote at a time.</span>
          </motion.h1>

          <motion.p
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ delay: 0.2 }}
            className="text-xl text-zinc-600 dark:text-zinc-400 max-w-2xl mx-auto font-medium"
          >
            Wisdomly hands you hand-picked wisdom in short, memorable quotes. No noise, no tracking — just words worth keeping.
          </motion.p>
        </div>

        {/* Interactive Demo Widget */}
        <motion.div
          initial={{ opacity: 0, y: 40 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.3 }}
          id="demo"
          className="max-w-xl mx-auto bg-white dark:bg-ink-900 rounded-3xl border border-ink-100 dark:border-ink-800 shadow-2xl shadow-ink-900/10 overflow-hidden"
        >
          <div className="p-6 md:p-10 flex flex-col items-center text-center min-h-[300px] justify-center">
            
            {quote ? (
              <motion.div
                initial={{ opacity: 0, scale: 0.9 }}
                animate={{ opacity: 1, scale: 1 }}
                className="mb-8"
              >
                <Quote size={40} className="text-brand-500 mx-auto mb-6 opacity-60" />
                <p className="text-2xl md:text-3xl font-bold text-ink-800 dark:text-zinc-100 mb-4 font-serif leading-tight">
                  "{quote.split(' - ')[0]}"
                </p>
                <p className="text-ink-500 dark:text-ink-200 font-medium">— {quote.split(' - ')[1]}</p>
              </motion.div>
            ) : (
              <div className="mb-8 py-10">
                <p className="text-ink-400 text-lg">Tap below for a piece of wisdom…</p>
              </div>
            )}

            <div className="flex gap-4">
              <button
                onClick={handleInspire}
                disabled={isProcessing}
                className="inline-flex items-center justify-center px-8 py-4 text-lg font-bold text-white bg-ink-900 dark:bg-brand-400 dark:text-ink-950 rounded-2xl hover:scale-105 active:scale-95 transition-all disabled:opacity-50 disabled:cursor-not-allowed shadow-xl shadow-ink-900/20"
              >
                {isProcessing ? (
                  <span className="animate-pulse">Finding wisdom…</span>
                ) : (
                  <>
                    <Sparkles size={20} className="mr-2" />
                    Give Me Wisdom
                  </>
                )}
              </button>
              
              {quote && (
                <button className="inline-flex items-center justify-center p-4 text-zinc-600 bg-zinc-100 dark:bg-zinc-800 dark:text-zinc-300 rounded-2xl hover:bg-zinc-200 dark:hover:bg-zinc-700 transition-colors">
                  <Share2 size={24} />
                </button>
              )}
            </div>
          </div>
        </motion.div>
      </div>
    </section>
  );
}
