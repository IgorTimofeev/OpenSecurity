
local args = {...}
local mainContainer, window = args[1], args[2]
require("advancedLua")
local component = require("component")
local GUI = require("GUI")
local buffer = require("doubleBuffering")
local MineOSInterface = require("MineOSInterface")
local redstone = component.redstone
local event = require("event")

----------------------------------------------------------------------------------------------------------------

local module = {}
module.name = "Card Writer"
local function checkPidor()


    if component.isAvailable("os_cardwriter") then
     writer = component.os_cardwriter
     writercheck = "zaebis"
    elseif component.isAvailable("OSCardWriter") then
     writer = component.OSCardWriter
     writercheck = "zaebis"
    else
     writercheck = "nezaebis"
    end

    if writercheck == "zaebis" then
     check = "zaebis"
    elseif writercheck == "nezaebis" then
     check = "pizdec"
    end

end



----------------------------------------------------------------------------------------------------------------

module.onTouch = function()
window.contentContainer:deleteChildren()
checkPidor()
if check == "zaebis" then

  local container = window.contentContainer:addChild(GUI.container(1, 1, window.contentContainer.width, window.contentContainer.height))
  local layout = container:addChild(GUI.layout(1, 1, container.width, window.contentContainer.height, 3, 1))
  layout:setCellPosition(2, 1, layout:addChild(GUI.input(1, 1, 30, 3, 0xFFFFFF, 0x444444, 0xAAAAAA, 0xFFFFFF, 0x2D2D2D, "", "Название карточки"))).onInputFinished = function(mainContainer, input, eventData, text)
  local login = text
end

layout:setCellPosition(2, 1, layout:addChild(GUI.input(1, 1, 30, 3, 0xFFFFFF, 0x444444, 0xAAAAAA, 0xFFFFFF, 0x2D2D2D, "", "Пароль для карточки"))).onInputFinished = function(mainContainer, input, eventData, text)
local password = text
end

local comboBox = layout:setCellPosition(2, 1, layout:addChild(GUI.comboBox(1, 1, 30, 3, 0xFFFFFF, 0x444444, 0xCCCCCC, 0x888888)))
comboBox:addItem("Заблокировать перезапись").onTouch = function()
local lock = "true"
end
comboBox:addItem("Не блокировать перезапись").onTouch = function()
local lock = "false"
end

layout:setCellPosition(2, 1, layout:addChild(GUI.roundedButton(2, 6, 30, 3, 0xBBBBBB, 0xFFFFFF, 0x999999, 0xFFFFFF, "Записать"))).onTouch = function()
if login and password then
if lock == "true" then
success = writer.write(password, login, true)
elseif lock == "false" then
success = writer.write(password, login, false)
else
success = writer.write(password, login, false)
end
end
if success then
GUI.error("Успешно!")
else
GUI.error("Вы не вставили карту или(и) не ввели данные.")
end
end
elseif check == "pizdec" then
GUI.error("Вы не подключили Card Writer.")
end
end

----------------------------------------------------------------------------------------------------------------

return module