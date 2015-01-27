" File: dubs_cycloplan.vim
" Author: Landon Bouma (dubsacks &#x40; retrosoft &#x2E; com)
" Last Modified: 2015.01.25
" Project Page: https://github.com/landonb/dubs_cycloplan
" Summary: EditPlus-inspired editing mappings
" License: GPLv3
" -------------------------------------------------------------------
" Copyright © 2009-2015, 2015 Landon Bouma.
" 
" This program is free software: you can redistribute it and/or
" modify it under the terms of the GNU General Public License as
" published by the Free Software Foundation, either version 3 of
" the License, or (at your option) any later version.
"
" This program is distributed in the hope that it will be useful,
" but WITHOUT ANY WARRANTY; without even the implied warranty of
" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
" GNU General Public License for more details.
"
" You should have received a copy of the GNU General Public License
" along with this program. If not, see <http://www.gnu.org/licenses/>
" or write Free Software Foundation, Inc., 51 Franklin Street,
"                     Fifth Floor, Boston, MA 02110-1301, USA.
" ===================================================================

" ------------------------------------------
" About:

" This script maps F-keys to common Cycloplan development
" tasks and sets up Cycloplan-specific features such as
" bouncing to the Web page of a bug whose number is under
" cursor.

if exists("g:plugin_cycloplan") || &cp
  finish
endif
let g:plugin_cycloplan = 1

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Browse Web to Bug Under Cursor
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" Link to bug page of bug number under cursor or selected (open-issue).
" :!firefox http://bugs.cyclopath.org/show_bug.cgi?id=2825 &> /dev/null
" Test the three modes: http://google.com/show_bug.cgi?id=2825 &> /dev/null
noremap <silent> <Leader>i
  \ :!firefox http://bugs.cyclopath.org/show_bug.cgi?id=<C-R><C-W>
  \ &> /dev/null<CR><CR>
inoremap <silent> <Leader>i
  \ <C-O>:!firefox http://bugs.cyclopath.org/show_bug.cgi?id=<C-R><C-W>
  \ &> /dev/null<CR><CR>
" Interesting: C-U clears the command line, which contains cruft, e.g., '<,'>
" gv selects the previous Visual area.
" y yanks the selected text into the default register.
" <Ctrl-R>" puts the yanked text into the command line.
vnoremap <silent> <Leader>i :<C-U>
  \ <CR>gvy
  \ :!firefox http://bugs.cyclopath.org/show_bug.cgi?id=<C-R>"
  \ &> /dev/null<CR><CR>
" Test the three modes using: https://github.com/p6a

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Map all the Fkeys 
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" Some of these commands are also available from bash.
" See: ~/.fries/bashrc/bashrc.cyclopath.*
" Via: https://github.com/landonb/home-fries

" Build Cycloplan (Incremental)
" ------------------------------------------------------
" F5

" 2012.10.31: Disabled. Build from CLI and use C-F5 to see output.
""map <F5> <Plug>Cycloplan_Build_Incremental
"noremap <F5> :call <SID>Cycloplan_Build_Project(0)<CR><CR>
"inoremap <F5> <C-O>:call <SID>Cycloplan_Build_Project(0)<CR><CR>
""cnoremap <F5> <C-C>:call <SID>Cycloplan_Build_Incremental()<CR>
""onoremap <F5> <C-C>:call <SID>Cycloplan_Build_Incremental()<CR>
""map <silent> <unique> <script>
""  \ <Plug>Cycloplan_Build_Incremental 
""  \ :call <SID>Cycloplan_Build_Project(0)<CR>
""   2. Thunk the <Plug>
""function s:Cycloplan_Build_Incremental()
""  " FIXME: Sometimes I [lb] sloppilly hit F5 (build Ccp) when I mean to hit F6
""  " (restart Apache). Rather than move the keys further apart, what about
""  " having this fcn. check if fcsh is running or not: I usually debug pyserver 
""  " with fcsh killed, so this fcn. should only run if fcsh is running,
""  " otherwise the mistake wastes a lot of time, since it takes a while to start
""  " fcsh.
""  "!ps aux 
""  "  \| grep -e bin/fcsh$ -e lib/fcsh.jar$ -e "python ./fcsh-wrap"
""  "  \| awk '{print $2}' 
""  " First, save all files
""  :wa
""  " NOTE The tee commands outputs to stdout and saves to a file
""  "!pushd $cp/flashclient ; make | tee /tmp/flashclient_make ; popd
""  !pushd $cp/flashclient ; make ; cd $cp ; ./fixperms.sh ; popd
""  " Clear the flash log?
""  :call <SID>Cycloplan_Flash_Log_Truncate()
""  "!pushd $cp/flashclient ; make | tee /tmp/flashclient_make 2>&1 ; popd
""  "!pushd $cp/flashclient ; make > /tmp/flashclient_make 2>&1 ; popd
""  set errorformat=%A%f(%l):\ col:\ %c\ %m,%Z%m,%A%f(%l):\ %m,%Z%m
""  cgetfile /tmp/flashclient_make
""  :QFix!(1)
""  " FIXME Search for the first error
""  "   /Error:
""endfunction
"" FIXME Need "set errorformat=..." for flex output

