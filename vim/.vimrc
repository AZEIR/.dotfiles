" -----------------------------------------------------------------------------
" 1. Clipboard Integration (Copy/Paste with System Clipboard)
" -----------------------------------------------------------------------------
" This lets you use y to copy to system clipboard and p to paste from it
set clipboard=unnamedplus

" -----------------------------------------------------------------------------
" 2. Essential Behaviors
" -----------------------------------------------------------------------------
set nocompatible  " Break compatibility with old vi (crucial for Kali)
set number        " Show line numbers
set relativenumber" Hybrid line numbers (great for jumping lines quickly)
set mouse=a       " Enable mouse support for scrolling/selecting text

" -----------------------------------------------------------------------------
" 3. Searching
" -----------------------------------------------------------------------------
set hlsearch      " Highlight search results
set incsearch     " Show matches as you type
set ignorecase    " Ignore case when searching...
set smartcase     " ...unless the search query contains capital letters

" -----------------------------------------------------------------------------
" 4. Indentation (Tabs vs Spaces)
" -----------------------------------------------------------------------------
set expandtab     " Transform tabs into spaces
set tabstop=4     " Number of visual spaces per tab
set shiftwidth=4  " Number of spaces for auto-indentation
set smartindent   " Automatically indent new lines smartly

" -----------------------------------------------------------------------------
" 5. Visual Polish
" -----------------------------------------------------------------------------
syntax on         " Enable syntax highlighting
