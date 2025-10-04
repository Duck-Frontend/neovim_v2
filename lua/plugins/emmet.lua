vim.g.user_emmet_mode = 'n'
vim.g.user_emmet_leader_key = ','
vim.g.user_emmet_settings = {
  variables = {'lang' => 'ru'},
  html = {
    default_attributes = {
      'option' = {'value' => vim.null},
      'textarea' = {'id' => vim.null, 'name' => vim.null, 'cols' => '10', 'rows' => '10'},
    },
    snippets = {
      ['!'] = '<!DOCTYPE html>\n'..
              '<html lang=\"ru\">\n'..
              '<head>\n'..
              '\t<meta charset=\"${charset}\">\n'..
              '\t<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n'..
              '\t<title>${1:Document}</title>\n'..
              '</head>\n'..
              '<body>\n'..
              '\t${child}|\n'..
              '</body>\n'..
              '</html>',
    },
  },
}
