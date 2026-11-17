-- AI layer: CodeCompanion (chat/edits) + minuet (inline completion)
-- Default provider is LM Studio; Claude Code is added over ACP.
local llm = require("config.llm")

return {
  { "folke/which-key.nvim", opts = { spec = { { "<leader>a", group = "ai", icon = "󰚩" } } } },

  {
    "olimorris/codecompanion.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" },
    cmd = { "CodeCompanion", "CodeCompanionChat", "CodeCompanionActions", "CodeCompanionCmd" },
    keys = {
      { "<leader>aa", "<cmd>CodeCompanionChat Toggle<cr>", mode = { "n", "v" }, desc = "Chat (LM Studio)" },
      { "<leader>ai", ":CodeCompanion ", mode = { "n", "v" }, desc = "Inline prompt" },
      { "<leader>ap", "<cmd>CodeCompanionActions<cr>", mode = { "n", "v" }, desc = "Actions" },
      { "<leader>ad", "<cmd>CodeCompanionChat Add<cr>", mode = "v", desc = "Add selection to chat" },
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
          -- Uses the Claude Code login, no API key needed (npx @zed-industries/claude-code-acp)
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
      { "<leader>am", "<cmd>Minuet virtualtext toggle<cr>", desc = "Toggle inline completion" },
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
        -- Alt-l / Alt-[ / Alt-] are zellij's focus keys; avoid clashing with them
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
          -- reasoning_effort = "none" turns off the model's thinking mode in LM Studio;
          -- otherwise the 128-token budget is spent on thinking and the suggestion comes back empty.
          optional = { max_tokens = 128, top_p = 0.9, reasoning_effort = "none" },
        },
      },
    },
  },
}
