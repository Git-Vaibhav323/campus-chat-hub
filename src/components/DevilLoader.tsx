import React from "react";
import { motion } from "framer-motion";

const DevilLoader = () => {
  return (
    <div className="fixed inset-0 flex items-center justify-center w-screen h-screen bg-black z-50">
      <motion.div
        className="relative"
        animate={{
          opacity: [0.5, 1, 0.5],
          scale: [0.95, 1.05, 0.95],
        }}
        transition={{
          repeat: Infinity,
          duration: 2,
          ease: "easeInOut",
        }}
      >
        <img
          src="/favicon.jpg"
          alt="Loading"
          className="w-48 h-48 rounded-full object-cover"
          style={{
            filter: "drop-shadow(0 0 20px rgba(220, 38, 38, 0.8)) drop-shadow(0 0 40px rgba(220, 38, 38, 0.5))",
          }}
        />
      </motion.div>
    </div>
  );
};

export default DevilLoader;

