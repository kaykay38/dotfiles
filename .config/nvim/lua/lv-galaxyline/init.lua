local gl = require('galaxyline')
-- get my theme in galaxyline repo
-- local colors = require('galaxyline.theme').default
-- gruvbox colors
local colors = {
    bg = '#3c3836',
    aqua = "#427b58",
    light_aqua = "#689d6a",
    yellow = '#fabd2f',
    dark_yellow = '#b57614',
    cyan = '#689d6a',
    green = '#98971a',
    light_green = '#b8bb26',
    string_orange = '#af3a03',
    orange = '#d65d0e',
    purple = '#8f3f71',
    magenta = '#b16286',
    grey = '#928374',
    blue = '#458588',
    vivid_blue = '#876678',
    light_blue = '#83a598',
    red = '#cc241d',
    error_red = '#fb4934',
    info_yellow = '#fabd2f'
    -- bg = '#292D38',
    -- yellow = '#DCDCAA',
    -- dark_yellow = '#D7BA7D',
    -- cyan = '#4EC9B0',
    -- green = '#608B4E',
    -- light_green = '#B5CEA8',
    -- string_orange = '#CE9178',
    -- orange = '#FF8800',
    -- purple = '#C586C0',
    -- magenta = j#D16D9E',
    -- grey = '#858585',
    -- blue = '#569CD6',
    -- vivid_blue = '#4FC1FF',
    -- light_blue = '#9CDCFE',
    -- red = '#D16969',
    -- error_red = '#F44747',
    -- info_yellow = '#FFCC66'
}
local condition = require('galaxyline.condition')
local gls = gl.section
gl.short_line_list = {'NvimTree', 'vista', 'dbui', 'packer'}

gls.left[1] = {
    ViMode = {
        provider = function()
            -- auto change color according the vim mode
            local mode_color = {
                n = colors.green,
                i = colors.blue,
                v = colors.orange,
                [''] = colors.aqua,
                V = colors.orange,
                c = colors.blue,
                no = colors.blue,
                s = colors.blue,
                S = colors.blue,
                [''] = colors.orange,
                ic = colors.yellow,
                R = colors.red,
                Rv = colors.red,
                cv = colors.blue,
                ce = colors.blue,
                r = colors.red,
                rm = colors.cyan,
                ['r?'] = colors.cyan,
                ['!'] = colors.blue,
                t = colors.magenta
            }
            vim.api.nvim_command('hi GalaxyViMode guifg=' .. mode_color[vim.fn.mode()])
            return '▊ '
        end,
        highlight = {colors.red, colors.bg}
    }
}
print(vim.fn.getbufvar(0, 'ts'))
vim.fn.getbufvar(0, 'ts')

gls.left[2] = {
    GitIcon = {
        provider = function()
            return ' '
        end,
        condition = condition.check_git_workspace,
        separator = ' ',
        separator_highlight = {'NONE', colors.bg},
        highlight = {colors.orange, colors.bg}
    }
}

gls.left[3] = {
    GitBranch = {
        provider = 'GitBranch',
        condition = condition.check_git_workspace,
        separator = ' ',
        separator_highlight = {'NONE', colors.bg},
        highlight = {colors.white, colors.bg}
    }
}

gls.left[4] = {
    DiffAdd = {
        provider = 'DiffAdd',
        condition = condition.hide_in_width,
        icon = '  ',
        highlight = {colors.grey, colors.bg}
    }
}
gls.left[5] = {
    DiffRemove = {
        provider = 'DiffRemove',
        condition = condition.hide_in_width,
        icon = '   ',
        highlight = {colors.grey, colors.bg}
    }
}

gls.left[6] = {
    DiffModified = {
        provider = 'DiffModified',
        condition = condition.hide_in_width,
        icon = '   ',
        highlight = {colors.grey, colors.bg}
    }
}

gls.right[1] = {
    DiagnosticError = {provider = 'DiagnosticError', icon = '  ', highlight = {colors.error_red, colors.bg}}
}
gls.right[2] = {DiagnosticWarn = {provider = 'DiagnosticWarn', icon = '  ', highlight = {colors.orange, colors.bg}}}

gls.right[3] = {
    DiagnosticHint = {provider = 'DiagnosticHint', icon = '  ', highlight = {colors.vivid_blue, colors.bg}}
}

gls.right[4] = {DiagnosticInfo = {provider = 'DiagnosticInfo', icon = '  ', highlight = {colors.info_yellow, colors.bg}}}

gls.right[5] = {
    ShowLspClient = {
        provider = 'GetLspClient',
        condition = function()
            local tbl = {['dashboard'] = true, [' '] = true}
            if tbl[vim.bo.filetype] then return false end
            return true
        end,
        icon = ' ',
        highlight = {colors.grey, colors.bg}
    }
}

gls.right[6] = {
    LineInfo = {
        provider = 'LineColumn',
        separator = '  ',
        separator_highlight = {'NONE', colors.bg},
        highlight = {colors.grey, colors.bg}
    }
}

gls.right[7] = {
    PerCent = {
        provider = 'LinePercent',
        separator = ' ',
        separator_highlight = {'NONE', colors.bg},
        highlight = {colors.grey, colors.bg}
    }
}

gls.right[8] = {
    BufferType = {
        provider = 'FileTypeName',
        condition = condition.hide_in_width,
        separator = ' ',
        separator_highlight = {'NONE', colors.bg},
        highlight = {colors.grey, colors.bg}
    }
}

-- gls.right[9] = {
--     Tabstop = {
--         provider = function()
--             return "Spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth") .. " "
--         end,
--         condition = condition.hide_in_width,
--         separator = ' ',
--         separator_highlight = {'NONE', colors.bg},
--         highlight = {colors.grey, colors.bg}
--     }
-- }

-- gls.right[10] = {
--     FileEncode = {
--         provider = '',
--         condition = condition.hide_in_width,
--         separator = ' ',
--         separator_highlight = {'NONE', colors.bg},
--         highlight = {colors.grey, colors.bg}
--     }
-- }

gls.right[9] = {
    Space = {
        provider = function()
            return ' '
        end,
        separator = ' ',
        separator_highlight = {'NONE', colors.bg},
        highlight = {colors.orange, colors.bg}
    }
}

gls.short_line_left[1] = {
    BufferType = {
        provider = 'FileTypeName',
        separator = ' ',
        separator_highlight = {'NONE', colors.bg},
        highlight = {colors.grey, colors.bg}
    }
}

gls.short_line_left[2] = {
    SFileName = {provider = 'SFileName', condition = condition.buffer_not_empty, highlight = {colors.grey, colors.bg}}
}

gls.short_line_right[1] = {BufferIcon = {provider = 'BufferIcon', highlight = {colors.grey, colors.bg}}}
