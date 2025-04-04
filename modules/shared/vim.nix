{
  programs.nixvim = {
    config = {
      enable = true;
      defaultEditor = true;
      colorschemes.gruvbox.enable = true;
      globals.mapleader = " ";
      opts = {
        spell = true;
        spelllang = [ "en_gb" "sv" ];
      };

      autoCmd = [
        {
          event = "BufWritePre";
          command = "lua vim.lsp.buf.format()";
        }
      ];

      keymaps = [
        # Disable arrow keys
        {
          key = "<Up>";
          action = "<Nop>";
          options = {
            desc = "Disable up arrow key";
          };
        }
        {
          key = "<Down>";
          action = "<Nop>";
          options = {
            desc = "Disable down arrow key";
          };
        }
        {
          key = "<Left>";
          action = "<Nop>";
          options = {
            desc = "Disable left arrow key";
          };
        }
        {
          key = "<Right>";
          action = "<Nop>";
          options = {
            desc = "Disable right arrow key";
          };
        }

        # Disable arrow keys in insert mode
        {
          mode = "i";
          key = "<Up>";
          action = "<Nop>";
          options = {
            desc = "Disable up arrow key in insert mode";
          };
        }
        {
          mode = "i";
          key = "<Down>";
          action = "<Nop>";
          options = {
            desc = "Disable down arrow key in insert mode";
          };
        }
        {
          mode = "i";
          key = "<Left>";
          action = "<Nop>";
          options = {
            desc = "Disable left arrow key in insert mode";
          };
        }
        {
          mode = "i";
          key = "<Right>";
          action = "<Nop>";
          options = {
            desc = "Disable right arrow key in insert mode";
          };
        }

        # HOP

        {
          key = "f";
          action.__raw = "function() require('hop').hint_char1({ direction = require('hop.hint').HintDirection.AFTER_CURSOR }) end";
          options = {
            remap = true;
            desc = "Hop after cursor";
          };
        }
        {
          key = "F";
          action.__raw = "function() require('hop').hint_char1({ direction = require('hop.hint').HintDirection.BEFORE_CURSOR }) end";
          options = {
            remap = true;
            desc = "Hop after cursor";
          };
        }

        #TELESCOPE

        {
          action = "<cmd>Telescope live_grep<CR>";
          key = "<leader>fw";
          options = { desc = "Live Grep"; };
        }
        {
          action = "<cmd>Telescope find_files<CR>";
          key = "<leader>ff";
          options = { desc = "Find files"; };
        }
        {
          action = "<cmd>Telescope git_commits<CR>";
          key = "<leader>fg";
          options = { desc = "Browse git commits"; };
        }
        {
          action = "<cmd>Telescope oldfiles<CR>";
          key = "<leader>fh";
          options = { desc = "Browse accessed files"; };
        }
        {
          action = "<cmd>Telescope colorscheme<CR>";
          key = "<leader>ch";
          options = { desc = "Change colorscheme"; };
        }

        {
          action = "<cmd>Telescope man_pages<CR>";
          key = "<leader>fm";
        }
        {
          action = "<cmd>Telescope lsp_definitions<CR>";
          key = "gd";
          options = { desc = "Jump to definition"; };
        }
        {
          mode = [ "i" "x" "n" "s" ];
          key = "<C-s>";
          action = "<cmd>w<cr><esc>";
          options = { desc = "Save File"; };
        }

        #NONE-LS

        {
          key = "<leader>dl";
          action.__raw = ''
            function()
              vim.diagnostic.open_float({ scope = "line" })
            end
          '';
          options = {
            desc = "View current line diagnostics";
            silent = true;
          };
        }

        # CMP

        {
          mode = "i";
          key = "<C-Space>";
          action.__raw = ''
            function()
              local cmp = require('cmp')
              if not cmp.visible() then
                return cmp.complete()
              end
            end
          '';
          options = {
            silent = true;
            desc = "Trigger suggestions";
          };
        }

        {
          mode = "i";
          key = "<C-y>";
          action = "<Cmd>lua require('cmp').confirm({ select = true })<CR>";
          options = {
            silent = true;
          };
        }
        {
          mode = "i";
          key = "<C-j>";
          action.__raw = ''
            function()
              local cmp = require('cmp')
              if cmp.visible() then
                return cmp.mapping.select_next_item()()
              end
            end
          '';
          options.silent = true;
        }
        {
          mode = "i";
          key = "<C-k>";
          action.__raw = ''
            function()
              local cmp = require('cmp')
              if cmp.visible() then
                return cmp.mapping.select_prev_item()()
              end
            end
          '';
          options.silent = true;
        }
        {
          mode = "i";
          key = "<C-e>";
          action.__raw = ''
                function()
                  local cmp = require('cmp')
                  if cmp.visible() then
                    return cmp.mapping.abort()()
                  end
            end
          '';
          options = {
            silent = true;
            desc = "Cancel completion";
          };
        }
      ];

      plugins = {
        web-devicons = {
          enable = true;
        };

        which-key = {
          enable = true;
        };

        friendly-snippets = {
          enable = true;
        };

        luasnip.enable = true;

        cmp = {
          enable = true;
          autoEnableSources = true;
          settings = {
            snippet = {
              expand = ''                function(args)
                            require('luasnip').lsp_expand(args.body)
                          end'';
            };
            sources = [
              { name = "luasnip"; }
              { name = "nvim_lsp"; }
              { name = "path"; }
              { name = "buffer"; }
            ];
          };
        };

        hop = {
          enable = true;
        };

        none-ls = {
          enable = true;
          sources = {
            code_actions = {
              statix.enable = true;
              gitsigns.enable = true;
            };
            diagnostics = {
              statix.enable = true;
              deadnix.enable = true;
              pylint.enable = true;
              checkstyle.enable = true;
              codespell.enable = true;
            };
            formatting = {
              alejandra.enable = true;
              stylua.enable = true;
              shfmt.enable = true;
              nixpkgs_fmt.enable = true;
              google_java_format.enable = false;
              prettier = {
                enable = true;
                disableTsServerFormatter = true;
              };
            };
            completion = {
              luasnip.enable = true;
              spell.enable = true;
            };
          };
        };

        nix = {
          enable = true;
        };

        neoscroll = {
          enable = true;
          settings = {
            mappings = [
              "<C-u>"
              "<C-d>"
              "<C-b>"
              "<C-f>"
              "<C-y>"
              "<C-e>"
            ];
          };
        };

        presence-nvim = {
          enable = true;
        };

        # Language server
        lsp = {
          enable = true;
          servers = {
            ts_ls.enable = true; # TS/JS
            cssls.enable = true; # CSS
            tailwindcss.enable = true; # TailwindCSS
            html.enable = true; # HTML
            pyright.enable = true; # Python
            marksman.enable = true; # Markdown
            nil_ls.enable = true; # Nix
            dockerls.enable = true; # Docker
            bashls.enable = true; # Bash
            clangd.enable = true; # C/C++
            csharp_ls.enable = true; # C#
            yamlls.enable = true; # YAML

            lua_ls = {
              # Lua
              enable = true;
              settings.telemetry.enable = false;
            };

            # Rust
            rust_analyzer = {
              enable = true;
              installRustc = true;
              installCargo = true;
              settings = {
                procMacro = {
                  enable = true;
                };
                diagnostics.enabled = true;
                inlayHints.enable = true;
                checkOnSave = true;
                command = "clippy";
              };
            };
          };
        };

        telescope = {
          enable = true;
        };

        lsp-lines = {
          enable = true;
        };

        lualine = {
          enable = true;
        };

        startify = {
          enable = true;
        };
      };
    };
  };
}
