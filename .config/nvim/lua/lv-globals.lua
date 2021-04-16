O = {
    auto_close_tree = 0,
    auto_complete = true,
    colorscheme = 'gruvbox8',
    cmdheight=1,
    hidden_files = true,
    wrap_lines = true,
    relative_number = true,
    breakindent=true,
    showbreak='↪>>>',
    fillchars_vert=" ",
    number = true,
    shell = 'zsh',

    -- @usage pass a table with your desired languages
    treesitter = {
        ensure_installed = "all",
        ignore_install = {"haskell"},
        highlight = {enabled = true},
        playground = {enabled = true},
        rainbow = {enabled = false}
    },

    database = {save_location = '~/.config/nvcode_db', auto_execute = 1},
    python = {
        linter = 'pyright',
        -- @usage can be 'yapf', 'black'
        formatter = '',
        autoformat = false,
        isort = false,
        diagnostics = {virtual_text = false, signs = true, underline = true}
    },
    java = {sdk_path = '/usr/lib/jvm/java-15-openjdk/bin/java',
        -- @usage can be 'eslint'
        linter = 'javac',
        formatter = '',
        autoformat = false,
        diagnostics = {virtual_text = false, signs = true, underline = true}
    },
    dart = {sdk_path = '/usr/lib/dart/bin/snapshots/analysis_server.dart.snapshot'},
    lua = {
        -- @usage can be 'lua-format'
        linter = 'sumneko_lua',
        formatter = '',
        autoformat = false,
        diagnostics = {virtual_text = false, signs = true, underline = true}
    },
    sh = {
        -- @usage can be 'shellcheck'
        linter = '',
        -- @usage can be 'shfmt'
        formatter = '',
        autoformat = false,
        diagnostics = {virtual_text = false, signs = true, underline = true}
    },
    tsserver = {
        -- @usage can be 'eslint'
        linter = '',
        -- @usage can be 'prettier'
        formatter = '',
        autoformat = false,
        diagnostics = {virtual_text = false, signs = true, underline = true}
    },
    json = {
        -- @usage can be 'prettier'
        formatter = '',
        autoformat = false,
        diagnostics = {virtual_text = false, signs = true, underline = true}
    },
    tailwindls = {filetypes = {'html', 'cshtml', 'css', 'scss', 'javascript', 'javascriptreact', 'typescript', 'typescriptreact'}},
    clang = {diagnostics = {virtual_text = false, signs = true, underline = true}}
    -- css = {formatter = '', autoformat = false, virtual_text = true},
    -- json = {formatter = '', autoformat = false, virtual_text = true}
}

DATA_PATH = vim.fn.stdpath('data')
CACHE_PATH = vim.fn.stdpath('cache')

