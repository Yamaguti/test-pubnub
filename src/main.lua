

-- ==================
-- = Initialization =
-- ==================

require "lib.Init"

display.setStatusBar(display.HiddenStatusBar)



-- ===========
-- = Content =
-- ===========



require (_G.pubnubPath .. "pubnub")

local channelID = "chanelIDunno1"

local pubnub_obj = _G.pubnub.new({
    publish_key   = "pub-c-b88bdae5-f108-4fa5-935f-f4859a68ee67",
    subscribe_key = "sub-c-de8f7e5a-9a23-11e5-baf7-02ee2ddab7fe",
    secret_key    = "sec-c-NWM1NjdmM2QtZmFjMy00NTNmLWJlMDAtNTYzNzMzZmJlYzg0",
    ssl           = false,
    origin        = "pubsub.pubnub.com"
})

local a = {}
a.count = 0

pubnub_obj:subscribe({
    channel = channelID,
    callback = function(message)
        a.count = a.count + 1
        print(message.msgtext, a.count)
    end,
    errorback = function()
        print("ERROR!")
    end,
})

local function sendMessage(text)
    pubnub_obj:publish({
        channel = channelID,
        message = {msgtext = text}
    })
end


timer.performWithDelay(1000, function()
    sendMessage("Hello World!")
end)



-- local rect = display.newRoundedRect(centerX, centerY, 100, 50, 10)
-- rect:setFillColor(135/255, 129/255, 189/255)
-- rect.strokeWidth = 3
-- rect:setStrokeColor(1,1,1)
