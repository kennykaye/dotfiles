" ================ Multiple Cursors ========================

" Highlighting
hi! link multiple_cursors_cursor LightLineLeft_visual_0
hi! link multiple_cursors_visual LightLineLeft_visual_0


function! Multiple_cursors_before()
    exe 'NeoCompleteLock'
    echo 'Disabled autocomplete'
endfunction

function! Multiple_cursors_after()
    exe 'NeoCompleteUnlock'
    echo 'Enabled autocomplete'
endfunction
