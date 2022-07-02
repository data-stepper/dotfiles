-- -------------------- NEORG SETUP --------------------
require("neorg").setup {
  load = {
    ["core.defaults"] = {},
    ["core.integrations.telescope"] = {},
    ["core.norg.dirman"] = {
      config = {
        workspaces = {
          -- main = "~/git/notes/main",
          main = "~/git/notes/gtd"
        }
      }
    },
    ["core.gtd.base"] = {
      config = {
        workspace = "main"
      }
    },
    ["core.norg.concealer"] = {
      config = {
        -- icon_preset = "diamond",
        dim_code_blocks = false
      }
    },
    ["external.kanban"] = {
      config = {
        task_states = {
          "undone",
          "done",
          "pending",
          "cancelled",
          "uncertain",
          "urgent",
          "recurring",
          "on_hold"
        }
      }
    },
    ["core.norg.qol.toc"] = {}
    -- ["core.norg.completion"] = {},
    -- ["core.export"] = {},
    -- ["core.norg.manoeuvre "] = {},
    -- ["core.integrations.nvim-cmp"] = {},
    -- ["core.gtd.ui"] = {},
    -- ["core.highlights"] = {},
    -- ["core.export.markdown"] = {}
  }
}
