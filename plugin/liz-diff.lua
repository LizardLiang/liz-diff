vim.api.nvim_create_user_command('LizDiff', function()
  require('liz_diff').open()
end, { desc = 'Open liz-diff floating window' })

vim.api.nvim_create_user_command('LizDiffFile', function(o)
  local ref = (o.args ~= '') and o.args or 'HEAD'
  require('liz_diff').open_current(ref)
end, { nargs = '?', desc = 'liz-diff: diff current file vs HEAD (working left, commit right)' })

vim.api.nvim_create_user_command('LizDiffNext', function()
  require('liz_diff').next()
end, { desc = 'liz-diff: diff the next file in the list' })

vim.api.nvim_create_user_command('LizDiffPrev', function()
  require('liz_diff').prev()
end, { desc = 'liz-diff: diff the previous file in the list' })
