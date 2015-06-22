ui = require "tek.ui"
ui.Application:new
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
}:run()
