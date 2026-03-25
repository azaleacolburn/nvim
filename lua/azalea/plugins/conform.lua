return {
	"stevearc/conform.nvim",
	dependencies = { "mason.nvim" },
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				javascript = { { "biome" } },
				typescript = { { "biome" } },
				typescriptreact = { { "biome" } },
				javascriptreact = { { "biome" } },
				svelte = { { "biome" } },
				html = { { "biome" } },
				css = { { "biome" } },
				json = { { "biome" } },

				markdown = { { "prettierd" } },
				yaml = { { "prettierd" } },
				toml = { { "prettierd" } },
				lua = { "stylua" },
				rust = { "rustfmt" },
				c = { "clang-format" },
				cpp = { "clang-format" },
			},
			format_on_save = {
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			},
		})

		vim.keymap.set({ "n", "v" }, "<leader>l", function()
			conform.format({
				lsp_fallback = true,
				async = true,
			})
		end, { desc = "Format file or range (in visual mode)" })
	end,
}
