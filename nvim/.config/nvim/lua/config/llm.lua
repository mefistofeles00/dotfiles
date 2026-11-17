-- Yerel LLM ayarları: tek yerden değişir.
-- LM Studio (Bionic) sunucusu: `lms server start`  → `lms ls` model adlarını verir.
local M = {}

M.base_url = "http://localhost:1235"
M.api_key = "lm-studio" -- LM Studio anahtar istemez, boş olmasın diye

-- Sohbet / düzenleme için büyük model
M.chat_model = "qwen/qwen3.8-27b"
-- Satır içi tamamlama için hızlı model (düşünme modu kapalı gönderilir, bkz. plugins/ai.lua)
-- Alternatif, hiç düşünmeyen model: "qwen2.5-vl-7b-instruct"
M.completion_model = "google/gemma-4-12b"

return M
