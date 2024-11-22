return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")
    local lint_disabled_files = {}

    lint.linters_by_ft = {
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescriptreact = { "eslint_d" },
      svelte = { "eslint_d" },
      python = { "pylint" },
    }

    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        local current_file = vim.fn.expand("%:p")
        if lint_disabled_files[current_file] then
          return
        end
        lint.try_lint()
      end,
    })

    -- Toggle linting for the current file
    vim.keymap.set("n", "<leader>lt", function()
      local current_file = vim.fn.expand("%:p")
      lint_disabled_files[current_file] = not lint_disabled_files[current_file]
      if lint_disabled_files[current_file] then
        print("Linting disabled for " .. current_file)
      else
        print("Linting enabled for " .. current_file)
        lint.try_lint()
      end
    end, { desc = "Toggle linting for current file" })

    vim.keymap.set("n", "<leader>ll", function()
      lint.try_lint()
    end, { desc = "Trigger linting for current file" })
  end,
}
