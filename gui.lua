local gui = {}

ui = require "tek.ui"
gui.main_window = ui.Application:new
{
  Children =
  {
    ui.Window:new
    {
      Title = "Hello",
      Children =
      {
        ui.Text:new
        {
          Text = "Hello, World!",
          Class = "button",
          Mode = "button",
          Width = "auto"
        }
      }
    }
  }
}


return gui