" AS Syntax Errors:
"/ccp/dev/cp_1051/flashclient/build/views/dpanels/Detail_Box_Access_Manage.mxml(25):  Error: Syntax error: expected a definition keyword (such as function) after attribute protected, not static.

" MXML Syntax Errors:
"/ccp/dev/cp_1051/flashclient/build/views/dpanels/Detail_Box_Access_Manage.mxml(61): col: 15 Error: Attribute name "i" must be followed by the ' = ' character.

" Build Cycloplan (Rebuild All)
" ------------------------------------------------------
" SHIFT-F5

" FIXME Do silently/in background
"       :execute "!myscript &" | redraw
"       :silent execute "!myscript &" | redraw
" 2012.10.31: Disabled. Build from CLI and use C-F5 to see output.
""map <S-F5> <Plug>Cycloplan_Build_Clean
"noremap <S-F5> :call <SID>Cycloplan_Build_Project(1)<CR><CR>
"inoremap <S-F5> <C-O>:call <SID>Cycloplan_Build_Project(1)<CR><CR>
""map <silent> <unique> <script>
""  \ <Plug>Cycloplan_Build_Clean 
""  \ :call <SID>Cycloplan_Build_Project(1)<CR>
""   2. Thunk the <Plug>
""function s:Cycloplan_Build_Clean()
""  "!killfc ; pushd $cp/flashclient ; make clean ; make ; cd $cp ; ./fixperms.sh ; re ; popd ; killfc
""  " NOTE The tee command hangs (waiting on EOF?) if we redirect stderr to stdout, e.g..,
""  "        pushd $cp/flashclient ; make clean ; make 2>&1 | tee /tmp/flashclient_make ; cd $cp ; ./fixperms.sh ; popd
""  "      I also tried
""  "        !pushd $cp/flashclient ; make clean ; make | tee /tmp/flashclient_make 2>&1 ; cd $cp ; ./fixperms.sh ; popd
""  "        !pushd $cp/flashclient ; make clean ; make |& tee /tmp/flashclient_make 2>&1 ; cd $cp ; ./fixperms.sh ; popd
""  "      So we'll just write straight to the temp file, which is fine, but
""  "      that means there's no live output while the command is being processed
""  :wa
""  call <SID>Cycloplan_Fcsh_Kill()
""  " NOTE The 2>&1, which redirects stderr to stdout, comes _after_ the whole "[command] > [file]"
""  "!pushd $cp/flashclient ; make clean ; make > /tmp/flashclient_make 2>&1 ; cd $cp ; ./fixperms.sh ; popd
""  !pushd $cp/flashclient ; make clean ; make ; cd $cp ; ./fixperms.sh ; popd
""  "call <SID>Cycloplan_Fcsh_Kill()
""  call <SID>Cycloplan_Apache_Restart()
""  " FIXME This is wrong -- Do we need to restore the old errorformat later?
""  " FIXME Should this go in a "autocmd BufRead..." ??
""  set errorformat=%A%f(%l):\ %m,%Z%m
""  cgetfile /tmp/flashclient_make
""  :QFix!(1)
""endfunction

