Simple python script to generate bindings for both VSCode-neovim (to put in the VSCode init.lua), and normal VSCode (via the keybinding JSON)

Currently uses the when clause `(!terminalFocus && !inputFocus) || (!terminalFocus && !inQuickOpen && !renameInputVisible && !inputBoxFocus && (vim.mode == \'Normal\' || vim.mode == \'Visual\'))` but may change this in the future
