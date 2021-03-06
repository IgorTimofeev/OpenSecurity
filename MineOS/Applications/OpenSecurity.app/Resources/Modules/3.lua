
local args = {...}
local mainContainer, window = args[1], args[2]

require("advancedLua")
local GUI = require("GUI")
local buffer = require("doubleBuffering")
local MineOSInterface = require("MineOSInterface")
local component = require("component")
local redstone = component.redstone
local event = require("event")
local FBAPI = require("FBAPI")
----------------------------------------------------------------------------------------------------------------

local module = {}
module.name = "Mag Reader"

----------------------------------------------------------------------------------------------------------------

module.onTouch = function()
window.contentContainer:deleteChildren()
local component = require("component")
    if component.isAvailable("OSMAGReader") then
      magcheck = true
    elseif component.isAvailable("os_magreader") then
      magcheck = true
    else
      magcheck = false
    end

    if magcheck == true then
      checkresult = true
	  magcheck = nil
    elseif magcheck == false then
	  magcheck = nil
      checkresult = false
    end
if checkresult == true then
FBAPI.clearGlobal()
  local container = window.contentContainer:addChild(GUI.container(1, 1, window.contentContainer.width, window.contentContainer.height))

  local layout = container:addChild(GUI.layout(1, 1, container.width, window.contentContainer.height, 3, 1))
  layout:setCellPosition(2, 1, layout:addChild(GUI.input(1, 1, 30, 3, 0xFFFFFF, 0x444444, 0xAAAAAA, 0xFFFFFF, 0x2D2D2D, "", "Пароль для карточки"))).onInputFinished = function(mainContainer, input, eventData, text)
  password = text
end

layout:setCellPosition(2, 1, layout:addChild(GUI.input(1, 1, 30, 3, 0xFFFFFF, 0x444444, 0xAAAAAA, 0xFFFFFF, 0x2D2D2D, "", "(Sec) Действия редстоуна"))).onInputFinished = function(mainContainer, input, eventData, text)
red = tonumber(text)
end

layout:setCellPosition(2, 1, layout:addChild(GUI.input(1, 1, 30, 3, 0xFFFFFF, 0x444444, 0xAAAAAA, 0xFFFFFF, 0x2D2D2D, "", "Сторона вывода редстоуна"))).onInputFinished = function(mainContainer, input, eventData, text)
side = tonumber(text)
end
layout:setCellPosition(2, 1, layout:addChild(GUI.roundedButton(2, 6, 30, 3, 0xBBBBBB, 0xFFFFFF, 0x999999, 0xFFFFFF, "Включить MagReader"))).onTouch = function()
FBAPI.magread(password, side, red)
FBAPI.clearGlobal()
end

layout:setCellPosition(2, 1, layout:addChild(GUI.label(30, 1, 30, 3, 0x00, "Enter для выключения программы.")))
elseif checkresult == false then
FBAPI.clearGlobal()
GUI.error("Вы не подключили MagReader.")
end
end

----------------------------------------------------------------------------------------------------------------

return module