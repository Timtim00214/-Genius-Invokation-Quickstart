import { defineConfig } from "prisma/config"; // 注意：原来的引用可能是 "prisma/config" 或 "@prisma/config"，请保持原样

// --- 侦查代码开始 ---
console.log("🔍 正在检查环境变量...");
console.log("👉 DATABASE_URL 的值是:", process.env.DATABASE_URL);
if (!process.env.DATABASE_URL) {
    console.error("❌ 致命错误：环境变量未加载！请检查 .env 文件是否存在且无 BOM 头。");
}
// --- 侦查代码结束 ---

export default defineConfig({
  // ... 其他配置保持不变 ...

  datasource: {
    // 核心逻辑：先尝试读环境变量，读不到就用后面这个默认字符串
    // 这里的 || 意思是 "或者"
    url: process.env.DATABASE_URL || "postgresql://postgres:mysecretpassword@localhost:5432/postgres", 
  },
});