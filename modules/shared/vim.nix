{ pkgs, ... }:
{
  programs.nixvim = {
    config = {
      enable = true;
      defaultEditor = true;
      colorschemes.gruvbox.enable = true;
      globals.mapleader = " ";
      opts = {
        number = true;
        spell = true;
        spelllang = [ "en_gb" "sv" ];
        clipboard = "unnamedplus"; # Enable system clipboard integration
      };

      autoCmd = [
        {
          event = "BufWritePre";
          command = "lua vim.lsp.buf.format()";
        }
      ];

      # Add DAP configuration via extraConfigLua
      extraConfigLua = ''
        local dap = require('dap')
        
        -- Node.js adapter configuration
        dap.adapters.node = {
          type = 'executable',
          command = 'node',
          args = {'${pkgs.vscode-js-debug}/lib/node_modules/js-debug/dist/src/dapDebugServer.js'},
        }
        
        -- JavaScript configurations
        dap.configurations.javascript = {
          {
            type = 'node',
            request = 'attach',
            name = 'Attach to Node.js',
            port = 9229,
            host = '127.0.0.1',
            localRoot = vim.fn.getcwd(),
            remoteRoot = vim.fn.getcwd(),
            skipFiles = { '<node_internals>/**' },
          },
          {
            type = 'node',
            request = 'launch',
            name = 'Launch Node.js',
            program = '$${file}',
            cwd = vim.fn.getcwd(),
            skipFiles = { '<node_internals>/**' },
          },
        }
        
        -- TypeScript configurations
        dap.configurations.typescript = {
          {
            type = 'node',
            request = 'attach',
            name = 'Attach to Node.js',
            port = 9229,
            host = '127.0.0.1',
            localRoot = vim.fn.getcwd(),
            remoteRoot = vim.fn.getcwd(),
            skipFiles = { '<node_internals>/**' },
          },
          {
            type = 'node',
            request = 'launch',
            name = 'Launch Node.js (ts-node)',
            program = '$${file}',
            cwd = vim.fn.getcwd(),
            runtimeExecutable = 'npx',
            runtimeArgs = { 'ts-node' },
            skipFiles = { '<node_internals>/**' },
          },
        }
      '';

      keymaps = [
        # Visual mode ctrl+shift+c to copy to clipboard
        {
          mode = "v";
          key = "<C-S-c>";
          action = "\"+y";
          options = {
            desc = "Copy selection to system clipboard";
          };
        }

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

        # YAZI
        {
          key = "<leader>fy";
          action = "<cmd>Yazi<CR>";
          options = {
            desc = "Open Yazi file manager";
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

        # DAP keybindings under 'd' prefix (d for debug)
        {
          key = "<leader>dc";
          action.__raw = "function() require('dap').continue() end";
          options = {
            desc = "Debug: Continue";
          };
        }
        {
          key = "<leader>ds";
          action.__raw = "function() require('dap').step_over() end";
          options = {
            desc = "Debug: Step Over";
          };
        }
        {
          key = "<leader>di";
          action.__raw = "function() require('dap').step_into() end";
          options = {
            desc = "Debug: Step Into";
          };
        }
        {
          key = "<leader>do";
          action.__raw = "function() require('dap').step_out() end";
          options = {
            desc = "Debug: Step Out";
          };
        }
        {
          key = "<leader>db";
          action.__raw = "function() require('dap').toggle_breakpoint() end";
          options = {
            desc = "Debug: Toggle Breakpoint";
          };
        }
        {
          key = "<leader>dr";
          action.__raw = "function() require('dap').restart() end";
          options = {
            desc = "Debug: Restart";
          };
        }
        {
          key = "<leader>dt";
          action.__raw = "function() require('dap').terminate() end";
          options = {
            desc = "Debug: Terminate";
          };
        }
        {
          key = "<leader>du";
          action.__raw = "function() require('dapui').toggle() end";
          options = {
            desc = "Debug: Toggle UI";
          };
        }
        {
          key = "<leader>da";
          action.__raw = ''
            function()
              local dap = require('dap')
              local configs = dap.configurations[vim.bo.filetype]
              if not configs then
                vim.notify("No DAP configuration found for " .. vim.bo.filetype, vim.log.levels.ERROR)
                return
              end
              
              -- Find attach configuration
              local attach_config = nil
              for _, config in ipairs(configs) do
                if config.request == "attach" then
                  attach_config = config
                  break
                end
              end
              
              if attach_config then
                dap.run(attach_config)
              else
                vim.notify("No attach configuration found for " .. vim.bo.filetype, vim.log.levels.ERROR)
              end
            end
          '';
          options = {
            desc = "Debug: Attach to existing session";
          };
        }
        {
          key = "<leader>dl";
          action.__raw = ''
            function()
              local dap = require('dap')
              local configs = dap.configurations[vim.bo.filetype]
              if not configs then
                vim.notify("No DAP configuration found for " .. vim.bo.filetype, vim.log.levels.ERROR)
                return
              end
              
              -- Find launch configuration
              local launch_config = nil
              for _, config in ipairs(configs) do
                if config.request == "launch" then
                  launch_config = config
                  break
                end
              end
              
              if launch_config then
                dap.run(launch_config)
              else
                vim.notify("No launch configuration found for " .. vim.bo.filetype, vim.log.levels.ERROR)
              end
            end
          '';
          options = {
            desc = "Debug: Launch new session";
          };
        }
      ];

      plugins = {
        gitblame = {
          enable = true;
          settings = {
            currentLineBlame = true;
            currentLineBlameFormatter = ''
              function(blame)
                return blame
              end'';
            currentLineBlameDelay = 1000;
            currentLineBlamePriority = 10;
          };
        };

        treesitter = {
          enable = true;
          settings = {
            ensure_installed = [
              "bash"
              "c"
              "cpp"
              "css"
              "dockerfile"
              "go"
              "html"
              "javascript"
              "json"
              "lua"
              "markdown"
              "markdown_inline"
              "python"
              "typescript"
              "yaml"
            ];
          };
        };

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
              {
                name = "luasnip";
                priority = 500;
              }

              {
                name = "nvim_lsp";
                priority = 750;
              }
              {
                name = "path";
              }
              { name = "buffer"; }
              {
                name = "copilot";
                priority = 1000;
              }
            ];
          };
        };

        hop = {
          enable = true;
        };

        # Yazi file manager plugin
        yazi = {
          enable = true;
        };

        copilot-lua = {
          enable = true;
        };

        copilot-cmp = {
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
            ts_ls = {
              enable = true; # You already have this
              settings = {
                javascript = {
                  suggest = {
                    completeFunctionCalls = true;
                    includeCompletionsWithSnippetText = true;
                  };
                  format = {
                    enable = true;
                  };
                };
                typescript = {
                  # Same settings as JavaScript
                  suggest = {
                    completeFunctionCalls = true;
                    includeCompletionsWithSnippetText = true;
                  };
                  format = {
                    enable = true;
                  };
                };
              };
            };
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

        # DAP (Debug Adapter Protocol) configuration
        dap = {
          enable = true;
        };
        
        dap-ui.enable = true;
        dap-virtual-text.enable = true;
      };
    };
  };
}
