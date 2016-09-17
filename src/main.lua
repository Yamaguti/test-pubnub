

-- ==================
-- = Initialization =
-- ==================

require "lib.Init"

display.setStatusBar(display.HiddenStatusBar)



-- ==============
-- = Connection =
-- ==============

require (_G.pubnubPath .. "pubnub")

local channelID = "chanelIDunno1"

local pubnub_obj = _G.pubnub.new({
    publish_key   = "pub-c-b88bdae5-f108-4fa5-935f-f4859a68ee67",
    subscribe_key = "sub-c-de8f7e5a-9a23-11e5-baf7-02ee2ddab7fe",
    secret_key    = "sec-c-NWM1NjdmM2QtZmFjMy00NTNmLWJlMDAtNTYzNzMzZmJlYzg0",
    ssl           = false,
    origin        = "pubsub.pubnub.com"
})

local _testObject = {
    count = 0,
}

pubnub_obj:subscribe({
    channel = channelID,
    callback = function(message)
        _testObject.count = _testObject.count + 1
        print("message: ", _testObject.count)
        print(message.sender_uuid, message.body)
        if message.sender_uuid ~= pubnub_obj.uuid then
            _testObject.onMessegeReceived(message.body)
        end
    end,
    errorback = function()
        print("ERROR!")
    end,
})

local function sendMessage(text)
    pubnub_obj:publish({
        channel = channelID,
        message = {
            body = text,
            sender_uuid = pubnub_obj.uuid
        }
    })
end



-- ===============
-- = Interaction =
-- ===============

local rect = display.newRoundedRect(centerX, centerY, 190, 80, 10)
rect:setFillColor(135/255, 129/255, 189/255)
rect.strokeWidth = 2
rect:setStrokeColor(1,1,1)

function rect:press()
    self.xScale = 0.85
    self.yScale = 0.85
end


function rect:release()
    self.xScale = 1
    self.yScale = 1
end


local function touchListener(event)
    local phase = event.phase

    if phase == "began" then
        display:getCurrentStage():setFocus(rect)
        rect:press()
        sendMessage("began")

    elseif phase == "ended" then
        display:getCurrentStage():setFocus(nil)
        rect:release()
        sendMessage("ended")
    end
end


function _testObject.onMessegeReceived(messageContents)
    if messageContents == "began" then
        rect:removeEventListener("touch", touchListener)
        rect:press()

    elseif messageContents == "ended" then
        rect:addEventListener("touch", touchListener)
        rect:release()

    end
end


rect:addEventListener("touch", touchListener)
