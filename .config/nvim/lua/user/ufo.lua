require('ufo').setup({
  close_fold_kinds = {'imports', 'comment'},
  ufo_open_all_folds = 1,
  provider_selector = function(bufnr, filetype, buftype)
    return {'treesitter', 'indent'}
  end
})

