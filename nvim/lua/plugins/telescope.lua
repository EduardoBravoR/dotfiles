return {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    -- or                              , branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        require('telescope').setup{
            defaults = {
                preview = {
                    hide_on_startup = false, -- show preview window on startup
                },
                layout_config = {
                    horizontal = { preview_width = 0.6 },
                    preview_cutoff = 0,
                },
                -- You can also set the previewer explicitly:
                previewer = true,
            }
        }
    end
}
