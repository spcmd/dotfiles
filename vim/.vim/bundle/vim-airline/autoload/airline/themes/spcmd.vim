" ========================================================= "
" spcmd theme for Vim                                       "
" Created by: spcmd                                         "
" Website: http://spcmd.github.io                           "
"          https://github.com/spcmd                         "
"          https://gist.github.com/spcmd                    "
" ========================================================= "

let g:airline#themes#spcmd#palette = {}

let s:N1   = [ '#000000' , '#dfff00' , 16  , 190 ]
let s:N2   = [ '#ffffff' , '#444444' , 255 , 238 ]
let s:N3   = [ '#ffffff' , '#202020' , 255  , 234 ]
let g:airline#themes#spcmd#palette.normal = airline#themes#generate_color_map(s:N1, s:N2, s:N3)

let g:airline#themes#spcmd#palette.normal_modified = {
      \ 'airline_c': [ '#ffffff' , '#202020' , 15     , 234      , ''     ] ,
      \ }


let s:I1 = [ '#ffffff' , '#005fff' , 15  , 27  ]
let s:I2 = [ '#ffffff' , '#444444' , 255 , 238  ]
let s:I3 = [ '#ffffff' , '#202020' , 15  , 234  ]
let g:airline#themes#spcmd#palette.insert = airline#themes#generate_color_map(s:I1, s:I2, s:I3)
let g:airline#themes#spcmd#palette.insert_modified = {
      \ 'airline_c': [ '#ffffff' , '#202020' , 15     , 234      , ''     ] ,
      \ }
let g:airline#themes#spcmd#palette.insert_paste = {
      \ 'airline_a': [ s:I1[0]   , '#d78700' , s:I1[2] , 172     , ''     ] ,
      \ }

let g:airline#themes#spcmd#palette.replace = copy(g:airline#themes#spcmd#palette.insert)
let g:airline#themes#spcmd#palette.replace.airline_a = [ s:I2[0]   , '#af0000' , s:I2[2] , 124     , ''     ]
let g:airline#themes#spcmd#palette.replace_modified = g:airline#themes#spcmd#palette.insert_modified

let s:V1 = [ '#ffffff' , '#d75f00' , 15 , 202 ]
let s:V2 = [ '#ffffff' , '#444444' , 255 , 238 ]
let s:V3 = [ '#ffffff' , '#202020' , 15  , 234  ]
let g:airline#themes#spcmd#palette.visual = airline#themes#generate_color_map(s:V1, s:V2, s:V3)
let g:airline#themes#spcmd#palette.visual_modified = {
      \ 'airline_c': [ '#ffffff' , '#202020' , 255     , 234      , ''     ] ,
      \ }


let s:IA1 = [ '#4e4e4e' , '#1c1c1c' , 239 , 234 , '' ]
let s:IA2 = [ '#4e4e4e' , '#262626' , 239 , 235 , '' ]
let s:IA3 = [ '#4e4e4e' , '#303030' , 239 , 236 , '' ]
let g:airline#themes#spcmd#palette.inactive = airline#themes#generate_color_map(s:IA1, s:IA2, s:IA3)
let g:airline#themes#spcmd#palette.inactive_modified = {
      \ 'airline_c': [ '#875faf' , '' , 97 , '' , '' ] ,
      \ }

