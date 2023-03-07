
local conf = {
        type = "generic_remote",
        name = "Generic remote",
        request = "attach",
        redirectOutput = true,
        justMyCode = false
}

local get_query = function()
    return vim.treesitter.query.parse_query(
        "python",
        [[
        (expression_statement
            (assignment
                left: (identifier) @field_name (#eq? @field_name "name")
                right: (string) @name
            )
        )
    ]]
    )
end

local run_debuger = function(name)
    local args = {
        "-m",
        "debugpy",
        "--listen",
        "127.0.0.1:5678",
        "--wait-for-client",
        "-m",
        "scrapy",
        "crawl",
        name
    }
    local j =
        require("plenary.job"):new {
        command = "python",
        args = args,
        on_exit = function(e)
            print("on_exit")
            print(e)
        end,
        on_stdout = function(j, return_val)
            print(return_val)
            print(j:result())
        end,
        on_stderr = function(e)
            print("on_stderr")
            print(e)
        end,
        start = function()
            print("start")
        end,
        on_error = function()
            print("on_error")
        end
    }
    return j:start()
end


local get_root = function(bufnr)
    local parser = vim.treesitter.get_parser(bufnr, "python", {})
    local tree = parser:parse()[1]
    return tree:root()
end

local M = {}

M.debug = function()
    bufnr = bufnr or vim.api.nvim_get_current_buf()
    local root = get_root(bufnr)

    local name = nil
    for _, node in get_query():iter_captures(root, bufnr, 0, -1) do
        name = vim.treesitter.get_node_text(node, bufnr)
    end

    name = name:gsub('"', "")
    run_debuger(name)
    print("debuger started")
    require'dap'.run(conf)
end





return M