" 2012.10.31: Disabled. Build from CLI and use C-F5 to see output.
"             This fcn. is no longer wired to any shortcut keys.
function s:Cycloplan_Build_Project(make_clean)
  " First, save all files
  :wa
  " NOTE The tee commands outputs to stdout and saves to a file
  "!killfc ; pushd $cp/flashclient ; make clean ; make ; cd $cp ; ./fixperms.sh ; re ; popd ; killfc
  " NOTE The tee command hangs (waiting on EOF?) if we redirect stderr to stdout, e.g..,
  "        pushd $cp/flashclient ; make clean ; make 2>&1 | tee /tmp/flashclient_make ; cd $cp ; ./fixperms.sh ; popd
  "      I also tried
  "        !pushd $cp/flashclient ; make clean ; make | tee /tmp/flashclient_make 2>&1 ; cd $cp ; ./fixperms.sh ; popd
  "        !pushd $cp/flashclient ; make clean ; make |& tee /tmp/flashclient_make 2>&1 ; cd $cp ; ./fixperms.sh ; popd
  "      So now fcsh-wrap just writes the output file for us.
  if (a:make_clean)
    call <SID>Cycloplan_Fcsh_Kill()
    make -C $cp/flashclient clean
  endif
  make --directory=$cp/flashclient
  " fcsh-wrap writes flashclient_make but the paths are to the build directory.
  " NOTE: There are two build directories: build/ and build-print/.
  silent !sed 's/\/flashclient\/build\(-print\)\?\//\/flashclient\//g' 
    \ /tmp/flashclient_make > /tmp/flashclient_make.ccp
  " Fix permissions on the executable.
  !$cp/fixperms.sh
  " Restart the server if we bothered we a big build.
  if (a:make_clean)
    "call <SID>Cycloplan_Fcsh_Kill()
    call <SID>Cycloplan_Apache_Restart()
  endif
  " FIXME This is wrong -- Do we need to restore the old errorformat later?
  " FIXME Should this go in a "autocmd BufRead..." ??
  set errorformat=%A%f(%l):\ col:\ %c\ %m,%Z%m,%A%f(%l):\ %m,%Z%m
  cgetfile /tmp/flashclient_make.ccp
  :QFix!(1)
endfunction

function s:Cycloplan_Fcsh_Kill()
  " Kill the following:
  "   /bin/sh /ccp/opt/flex/bin/fcsh
  "   java ... -jar /ccp/opt/flex/bin/../lib/fcsh.jar
  "   /usr/bin/python ./fcsh-wrap ...
  !ps aux 
    \| grep -e bin/fcsh$ -e lib/fcsh.jar$ -e "python ./fcsh-wrap" 
    \| awk '{print $2}' 
    \| xargs sudo kill -s 9
endfunction

" Restore Make Output (Quickfix) Hack
" ------------------------------------------------------
" CTRL-F5

"map <C-F5> <Plug>Quickfix_Older_Older
noremap <C-F5> :call <SID>Quickfix_Older_Older()<CR>
inoremap <C-F5> <C-O>:call <SID>Quickfix_Older_Older()<CR>
map <silent> <unique> <script> 
  \ <Plug>Quickfix_Older_Older 
  \ :call <SID>Quickfix_Older_Older()<CR>
"   2. Thunk the <Plug>
function s:Quickfix_Older_Older()
  " After running make, you can double-click errors in the quickfix window to
  " fix the compile-time error, but you'll find yourself searching (egrep'ing)
  " the code to fix other things. Unfortunately, there's no easy way I can
  " tell to return to the Make output. Vim does store 10 quickfix "lists" that
  " you can peruse with :colder and :cnewer, and but I don't think you can get
  " the number of the current list. (Though there's probably a way, the answer
  " buried somewhere deep in the Vim docs.) For now, we just back up two lists,
  " which you can do after searching to return to the Make error list. And why
  " do we back up two lists? Because when egrep first returns, the list is
  " unsorted. When we sort it (so the list of files and lines is alphabetical),
  " Vim creates a new quickfix buffer.
  "":cold 2
  " FIXME Duh! Two hours later I realize we just load the tmp file /tmp/...
  set errorformat=%A%f(%l):\ col:\ %c\ %m,%Z%m,%A%f(%l):\ %m,%Z%m
  cgetfile /tmp/flashclient_make
  :QFix!(1)
endfunction

" Restart Apache Service
" ------------------------------------------------------
" F6

"map <F6> <Plug>Cycloplan_Apache_Restart
noremap <F6> :call <SID>Cycloplan_Apache_Restart()<CR><CR>
inoremap <F6> <C-O>:call <SID>Cycloplan_Apache_Restart()<CR><CR>
map <silent> <unique> <script> 
  \ <Plug>Cycloplan_Apache_Restart 
  \ :call <SID>Cycloplan_Apache_Restart()<CR>
"   2. Thunk the <Plug>
function s:Cycloplan_Apache_Restart()
  :wa " Save all files
  " Clear the apache log?
  !echo > /ccp/var/log/pyserver/minnesota-apache.log
  " Restart the apache service
  if (match(system('cat /proc/version'), 'Red Hat') >= 0)
    !sudo service httpd restart
  elseif (match(system('cat /proc/version'), 'Ubuntu') >= 0)
    !sudo /etc/init.d/apache2 restart
  endif
