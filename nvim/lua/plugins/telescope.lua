return {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        require('telescope').setup{
            defaults = {
                preview = {
                    hide_on_startup = false,
                },
                layout_config = {
                    horizontal = { preview_width = 0.6 },
                    preview_cutoff = 0,
                },
                previewer = true,
            }
        }
    end
}
