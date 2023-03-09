# Nvim-scrapy-debug

# STILL UNDER DEVELOPMENT

It's a small neovim plugin allowing debug and run Scrapy spider under the cursor.

## How it works

## Requirements

## Installation

Install the plugin with your favourite plugins manager.

```
" Plug
Plug "Uszczi/nvim-scrapy-debug"
Plug "nvim-lua/plenary.nvim"
```

```
-- Packer
use "Uszczi/nvim-scrapy-debug"
use "nvim-lua/plenary.nvim"
```

```
-- Lazy
require("lazy").setup(
    {
        "nvim-lua/plenary.nvim",
        "Uszczi/nvim-scrapy-debug"
    },
    {}
)
```

## Usage

Call setup method to register `ScrapyDebug` command.

```
require("nvim-scrapy-debug").setup()
```

```
:lua require("nvim-scrapy-debug").debug()

-- or create a keymap

vim.keymap.set("n", "<leader>dy", ":lua require('nvim-scrapy-debug').debug()<CR>", {silent = true})
```

## TODO

[ ] Add creating user command in setup \
[ ] Add vim docs \
[ ] Add creating ouput to specific file \
[ ] Finish readme
