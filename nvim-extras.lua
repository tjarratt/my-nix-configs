-- ==============================
--
-- splash screen
--
-- ==============================

require("milli").vimenter({ splash = "shadertwo", loop = true })

-- ==============================
--
-- colour themes
--
-- ==============================

require("tokyonight").setup({
  style = "moon",

  on_highlights = function(hl, c)
    hl.LineNr = {
      fg = "#EDA0C0"
    }

    hl.CursorLineNr = {
      fg = c.yellow,
      bold = true,
    }
  end
})

vim.cmd("colorscheme tokyonight")
vim.opt.cursorline = true

-- ==============================
--
-- related files
--
-- ==============================

-- insert @related annotation below cursor
local function insert_related()
  local label = vim.fn.input('Label: ')
  if label == '' then return end

  local current_filepath = vim.fn.expand('%')
  local related_path
  if current_filepath:match('^lib/') then
    related_path = current_filepath
      :gsub('^lib/', 'test/')
      :gsub('%.exs?$', '_test.exs')
  elseif current_filepath:match('^test/') then
    related_path = current_filepath
      :gsub('^test/', 'lib/')
      :gsub('_test%.exs%', '.ex')
  else
    related_path = current_filepath
  end

  local annotation = '# @related [' .. label .. '](' .. related_path .. ')'
  vim.api.nvim_put({ annotation }, 'l', true, true)
end

vim.keymap.set('n', '<leader>rf', insert_related, { noremap = true, desc = 'Insert @related annotaiton' })

-- ==============================
--
-- code folding
--
-- ==============================

vim.o.foldmethod = syntax
vim.o.foldcolumn = '1' -- '0' isn't bad either
vim.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- ==============================
--
-- random strings
--
-- ==============================

math.randomseed(os.time())

local vanilla_dictionary = {}
local function load_vanilla_dictionary()
  if #vanilla_dictionary == 0 then
    local file = io.open("/usr/share/dict/words", "r")
    for line in file:lines() do
      table.insert(vanilla_dictionary, line)
    end
    file:close()
  end
end

local function random_word()
  return vanilla_dictionary[math.random(#vanilla_dictionary)]
end

local function random_string_vanilla()
  load_vanilla_dictionary()
  return random_word() .. "-" .. random_word()
end

function insert_random_string()
  string = random_string_vanilla()

  vim.fn.feedkeys('i', 'n')
  vim.fn.feedkeys(string, 'n')
  vim.api.nvim_input('<ESC>')
end

-- ==============================
--
-- Aerial (outline window and quick nav)
--
-- ==============================

require("aerial").setup({
  layout = {
    max_width = { 100, 0.6 },
    width = nil,
    min_width = 100,
  },
});

-- ==============================
--
-- Tardis
--
-- ==============================

require("tardis-nvim").setup({
  keymap = {
    ["next"] = '<C-j>',
    ["prev"] = '<C-k>',
    ["quit"] = 'q',
    ["revision_message"] = '<C-m>',
    ["commit"] = '<C-g>',
  },
  settings = {
    initial_revisions = 10,
    max_revisions = 4000,
    show_commit_index = false
  },
})

vim.api.nvim_set_keymap('n', '<leader>gtm', ':Tardis git<cr>', { noremap = true })

-- ==============================
--
-- Keybindings
--
-- ==============================

vim.api.nvim_set_keymap('n', '<leader>rs', '<cmd>lua insert_random_string()<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>sw', ':StripWhitespace<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>aw', '<cmd>AerialToggle!<cr>', { noremap = true })

-- ==============================
--
-- Events
--
-- ==============================

vim.cmd('autocmd BufLeave,FocusLost * silent! update')
