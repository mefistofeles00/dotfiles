-- Local LLM settings, changed in one place.
-- LM Studio server: `lms server start`; `lms ls` prints the model names.
local M = {}

M.base_url = "http://localhost:1235"
M.api_key = "lm-studio" -- LM Studio needs no key; just has to be non-empty

-- Large model for chat / edits
M.chat_model = "qwen/qwen3.8-27b"
-- Fast model for inline completion (sent with thinking disabled, see plugins/ai.lua)
-- Alternative that never thinks: "qwen2.5-vl-7b-instruct"
M.completion_model = "google/gemma-4-12b"

return M
