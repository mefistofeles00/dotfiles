-- AI katmanı: CodeCompanion (sohbet/düzenleme) + minuet (satır içi tamamlama)
-- Varsayılan sağlayıcı LM Studio; Claude Code ACP üzerinden eklenir.
local llm = require("config.llm")

return {
  { "folke/which-key.nvim", opts = { spec = { { "<leader>a", group = "ai", icon = "󰚩" } } } },

  {
    "olimorris/codecompanion.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" },
    cmd = { "CodeCompanion", "CodeCompanionChat", "CodeCompanionActions", "CodeCompanionCmd" },
    keys = {
      { "<leader>aa", "<cmd>CodeCompanionChat Toggle<cr>", mode = { "n", "v" }, desc = "Sohbet (LM Studio)" },
      { "<leader>ai", ":CodeCompanion ", mode = { "n", "v" }, desc = "Satır içi istek" },
      { "<leader>ap", "<cmd>CodeCompanionActions<cr>", mode = { "n", "v" }, desc = "Eylemler" },
      { "<leader>ad", "<cmd>CodeCompanionChat Add<cr>", mode = "v", desc = "Seçimi sohbete ekle" },
    },
    opts = {
      adapters = {
        http = {
          lmstudio = function()
            return require("codecompanion.adapters").extend("openai_compatible", {
              name = "lmstudio",
              formatted_name = "LM Studio",
              env = {
                url = llm.base_url,
                api_key = llm.api_key,
                chat_url = "/v1/chat/completions",
                models_endpoint = "/v1/models",
              },
              schema = { model = { default = llm.chat_model } },
            })
          end,
        },
        acp = {
          -- Claude Code girişini kullanır, API anahtarı gerekmez (npx @zed-industries/claude-code-acp)
          claude_code = function()
            return require("codecompanion.adapters").extend("claude_code", {})
          end,
        },
      },
      strategies = {
        chat = { adapter = "lmstudio" },
        inline = { adapter = "lmstudio" },
        cmd = { adapter = "lmstudio" },
      },
      display = { chat = { window = { width = 0.4 } } },
    },
  },

  {
    "milanglacier/minuet-ai.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = "VeryLazy",
    keys = {
      { "<leader>am", "<cmd>Minuet virtualtext toggle<cr>", desc = "Satır içi tamamlama aç/kapat" },
    },
    opts = {
      provider = "openai_compatible",
      request_timeout = 5,
      throttle = 1500,
      debounce = 500,
      n_completions = 1,
      context_window = 6000,
      notify = "error",
      virtualtext = {
        auto_trigger_ft = { "*" },
        -- Alt-l / Alt-[ / Alt-] zellij'in odak tuşları, onlarla çakışmasın
        keymap = {
          accept = "<A-a>",
          accept_line = "<A-s>",
          accept_n_lines = "<A-z>",
          prev = "<A-,>",
          next = "<A-.>",
          dismiss = "<A-e>",
        },
      },
      provider_options = {
        openai_compatible = {
          api_key = function() return llm.api_key end,
          end_point = llm.base_url .. "/v1/chat/completions",
          model = llm.completion_model,
          name = "LM Studio",
          stream = true,
          -- reasoning_effort = "none": LM Studio'da modelin "düşünme" modunu kapatır,
          -- yoksa 128 token bütçesi sırf düşünmeye gider ve öneri boş gelir.
          optional = { max_tokens = 128, top_p = 0.9, reasoning_effort = "none" },
        },
      },
    },
  },
}