endfunction
" FIXME Using alias re= for now, but should check if Ubuntu or Fedora and make
"       appropriate call

" Kill Apache Service
" ------------------------------------------------------
" SHIFT-F6

" NOTE This fcn. shouldn't be needed. It was at one time, circa 2010, but I
"      don't remember why.
"map <S-F6> <Plug>Cycloplan_Apache_Kill
noremap <S-F6> :call <SID>Cycloplan_Apache_Kill()<CR><CR>
inoremap <S-F6> <C-O>:call <SID>Cycloplan_Apache_Kill()<CR><CR>
map <silent> <unique> <script> 
  \ <Plug>Cycloplan_Apache_Kill 
  \ :call <SID>Cycloplan_Apache_Kill()<CR>
"   2. Thunk the <Plug>
function s:Cycloplan_Apache_Kill()
  !ps aux | grep /usr/sbin/apache2 | awk '{print $2}' | xargs sudo kill -s 9
endfunction

" Open Flash logfile (in current Vim)
" ------------------------------------------------------
" F7

"map <F7> <Plug>Cycloplan_Load_Flash_Log
noremap <F7> :call <SID>Cycloplan_Load_Flash_Log(1)<CR>
inoremap <F7> <C-O>:call <SID>Cycloplan_Load_Flash_Log(1)<CR>
noremap <C-F7> :call <SID>Cycloplan_Load_Flash_Log(0)<CR>
inoremap <C-F7> <C-O>:call <SID>Cycloplan_Load_Flash_Log(0)<CR>
map <silent> <unique> <script> 
  \ <Plug>Cycloplan_Load_Flash_Log 
  \ :call <SID>Cycloplan_Load_Flash_Log(1)<CR>
"   2. Thunk the <Plug>
function s:Cycloplan_Load_Flash_Log(open_in_quickfix)
  if a:open_in_quickfix == 0
    " The Putzy Way is just to open the flashlog in the current window:
    :edit ~/.macromedia/Flash_Player/Logs/flashlog.txt
  else
    " But The Cool Way is to show the flashlog in the error/quickfix window.
    " And we can format file-name-and-line-number lines, too, so you can
    " double-click to jump a file and line.
    " E.g.,
    "    Error: assertion failed: items/Item_Versioned.as:629
    "    at G$/assert()[/ccp/dev/cp_2628/flashclient/build/G.as:304]
    "    ...
    "    ' %.%#' (which stands for the regular expression ' .*'
"    set errorformat=%.%#
"    set errorformat=%m
    set errorformat=%.%#at\ %m[%f:%l]
    let l:curwinnr = winnr()
    " NOTE: There are two build directories: build/ and build-print/.
    silent !sed 's/ccp\/dev\/[^\/]\+\/flashclient\/build\(-print\)\?\//ccp\/dev\/cp\/flashclient\//g' 
      \ ~/.macromedia/Flash_Player/Logs/flashlog.txt 
      \ > ~/.macromedia/Flash_Player/Logs/flashlog-ccp.txt
    cgetfile ~/.macromedia/Flash_Player/Logs/flashlog-ccp.txt
    QFix!(0)
    " autocmd BufEnter doesn't work with quickfix -- trying to use G or <C-End>
    " to bounce to the bottom of the file, we only get as far as the first
    " error. But we can just get around that here. Jump to the quickfix
    " window, jump to the bottom of the file, set autoread so the buffer
    " automatically reloads as the browser appends the file, and then jump back
    " to the window where the user was.
    copen
    normal G
    set autoread
    exe l:curwinnr . "wincmd w"
  endif
endfunction

