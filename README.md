#  📦 tiny-inline-diagnostic.nvim

A Neovim plugin that display prettier diagnostic messages. Display one line diagnostic messages where the cursor is, with icons and colors.

## 🖼️ Images

### Multilines enabled

![tinyinline_demo_1](https://github.com/user-attachments/assets/98361b64-4554-4da0-aeb4-3e45dfc6daf6)


### Overflow handling enabled

![tinyinline_demo_2](https://github.com/user-attachments/assets/8571ab15-99b4-4e85-ad7c-89e3b29ad3f1)


### Break line enabled

![image](https://github.com/user-attachments/assets/9492055c-396d-41e4-946a-5ce7f24ebb83)



## 🛠️ Setup

- You need to set `vim.diagnostic.config({ virtual_text = false })`, to not have all diagnostics in the buffer displayed.

## 📥 Installation

> [!NOTE]
> Only works with Neovim >= 0.10

With Lazy.nvim:

```lua
{
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy", -- Or `LspAttach`
    config = function()
        require('tiny-inline-diagnostic').setup()
    end
}
```

## ⚙️ Options

```lua
-- Default configuration
require("tiny-inline-diagnostic").setup({
	signs = {
		left = "",
		right = "",
		diag = "●",
		arrow = "    ",
		up_arrow = "    ",
		vertical = " │",
		vertical_end = " └",
	},
	hi = {
		error = "DiagnosticError",
		warn = "DiagnosticWarn",
		info = "DiagnosticInfo",
		hint = "DiagnosticHint",
		arrow = "NonText",
		background = "CursorLine", -- Can be a highlight or a hexadecimal color (#RRGGBB)
		mixing_color = "None", -- Can be None or a hexadecimal color (#RRGGBB). Used to blend the background color with the diagnostic background color with another color.
	},
	blend = {
		factor = 0.27,
	},
	options = {
		-- Show the source of the diagnostic.
		show_source = false,

		-- Throttle the update of the diagnostic when moving cursor, in milliseconds.
		-- You can increase it if you have performance issues.
		-- Or set it to 0 to have better visuals.
		throttle = 20,

		-- The minimum length of the message, otherwise it will be on a new line.
		softwrap = 15,

		-- If multiple diagnostics are under the cursor, display all of them.
		multiple_diag_under_cursor = false,

		-- Enable diagnostic message on all lines.
		multilines = false,

		-- Show all diagnostics on the cursor line.
		show_all_diags_on_cursorline = false,

    	-- Enable diagnostics on Insert mode. You should also se the `throttle` option to 0, as some artefacts may appear.
		enable_on_insert = false,

		overflow = {
			-- Manage the overflow of the message.
			--    - wrap: when the message is too long, it is then displayed on multiple lines.
			--    - none: the message will not be truncated.
			--    - oneline: message will be displayed entirely on one line.
			mode = "wrap",
		},

		-- Format the diagnostic message.
		-- Example:
		-- format = function(diagnostic)
		--     return diagnostic.message .. " [" .. diagnostic.source .. "]"
		-- end,
		format = nil,

		--- Enable it if you want to always have message with `after` characters length.
		break_line = {
			enabled = false,
			after = 30,
		},

		virt_texts = {
			priority = 2048,
		},

		-- Filter by severity.
		severity = {
			vim.diagnostic.severity.ERROR,
			vim.diagnostic.severity.WARN,
			vim.diagnostic.severity.INFO,
			vim.diagnostic.severity.HINT,
		},

        -- Overwrite events to attach to a buffer. You should not change it, but if the plugin
        -- does not works in your configuration, you may try to tweak it.
        overwrite_events = nil,
	},
})
```

## 💡 Highlights

- TinyInlineDiagnosticVirtualTextError
- TinyInlineDiagnosticVirtualTextWarn
- TinyInlineDiagnosticVirtualTextInfo
- TinyInlineDiagnosticVirtualTextHint
- TinyInlineDiagnosticVirtualTextArrow

`Inv` is used for left and right signs.
- TinyInlineInvDiagnosticVirtualTextError
- TinyInlineInvDiagnosticVirtualTextWarn
- TinyInlineInvDiagnosticVirtualTextInfo
- TinyInlineInvDiagnosticVirtualTextHint

## 📚 API

- `require("tiny-inline-diagnostic").change(blend, highlights)`: change the colors of the diagnostic. You need to refer to `setup` to see the structure of the `blend` and `highlights` options.
- `require("tiny-inline-diagnostic").get_diagnostic_under_cursor(bufnr)`: get the diagnostic under the cursor, useful if you want to display the diagnostic in a statusline.
- `require("tiny-inline-diagnostic").enable()`: enable the diagnostic.
- `require("tiny-inline-diagnostic").disable()`: disable the diagnostic.
- `require("tiny-inline-diagnostic").toggle()`: toggle the diagnostic, on/off.
- `require("tiny-inline-diagnostic").change_severities(severities)`: change the severity of the diagnostic. `severities` is an array of severity, like `vim.diagnostic.severity.ERROR`.


## ❓ FAQ:


- **Q**: My colors are bad
    - You can change the colors with the `hi` option.
    - If you have no background color, you should try to set `blend.mixing_color` to a color that will blend with the background color.
- **Q**: All diagnostics are still displayed
    - You need to set `vim.diagnostic.config({ virtual_text = false })` to remove all the others diagnostics.
- **Q**: Diagnostics are not readable on a light background
    - You can either set `vim.g.background = "light"` to use white diagnostics background. Will not work if `hi.mixing_color` is set
- **Q**: `GitBlame` (or other) is displayed first
    - You need to modify the `virt_texts.priority` option to a higher value.
