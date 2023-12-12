return {
  'kana/vim-operator-user',
  {
    'kana/vim-operator-replace',
    dependencies = {'kana/vim-operator-user'},
    keys = {
      { 'R', '<Plug>(operator-replace)', mode = ''},
    },
  },
  {
    'rhysd/vim-operator-surround',
    dependencies = {'kana/vim-operator-user'},
    keys = {
      { 'sa', '<Plug>(operator-surround-append)', mode = '', silent = true },
      { 'sr', '<Plug>(operator-surround-replace)', mode = '', silent = true },
      { 'sd', '<Plug>(operator-surround-delete)', mode = '', silent = true },
      { '<Leader>sr', '<Plug>(operator-surround-replace)<Plug>(textobj-between-a)', silent = true },
      { '<Leader>sd', '<Plug>(operator-surround-delete)<Plug>(textobj-between-a)', silent = true },
    },
  },
}