"au BufNewfile,BufRead * if &buftype == 'quickfix' 
"  \ | map <buffer> <m-f><m-l> 
"  \ :exec 'call vl#lib#quickfix#filtermod#FilterQFListByRegex('.string(input('qf: keep re: ')).', 0)'<cr>| endif
"
""func filters the quick fix list by this regular expression (only found error
""messages are affected)
"function! vl#lib#quickfix#filtermod#FilterQFListByRegex(regex, ...)
"  exec vl#lib#brief#args#GetOptionalArg("keep",string(1))
"    call vl#lib#quickfix#filtermod#ProcessQuickFixResult(
"      \ {'func': 'vl#lib#quickfix#filtermod#FilterList'
"      \ , 'args' : [ keep, a:regex ] } )
"endfunction
"
"call map(qfl, "( v:val['bufnr'] > 0 ? vl#lib#listdict#dict#SetReturn(v:val,'filename', bufname(v:val['bufnr'])) : v:val)")


" Open Flash logfile (in another Vim)
" ------------------------------------------------------
" SHIFT-F7

"map <S-F7> <Plug>Cycloplan_Load_Flash_Log_New_Instance
noremap <S-F7> :call <SID>Cycloplan_Load_Flash_Log_New_Instance()<CR><CR>
inoremap <S-F7> <C-O>:call <SID>Cycloplan_Load_Flash_Log_New_Instance()<CR><CR>
" NOTE Using two <CR>s so the output and the message, 
"      _Press ENTER or type command to continue_, are dismissed
map <silent> <unique> <script> 
  \ <Plug>Cycloplan_Load_Flash_Log_New_Instance 
  \ :call <SID>Cycloplan_Load_Flash_Log_New_Instance()<CR><CR>
"   2. Thunk the <Plug>
function s:Cycloplan_Load_Flash_Log_New_Instance()
  !gvim --servername ALPHA --remote-silent
    \ ~/.macromedia/Flash_Player/Logs/flashlog.txt
endfunction

" The Flash logfile is continuously appended by the Flash plugin, which 
" produces warnings in Vim and reloading. To avoid these messages (e.g.,
" Warning: File "{filename}" has changed since editing started) and the 
" subsequent prompt, set autoread. See :h W11 for more details.
autocmd BufRead ~/.macromedia/Flash_Player/Logs/flashlog.txt set autoread
autocmd BufRead ~/.macromedia/Flash_Player/Logs/flashlog.txt normal G
autocmd BufEnter,BufRead ~/.macromedia/Flash_Player/Logs/flashlog.txt match none
"autocmd BufEnter,BufRead flashlog.txt set autoread
"autocmd BufEnter,BufRead flashlog.txt normal G
"autocmd BufEnter,BufRead flashlog.txt normal <C-End>
" G and <C-End> do the same thing for remote window, but in quickfix, goes to
" first error... hmmmmm

" Truncate Flash logfile
" ------------------------------------------------------
" CTRL-SHIFT-F7

noremap <C-S-F7> :call <SID>Cycloplan_Flash_Log_Truncate()<CR><CR>
inoremap <C-S-F7> <C-O>:call <SID>Cycloplan_Flash_Log_Truncate()<CR><CR>
" NOTE Using two <CR>s so the output and the message, 
"      _Press ENTER or type command to continue_, are dismissed
map <silent> <unique> <script> 
  \ <Plug>Cycloplan_Flash_Log_Truncate 
  \ :call <SID>Cycloplan_Flash_Log_Truncate()<CR><CR>
"   2. Thunk the <Plug>
function s:Cycloplan_Flash_Log_Truncate()
  !echo > ~/.macromedia/Flash_Player/Logs/flashlog.txt
endfunction

" Open the pyserver crash dump and request in the Quickfix window
" ------------------------------------------------------
" F8s

"Traceback (most recent call last):
"  File "/ccp/dev/cp/pyserver/gwis/request.py", line 136, in process_req
"    self.command_process_req()
"  [...]
"  File "/ccp/dev/cp/pyserver/item/group_item_access.py", line 328, in search_get_sql
"    assert(username)
"AssertionError

"Traceback (most recent call last):
"  File "/ccp/dev/cp/pyserver/gwis/request.py", line 128, in process_req
"    self.command_process_req()
"  [...]
"  File "/ccp/dev/cp/pyserver/gwis/command_/commit.py", line 553
"    b = a + 2
"   ^
"IndentationError: unexpected indent

" NOTE See "set errorformat=..." in dubsacks.vim to the Python Quickfix def'n
"map <F8> <Plug>Cycloplan_Load_Pyserver_Dump
noremap <F8> :call <SID>Cycloplan_Load_Pyserver_Dump()<CR>
inoremap <F8> <C-O>:call <SID>Cycloplan_Load_Pyserver_Dump()<CR>
map <silent> <unique> <script> 
  \ <Plug>Cycloplan_Load_Pyserver_Dump 
  \ :call <SID>Cycloplan_Load_Pyserver_Dump()<CR>
"   2. Thunk the <Plug>
function s:Cycloplan_Load_Pyserver_Dump()
  " FIXME This is wrong -- Do we need to restore the old errorformat later?
  " FIXME Should this go in a "autocmd BufRead..." ??
  " See quickfix.txt.gz for help w/ this string (:h efm & :h errorformat)
  " "%.%#"  (".*")   matches a (possibly empty) string
  set errorformat=%A\ %.%#File\ \"%f\"\\,\ line\ %l\\,\ in\ %m,%Z%m,%A\ %.%#File\ \"%f\"\\,\ line\ %l,%Z%m
  ":cfile /tmp/pyserver_dumps/dump.EXCEPT
  :cgetfile /ccp/var/log/pyserver_dumps/dump.EXCEPT
  ":QFix!
  :QFix!(0)
  ":QFix(1, 1)
endfunction

noremap <C-F8> :call <SID>Cycloplan_Load_Pyserver_Dump_Request()<CR>
inoremap <C-F8> <C-O>:call <SID>Cycloplan_Load_Pyserver_Dump_Request()<CR>
map <silent> <unique> <script> 
  \ <Plug>Cycloplan_Load_Pyserver_Dump_Request 
  \ :call <SID>Cycloplan_Load_Pyserver_Dump_Request()<CR>
"   2. Thunk the <Plug>
function s:Cycloplan_Load_Pyserver_Dump_Request()
  set errorformat=%m
  :cgetfile /ccp/var/log/pyserver_dumps/dump.REQUEST
  :QFix!(0)
endfunction

autocmd BufRead /ccp/var/log/pyserver_dumps/dump.EXCEPT set autoread
autocmd BufRead /ccp/var/log/pyserver_dumps/dump.EXCEPT normal G
autocmd BufEnter,BufRead /ccp/var/log/pyserver_dumps/dump.EXCEPT match none

autocmd BufRead /ccp/var/log/pyserver_dumps/dump.REQUEST set autoread
autocmd BufRead /ccp/var/log/pyserver_dumps/dump.REQUEST normal G
autocmd BufEnter,BufRead /ccp/var/log/pyserver_dumps/dump.REQUEST match none

" Open the apache log file in the Quickfix or current window
" ------------------------------------------------------
" F9s

noremap <F9> :call <SID>Cycloplan_Load_Apache_Log_File(1)<CR>
inoremap <F9> <C-O>:call <SID>Cycloplan_Load_Apache_Log_File(1)<CR>
noremap <C-F9> :call <SID>Cycloplan_Load_Apache_Log_File(0)<CR>
inoremap <C-F9> <C-O>:call <SID>Cycloplan_Load_Apache_Log_File(0)<CR>
map <silent> <unique> <script> 
  \ <Plug>Cycloplan_Load_Apache_Log_File 
  \ :call <SID>Cycloplan_Load_Apache_Log_File(1)<CR>
"   2. Thunk the <Plug>
function s:Cycloplan_Load_Apache_Log_File(open_in_quickfix)
  if a:open_in_quickfix == 0
    " The Putzy Way is just to open the flashlog in the current window:
    :edit /ccp/var/log/pyserver/minnesota-apache.log
  else
    "set errorformat=%m
    " C.f. Cycloplan_Load_Pyserver_Dump, but leading crap ok (i.e., timestamp,
    "      logging level, logger name, and octothorphe).
    set errorformat=%A\%.%#File\ \"%f\"\\,\ line\ %l\\,\ in\ %m,%Z%m,%A\%.%#File\ \"%f\"\\,\ line\ %l,%Z%m
    :cgetfile /ccp/var/log/pyserver/minnesota-apache.log
    :QFix!(0)
  endif
endfunction

autocmd BufRead /ccp/var/log/pyserver/minnesota-apache.log set autoread
autocmd BufRead /ccp/var/log/pyserver/minnesota-apache.log normal G
autocmd BufEnter,BufRead /ccp/var/log/pyserver/minnesota-apache.log match none

" Truncate Apache logfile
" ------------------------------------------------------
" CTRL-SHIFT-F9

noremap <C-S-F9> :call <SID>Cycloplan_Apache_Log_Truncate()<CR><CR>
inoremap <C-S-F9> <C-O>:call <SID>Cycloplan_Apache_Log_Truncate()<CR><CR>
" NOTE Using two <CR>s so the output and the message, 
"      _Press ENTER or type command to continue_, are dismissed
map <silent> <unique> <script> 
  \ <Plug>Cycloplan_Apache_Log_Truncate 
  \ :call <SID>Cycloplan_Apache_Log_Truncate()<CR><CR>
"   2. Thunk the <Plug>
function s:Cycloplan_Apache_Log_Truncate()
  !echo > /ccp/var/log/pyserver/minnesota-apache.log
endfunction

" Open the miscellany log file in the Quickfix or current window
" ------------------------------------------------------
" F10s

noremap <F10> :call <SID>Cycloplan_Load_Misc_Log_File(1)<CR>
inoremap <F10> <C-O>:call <SID>Cycloplan_Load_Misc_Log_File(1)<CR>
noremap <C-F10> :call <SID>Cycloplan_Load_Misc_Log_File(0)<CR>
inoremap <C-F10> <C-O>:call <SID>Cycloplan_Load_Misc_Log_File(0)<CR>
map <silent> <unique> <script> 
  \ <Plug>Cycloplan_Load_Misc_Log_File 
  \ :call <SID>Cycloplan_Load_Misc_Log_File(1)<CR>
"   2. Thunk the <Plug>
function s:Cycloplan_Load_Misc_Log_File(open_in_quickfix)
  if a:open_in_quickfix == 0
    " The Putzy Way is just to open the flashlog in the current window:
    :edit /ccp/var/log/pyserver/minnesota-misc.log
  else
    "set errorformat=%m
    " C.f. Cycloplan_Load_Pyserver_Dump, but leading crap ok (i.e., timestamp,
    "      logging level, logger name, and octothorphe).
    set errorformat=%A\%.%#File\ \"%f\"\\,\ line\ %l\\,\ in\ %m,%Z%m,%A\%.%#File\ \"%f\"\\,\ line\ %l,%Z%m
    :cgetfile /ccp/var/log/pyserver/minnesota-misc.log
    :QFix!(0)
  endif
endfunction

autocmd BufRead /ccp/var/log/pyserver/minnesota-misc.log set autoread
autocmd BufRead /ccp/var/log/pyserver/minnesota-misc.log normal G
autocmd BufEnter,BufRead /ccp/var/log/pyserver/minnesota-misc.log match none

" Truncate miscellany logfile
" ------------------------------------------------------
" CTRL-SHIFT-F10

noremap <C-S-F10> :call <SID>Cycloplan_Misc_Log_Truncate()<CR><CR>
inoremap <C-S-F10> <C-O>:call <SID>Cycloplan_Misc_Log_Truncate()<CR><CR>
" NOTE Using two <CR>s so the output and the message, 
"      _Press ENTER or type command to continue_, are dismissed
map <silent> <unique> <script> 
  \ <Plug>Cycloplan_Misc_Log_Truncate 
  \ :call <SID>Cycloplan_Misc_Log_Truncate()<CR><CR>
"   2. Thunk the <Plug>
function s:Cycloplan_Misc_Log_Truncate()
  !echo > /ccp/var/log/pyserver/minnesota-misc.log
endfunction

" Open the routed log file in the Quickfix or current window
" ------------------------------------------------------
" F11s

noremap <F11> :call <SID>Cycloplan_Load_Routed_Log_File(1)<CR>
inoremap <F11> <C-O>:call <SID>Cycloplan_Load_Routed_Log_File(1)<CR>
noremap <C-F11> :call <SID>Cycloplan_Load_Routed_Log_File(0)<CR>
inoremap <C-F11> <C-O>:call <SID>Cycloplan_Load_Routed_Log_File(0)<CR>
map <silent> <unique> <script> 
  \ <Plug>Cycloplan_Load_Routed_Log_File 
  \ :call <SID>Cycloplan_Load_Routed_Log_File(1)<CR>
"   2. Thunk the <Plug>
function s:Cycloplan_Load_Routed_Log_File(open_in_quickfix)
  if a:open_in_quickfix == 0
    " The Putzy Way is just to open the flashlog in the current window:
    :edit /ccp/var/log/pyserver/minnesota-routed.log
  else
    "set errorformat=%m
    " C.f. Cycloplan_Load_Pyserver_Dump, but leading crap ok (i.e., timestamp,
    "      logging level, logger name, and octothorphe).
    set errorformat=%A\%.%#File\ \"%f\"\\,\ line\ %l\\,\ in\ %m,%Z%m,%A\%.%#File\ \"%f\"\\,\ line\ %l,%Z%m
    :cgetfile /ccp/var/log/pyserver/minnesota-routed.log
    :QFix!(0)
  endif
endfunction

autocmd BufRead /ccp/var/log/pyserver/minnesota-routed.log set autoread
autocmd BufRead /ccp/var/log/pyserver/minnesota-routed.log normal G
autocmd BufEnter,BufRead /ccp/var/log/pyserver/minnesota-routed.log match none

" Truncate Routed logfile
" ------------------------------------------------------
" CTRL-SHIFT-F11

noremap <C-S-F11> :call <SID>Cycloplan_Routed_Log_Truncate()<CR><CR>
inoremap <C-S-F11> <C-O>:call <SID>Cycloplan_Routed_Log_Truncate()<CR><CR>
" NOTE Using two <CR>s so the output and the message, 
"      _Press ENTER or type command to continue_, are dismissed
map <silent> <unique> <script> 
  \ <Plug>Cycloplan_Routed_Log_Truncate 
  \ :call <SID>Cycloplan_Routed_Log_Truncate()<CR><CR>
"   2. Thunk the <Plug>
function s:Cycloplan_Routed_Log_Truncate()
  !echo > /ccp/var/log/pyserver/minnesota-routed.log
endfunction

" Open the Mr. Do! log file in the Quickfix or current window
" ------------------------------------------------------
" F12s

noremap <F12> :call <SID>Cycloplan_Load_Mr_Do_Log_File(1)<CR>
inoremap <F12> <C-O>:call <SID>Cycloplan_Load_Mr_Do_Log_File(1)<CR>
noremap <C-F12> :call <SID>Cycloplan_Load_Mr_Do_Log_File(0)<CR>
inoremap <C-F12> <C-O>:call <SID>Cycloplan_Load_Mr_Do_Log_File(0)<CR>
map <silent> <unique> <script> 
  \ <Plug>Cycloplan_Load_Mr_Do_Log_File 
  \ :call <SID>Cycloplan_Load_Mr_Do_Log_File(1)<CR>
"   2. Thunk the <Plug>
function s:Cycloplan_Load_Mr_Do_Log_File(open_in_quickfix)
  if a:open_in_quickfix == 0
    " The Putzy Way is just to open the flashlog in the current window:
    :edit /ccp/var/log/pyserver/minnesota-mr_do.log
  else
    "set errorformat=%m
    " C.f. Cycloplan_Load_Pyserver_Dump, but leading crap ok (i.e., timestamp,
    "      logging level, logger name, and octothorphe).
    set errorformat=%A\%.%#File\ \"%f\"\\,\ line\ %l\\,\ in\ %m,%Z%m,%A\%.%#File\ \"%f\"\\,\ line\ %l,%Z%m
    :cgetfile /ccp/var/log/pyserver/minnesota-mr_do.log
    :QFix!(0)
  endif
endfunction

autocmd BufRead /ccp/var/log/pyserver/minnesota-mr_do.log set autoread
autocmd BufRead /ccp/var/log/pyserver/minnesota-mr_do.log normal G
autocmd BufEnter,BufRead /ccp/var/log/pyserver/minnesota-mr_do.log match none

" Truncate Mr_Do logfile
" ------------------------------------------------------
" CTRL-SHIFT-F12

noremap <C-S-F12> :call <SID>Cycloplan_Mr_Do_Log_Truncate()<CR><CR>
inoremap <C-S-F12> <C-O>:call <SID>Cycloplan_Mr_Do_Log_Truncate()<CR><CR>
" NOTE Using two <CR>s so the output and the message, 
"      _Press ENTER or type command to continue_, are dismissed
map <silent> <unique> <script> 
  \ <Plug>Cycloplan_Mr_Do_Log_Truncate 
  \ :call <SID>Cycloplan_Mr_Do_Log_Truncate()<CR><CR>
"   2. Thunk the <Plug>
function s:Cycloplan_Mr_Do_Log_Truncate()
  !echo > /ccp/var/log/pyserver/minnesota-mr_do.log
endfunction

" Truncate All Logfiles
" ------------------------------------------------------
" CTRL-SHIFT-F8

noremap <C-S-F8> :call <SID>Cycloplan_All_Logs_Truncate()<CR><CR>
inoremap <C-S-F8> <C-O>:call <SID>Cycloplan_All_Logs_Truncate()<CR><CR>
" NOTE Using two <CR>s so the output and the message, 
"      _Press ENTER or type command to continue_, are dismissed
map <silent> <unique> <script> 
  \ <Plug>Cycloplan_All_Logs_Truncate 
  \ :call <SID>Cycloplan_All_Logs_Truncate()<CR><CR>
"   2. Thunk the <Plug>
function s:Cycloplan_All_Logs_Truncate()
  " <C-S-F7>
  :call <SID>Cycloplan_Flash_Log_Truncate()
  " <C-S-F9>
  :call <SID>Cycloplan_Misc_Log_Truncate()
  " <C-S-F10>
  :call <SID>Cycloplan_Apache_Log_Truncate()
  " <C-S-F11>
  :call <SID>Cycloplan_Routed_Log_Truncate()
  " <C-S-F12>
  :call <SID>Cycloplan_Mr_Do_Log_Truncate()
endfunction

" ======================================================
" =============================================== EOF ==

