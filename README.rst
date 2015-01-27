Dubsacks Vim — Cycloplan IDE
============================

About Cycloplan
---------------

Cycloplan is a geowiki, route finder, and planner analysis tool.

Project page: https://github.com/landonb/cycloplan

Within Vim, try ``:help dubs-cycloplan``.

Cycloplan Developer Commands
----------------------------

==================================  ==================================  ==============================================================================
Key Mapping                         Description                         Notes
==================================  ==================================  ==============================================================================
``<F5>``                            Build Flashclient                   Builds Flashclient. If there are any errors, they'll show up
                                                                        in the Quickfix window and you can easily jump to them.
                                                                        Hint: You cannot edit buffers while flashclient is building,
                                                                        so you'll have to decide what's more important:
                                                                        if you build from Vim, you can easily move the cursor to the error lines,
                                                                        but if you build from a terminal window, you can keep using Vim.
                                                                        Caveat: If you build from the terminal, you'll have to kill fcsh before you can build from Vim.
----------------------------------  ----------------------------------  ------------------------------------------------------------------------------
``<Shift-F5>``                      Flashclient: 'make clean'           Same as ``<F5>`` but does a 'clean' first.
----------------------------------  ----------------------------------  ------------------------------------------------------------------------------
``<Ctrl-F5>``                       Return to Flashclient               If your 'make' has errors and you end up using the Quickfix window for searching
                                    ``make`` output                     and whatnot, you'll probably want to see the 'make' output again. Just hit ``<Ctrl-F5>``
----------------------------------  ----------------------------------  ------------------------------------------------------------------------------
``<F6>``                            Restart Apache                      Restarts the Apache service.
----------------------------------  ----------------------------------  ------------------------------------------------------------------------------
``<Shift-F6>``                      Kill Apache                         I can't remember why I ever needed this command. You probably won't need it.
----------------------------------  ----------------------------------  ------------------------------------------------------------------------------
``<F7>``                            Open Cycloplan
                                    Flashclient Log
----------------------------------  ----------------------------------  ------------------------------------------------------------------------------
``<F9>``                            Open Apache Log
----------------------------------  ----------------------------------  ------------------------------------------------------------------------------
``<F10>``                           Open Cycloplan Misc Log
----------------------------------  ----------------------------------  ------------------------------------------------------------------------------
``<F11>``                           Open Cycloplan Routed Log
----------------------------------  ----------------------------------  ------------------------------------------------------------------------------
``<F12>``                           Open Cycloplan Mr. Do! Log
----------------------------------  ----------------------------------  ------------------------------------------------------------------------------
``<Shift-F7>``                      Open Log File                       Instead of opening the logfile in the Quickfix window,
                                    in New Instance                     opens it in a new instance of gVim.
----------------------------------  ----------------------------------  ------------------------------------------------------------------------------
``<Ctrl-F9/-F10/-F11/-F12>``        Open Log File                       Instead of opening the logfile in the Quickfix window,
                                    in Buffer Window                    opens it in the buffer (editing) window.
----------------------------------  ----------------------------------  ------------------------------------------------------------------------------
``<C-S-F7/-F9/-F10/-F11/-F12>``     Truncate Log File                   Hit Ctrl-Shift-And-One-Of-The-Log-File-F-Keys to truncate the corresponding
                                                                        log file. Hint: During debugging, you're often testing, editing code,
                                                                        testing again, etc. To reduce noise in the log file, truncate the log file between tests.
----------------------------------  ----------------------------------  ------------------------------------------------------------------------------
``<F8>``                            Open Pyserver Dump                  Opens, i.e., /tmp/pyserver\_dumps/dump.EXCEPT, in the Quickfix window.
                                    Exception
----------------------------------  ----------------------------------  ------------------------------------------------------------------------------
``<Ctrl-F8>``                       Open Pyserver Dump                  Opens, i.e., /tmp/pyserver\_dumps/dump.REQUEST, in the Quickfix window.
                                    Request
==================================  ==================================  ==============================================================================

