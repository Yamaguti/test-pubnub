

-- ==================
-- = Initialization =
-- ==================

require "lib.Init"

display.setStatusBar(display.HiddenStatusBar)



-- ===========
-- = Content =
-- ===========

local rect1 = display.newRect(screenLeft, centerY, 10, 10)

local t = transition.to(rect1, {
    time = 2000,
    x    = screenRight,
})
