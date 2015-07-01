local gui = {}
local ui = require "tek.ui"
local utils = require "pl.utils"

local trans_table = {}

gui.main_window = ui.Application:new
{
  Children =
  {
    ui.Window:new
    {
      Title = "Hello",
      Children =
      {
        ui.Button:new
        {
          Text = "Hello, World!",
          Width = "auto",
          onClick = function(self)
            print "Hello, World!"
            utils.quit("Exiting...")
          end
        }
      }
    }
  }
}

return gui
