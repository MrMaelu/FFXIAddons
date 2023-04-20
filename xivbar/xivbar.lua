--[[
        Copyright © 2017, SirEdeonX
        All rights reserved.

        Redistribution and use in source and binary forms, with or without
        modification, are permitted provided that the following conditions are met:

            * Redistributions of source code must retain the above copyright
              notice, this list of conditions and the following disclaimer.
            * Redistributions in binary form must reproduce the above copyright
              notice, this list of conditions and the following disclaimer in the
              documentation and/or other materials provided with the distribution.
            * Neither the name of xivbar nor the
              names of its contributors may be used to endorse or promote products
              derived from this software without specific prior written permission.

        THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
        ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
        WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
        DISCLAIMED. IN NO EVENT SHALL SirEdeonX BE LIABLE FOR ANY
        DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
        (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
        LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
        ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
        (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
        SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
]]

-- This addon has been heavily modified by MrMaelu and is no longer considered compatible with the original addon.

-- Addon description
_addon.name = 'XIV Bar'
_addon.author = 'Edeon (modded by MrMaelu)'
_addon.version = '2.1.0'
_addon.language = 'english'
_addon.commands = {'xivbar', 'xb'}

-- Libs
config = require('config')
texts  = require('texts')
images = require('images')
res = require('resources')
file = require('files')

-- User settings
local defaults = require('defaults')
local settings = config.load(defaults)
config.save(settings)

-- Load theme options according to settings
local theme = require('theme')
local theme_options = theme.apply(settings)

-- Addon Dependencies
local ui = require('ui')
local player = require('player')
local xivbar = require('variables')

-- Import variables
local scalefactor = settings.Theme.scale
local width = theme_options.total_width*scalefactor
local height = theme_options.total_height*scalefactor

local hp_bar_width = theme_options.hp_bar_width
local hp_bar_height = theme_options.hp_bar_height

local mp_bar_width = theme_options.mp_bar_width
local mp_bar_height = theme_options.mp_bar_height

local tp_bar1_width = theme_options.tp_bar1_width
local tp_bar2_width = theme_options.tp_bar2_width
local tp_bar3_width = theme_options.tp_bar3_width
local tp_bar_height = theme_options.tp_bar_height

local deathmessage = theme_options.deathmessage

-- vars
local themefolder = windower.addon_path .. "themes/"
local settingsfolder = windower.addon_path .. "data/"
local resourcefolder = windower.addon_path .. "data/ThemeSelectorResources/"

-- initialize addon
function initialize()
    ui:load(theme_options)

    local windower_player = windower.ffxi.get_player()

    if windower_player ~= nil then
        player.hpp = windower_player.vitals.hpp
        player.mpp = windower_player.vitals.mpp
        player.current_hp = windower_player.vitals.hp
        player.current_mp = windower_player.vitals.mp
        player.current_tp = windower_player.vitals.tp
		player.job = windower.ffxi.get_player().main_job_id
        player:calculate_tpp()
    end
	scale(settings.Theme.scale)
    xivbar.initialized = true
end

-- update a bar
function update_bar(bar, text, width, current, pp, flag)
    local old_width = width

	if flag == 1 then
		new_width = math.floor((pp / 100) * hp_bar_width)
	elseif flag == 2 then
		new_width = math.floor((pp / 100) * mp_bar_width)
	elseif flag == 3 then
		new_width = math.floor((pp / 100) * tp_bar1_width)
	elseif flag == 4 then
		new_width = math.floor((pp / 100) * tp_bar2_width)
	elseif flag == 5 then
		new_width = math.floor((pp / 100) * tp_bar3_width)
	end

	if new_width ~= nil then
		local x = old_width
        if old_width < new_width then
            x = old_width + math.ceil((new_width - old_width) * 0.1)
			if flag == 1 then
            x = math.min(x, hp_bar_width)
			elseif flag == 2 then
			x = math.min(x, mp_bar_width)
			elseif flag >= 3 then
			x = math.min(x, tp_bar1_width)
			end
        elseif old_width > new_width then
            x = old_width - math.ceil((old_width - new_width) * 0.1)
            x = math.max(x, 0)
        end
        if flag == 1 then
            xivbar.hp_bar_width = x
			bar:size(x, hp_bar_height)
			if x == hp_bar_width then
				bar:alpha(theme_options.bar_alphaMax)
			else
				bar:alpha(theme_options.bar_alphaMin)
			end
			bar:show()
        elseif flag == 2 then
            xivbar.mp_bar_width = x
			bar:size(x, mp_bar_height)
			if x == mp_bar_width then
				bar:alpha(theme_options.bar_alphaMax)
			else
				bar:alpha(theme_options.bar_alphaMin)
			end
			bar:show()
        elseif (flag == 5 and current >=2000) then
			xivbar.tp_bar1_width = tp_bar1_width
			xivbar.tp_bar2_width = tp_bar2_width
			xivbar.tp_bar3_width = x
			ui.tp_bar1:size(tp_bar1_width, tp_bar_height)
			ui.tp_bar2:size(tp_bar2_width, tp_bar_height)
			ui.tp_bar3:size(x, tp_bar_height)
			ui.tp_bar1:show()
			ui.tp_bar2:show()
			ui.tp_bar3:show()				
		elseif (flag == 4 and current >=1000) then
			xivbar.tp_bar1_width = tp_bar1_width
			xivbar.tp_bar2_width = x
			xivbar.tp_bar3_width = 0
			ui.tp_bar1:size(tp_bar1_width, tp_bar_height)
			ui.tp_bar2:size(x, tp_bar_height)
			ui.tp_bar3:size(0, tp_bar_height)
			ui.tp_bar1:show()
			ui.tp_bar2:show()
			ui.tp_bar3:show()
		elseif (flag == 3 and current < 1000) then
			xivbar.tp_bar1_width = x
			xivbar.tp_bar2_width = 0
			xivbar.tp_bar3_width = 0
			ui.tp_bar1:size(x, tp_bar_height)
			ui.tp_bar2:size(0, tp_bar_height)
			ui.tp_bar3:size(0, tp_bar_height)
			ui.tp_bar1:show()
			ui.tp_bar2:show()
			ui.tp_bar3:show()
		end
	end

    if flag >= 3 and current >= 1000 then
        text:color(theme_options.full_tp_color_red, theme_options.full_tp_color_green, theme_options.full_tp_color_blue)
        if theme_options.dim_tp_bar then ui.tp_bar1:alpha(theme_options.bar_alphaMax) end
    else
        text:color(theme_options.font_color_red, theme_options.font_color_green, theme_options.font_color_blue)
        if theme_options.dim_tp_bar then ui.tp_bar1:alpha(theme_options.bar_alphaMin) end
    end
	
	if flag >= 3 and current >= 2000 then
		if theme_options.dim_tp_bar then ui.tp_bar2:alpha(theme_options.bar_alphaMax) end
	else
		if theme_options.dim_tp_bar then ui.tp_bar2:alpha(theme_options.bar_alphaMin) end
	end
	
	if flag >= 3 and current >= 3000 then
		if theme_options.dim_tp_bar then ui.tp_bar3:alpha(theme_options.bar_alphaMax) end
	else
		if theme_options.dim_tp_bar then ui.tp_bar3:alpha(theme_options.bar_alphaMin) end
	end

if theme_options.numberprefix == true then
	if flag >= 3 then
		prefix = 'TP '
	elseif flag == 2 then
		prefix = 'MP '
	elseif flag == 1 then
		prefix = 'HP '
	end
else
	prefix = ''
end

text:text(prefix .. tostring(current))

end

-- Updates the job icon.
function update_job(job)
	xivbar.update_job = false
	ui:hide()
	theme_options.bar_jobicon = windower.addon_path .. 'themes/' .. settings.Theme.Name .. '/' .. job .. '.png'
	initialize()
	ui:show()
end

-- hide the addon
function hide()
    ui:hide()
    xivbar.ready = false
end

-- show the addon
function show()
    if xivbar.initialized == false then
        initialize()
    end
    ui:show()
    xivbar.ready = true
	xivbar.update_job = true
	update_weapon()
end

-- Bind Events
-- ON LOAD
windower.register_event('load', function()
    if windower.ffxi.get_info().logged_in then
        show()
		local equip = windower.ffxi.get_items('equipment')
        info.main_weapon = equip.main
        info.main_bag = equip.main_bag
        info.range = equip.range
        info.range_bag = equip.range_bag
        update_weapon()
    end
end)

-- ON LOGIN
windower.register_event('login', function()
    theme_options = theme.apply(settings)
	show()
end)

-- ON LOGOUT
windower.register_event('logout', function()
	coroutine.close(check_weapon)
    hide()
end)

-- ON UNLOAD
windower.register_event('unload', function()
	coroutine.close(check_weapon)
    hide()
end)

-- BIND EVENTS
windower.register_event('hp change', function(new, old)
    player.current_hp = new
end)

windower.register_event('hpp change', function(new, old)
    player.hpp = new
end)

windower.register_event('mp change', function(new, old)
    player.current_mp = new
end)

windower.register_event('mpp change', function(new, old)
    player.mpp = new
end)

windower.register_event('tp change', function(new, old)
    player.current_tp = new
    player:calculate_tpp()
end)

windower.register_event('job change', function(new)
	player.job = new
	xivbar.update_job = true
end)

windower.register_event('prerender', function()
    if xivbar.ready == false then
        return
    end
        update_bar(ui.hp_bar, ui.hp_text, xivbar.hp_bar_width, player.current_hp, player.hpp, 1)
        update_bar(ui.mp_bar, ui.mp_text, xivbar.mp_bar_width, player.current_mp, player.mpp, 2)
		if player.current_tp <= 1000 then update_bar(ui.tp_bar1, ui.tp_text, xivbar.tp_bar1_width, player.current_tp, player.tpp1, 3) end
		if player.current_tp <= 2000 then update_bar(ui.tp_bar2, ui.tp_text, xivbar.tp_bar2_width, player.current_tp, player.tpp2, 4) end
		if player.current_tp <= 3000 then update_bar(ui.tp_bar3, ui.tp_text, xivbar.tp_bar3_width, player.current_tp, player.tpp3, 5) end

	if xivbar.update_job then
		update_job(player.job)
	end
end)

windower.register_event('status change', function(new_status_id)
    if xivbar.hide_bars == false and (new_status_id == 4) then
        xivbar.hide_bars = true
        hide()
    elseif xivbar.hide_bars and new_status_id ~= 4 then
        xivbar.hide_bars = false
        show()
	end
end)

-- weapon check

info = {}
local weapon = 0
local equip = windower.ffxi.get_items('equipment')
info.main_weapon = equip.main
info.main_bag = equip.main_bag

windower.register_event('incoming chunk', function(id, data)
	if id == 0x50 and data:byte(6) == 0 then
        info.main_weapon = data:byte(5)
        info.main_bag = data:byte(7)
        update_weapon()
	end
end)

function update_weapon()
    local main_weapon = windower.ffxi.get_items(info.main_bag, info.main_weapon).id

	if main_weapon ~= 0 then
		skill = res.items[main_weapon].skill
		if skill == nil then
			theme_options.bar_weaponicon = windower.addon_path .. 'data/defaults/0.png'
		else
			theme_options.bar_weaponicon = windower.addon_path .. 'themes/' .. settings.Theme.Name .. '/' .. skill .. 'w.png'
		end
		initialize()
		ui:show()
	elseif not check_weapon or coroutine.status(check_weapon) ~= 'suspended' then
        check_weapon = coroutine.schedule(update_weapon, 10)
    end
end

function copy(old_path, new_path)
  local old_file = io.open(old_path, "rb")
  local new_file = io.open(new_path, "wb")
  local old_file_sz, new_file_sz = 0, 0
  if not old_file or not new_file then
    return false
  end
  while true do
    local block = old_file:read(2^13)
    if not block then 
      old_file_sz = old_file:seek( "end" )
      break
    end
    new_file:write(block)
  end
  old_file:close()
  new_file_sz = new_file:seek( "end" )
  new_file:close()
  return new_file_sz == old_file_sz
end

function scale(percent)
	factor = percent/100
	width = math.floor(settings.Theme.width * factor)
	height = math.floor(settings.Theme.height * factor)

	local x = windower.get_windower_settings().x_res / 2 - (width / 2) + theme_options.offset_x
	local y = windower.get_windower_settings().y_res + theme_options.offset_y

	ui.background:size(width, height)
	ui.foreground:size(width, height)
	ui.hp_shade:size(width, height)
	ui.background:pos(x,y)
	ui.foreground:pos(x,y)
	ui.hp_shade:pos(x,y)

	jisx = math.floor(settings.Theme.jisx * factor)
	jisy = math.floor(settings.Theme.jisy * factor)
	wisx = math.floor(settings.Theme.wisx * factor)
	wisy = math.floor(settings.Theme.wisy * factor)

	ui.jobicon:size(jisx, jisy)
	ui.weaponicon:size(wisx, wisy)

	local textsize = (math.floor(settings.Texts.Size * factor))

	ui.hp_text:size(textsize)
	ui.mp_text:size(textsize)
	ui.tp_text:size(textsize)

	hp_bar_width = math.floor(theme_options.hp_bar_width * factor)
	hp_bar_height = math.floor(theme_options.hp_bar_height * factor)
	mp_bar_width = math.floor(theme_options.mp_bar_width * factor)
	mp_bar_height = math.floor(theme_options.mp_bar_height * factor)
	tp_bar1_width = math.floor(theme_options.tp_bar1_width * factor)
	tp_bar2_width = math.floor(theme_options.tp_bar2_width * factor)
	tp_bar3_width = math.floor(theme_options.tp_bar3_width * factor)
	tp_bar_height = math.floor(theme_options.tp_bar_height * factor)

	ui.jobicon:pos(math.floor(x + (theme_options.jobicon_posx * factor)), math.floor(y + (theme_options.jobicon_posy * factor)))
	ui.weaponicon:pos(math.floor(x + (theme_options.weaponicon_posx * factor)), math.floor(y + (theme_options.weaponicon_posy * factor)))
	
	ui.hp_bar:pos(math.floor(x + (theme_options.hp_bar_posx * factor)), math.floor(y + (theme_options.hp_bar_posy * factor)))
	ui.mp_bar:pos(math.floor(x + (theme_options.mp_bar_posx * factor)), math.floor(y + (theme_options.mp_bar_posy * factor)))
	ui.tp_bar1:pos(math.floor(x + (theme_options.tp_bar1_posx * factor)), math.floor(y + (theme_options.tp_bar1_posy * factor)))
	ui.tp_bar2:pos(math.floor(x + (theme_options.tp_bar2_posx * factor)), math.floor(y + (theme_options.tp_bar2_posy * factor)))
	ui.tp_bar3:pos(math.floor(x + (theme_options.tp_bar3_posx * factor)), math.floor(y + (theme_options.tp_bar3_posy * factor)))
	
	ui.hp_text:pos(math.floor(x + (theme_options.hp_text_posx * factor)), math.floor(ui.background:pos_y() + (theme_options.hp_text_posy * factor)))
	ui.mp_text:pos(math.floor(x + (theme_options.mp_text_posx * factor)), math.floor(ui.background:pos_y() + (theme_options.mp_text_posy * factor)))
	ui.tp_text:pos(math.floor(x + (theme_options.tp_text_posx * factor)), math.floor(ui.background:pos_y() + (theme_options.tp_text_posy * factor)))

end

windower.register_event('addon command', function(...)
    local args = {...}
    if args == nil then 
        windower.add_to_chat(8, 'xivbar: invalid number of arguments')
        return
    end
    if args[1] == 'save' then
		config.save(settings)
		copy(windower.addon_path .. "data/settings.xml", windower.addon_path .. "data/ThemeSelectorResources/settings_" .. settings.Theme.Name ..".xml")
		windower.add_to_chat(8, 'Settings saved to settings_' .. settings.Theme.Name .. '.xml')
	elseif (args[1] == 'x' and tonumber(args[2]) ~= nil) then
		settings.Bars.OffsetX = settings.Bars.OffsetX + args[2]
		config.save(settings)
		theme_options = theme.apply(settings)
		initialize()
	elseif (args[1] == 'y'  and tonumber(args[2]) ~= nil) then
		settings.Bars.OffsetY = settings.Bars.OffsetY + args[2]
		config.save(settings)
		theme_options = theme.apply(settings)
		initialize()
	elseif args[1] == 'reset' then
		copy(themefolder .. settings.Theme.Name .. "/settings_" .. settings.Theme.Name .. ".xml", settingsfolder .. "settings.xml")
		copy(themefolder .. settings.Theme.Name .. "/settings_" .. settings.Theme.Name .. ".xml", resourcefolder .. "settings_" .. settings.Theme.Name ..".xml")
		windower.add_to_chat(8, 'Settings for ' .. settings.Theme.Name .. ' restored to defaults.')
		windower.send_command("lua r xivbar")
	elseif (args[1] == 'theme' and args[2] ~= nil) then
		if io.open(resourcefolder .. "settings_" .. args[2] ..".xml") ~= nil then
			copy(resourcefolder .. "settings_" .. args[2] ..".xml", settingsfolder .. "settings.xml")
			windower.add_to_chat(8, 'Theme ' .. args[2] .. ' loaded.')
			windower.send_command("lua r xivbar")
		else
			windower.add_to_chat(8, 'No theme with that name found.')
		end
	elseif args[1] == 'center' then
		settings.Bars.OffsetX = 0
		settings.Bars.OffsetY = -(windower.get_windower_settings().y_res/2) - (theme_options.total_height / 2)
		theme_options = theme.apply(settings)
		initialize()
	elseif (args[1] == 'pos' and tonumber(args[2]) ~= nil and tonumber(args[3]) ~= nil) then
		settings.Bars.OffsetX = -(windower.get_windower_settings().x_res/2) + theme_options.total_width + args[2]
		settings.Bars.OffsetY = -(windower.get_windower_settings().y_res) + args[3]
		theme_options = theme.apply(settings)
		initialize()
		windower.add_to_chat(8, 'xivbar placed at ' .. args[2] .. ' x ' ..  args[3])
	elseif args[1] == 'help' then
		windower.add_to_chat(8, 'XIVBAR commands:')
		windower.add_to_chat(8, '"xivbar theme <themename>" will change theme, if the requested theme exists.')
		windower.add_to_chat(8, '"xivbar pos <number> <number>" will place the bar at the specified position.')
		windower.add_to_chat(8, '"xivbar x <number>" will move the bar right with positive and left with negative numbers.')
		windower.add_to_chat(8, '"xivbar y <number>" will move the bar down with positive and up with negative numbers.')
		windower.add_to_chat(8, '"xivbar center" will center the bar on your screen')
		windower.add_to_chat(8, '"xivbar scale <number>" will resize the bar by the percentage given, relative to it\'s default size.')
		windower.add_to_chat(8, '"xivbar reset" will reset the current theme to it\'s default settings and reload the addon.')
		windower.add_to_chat(8, '"xivbar save" will save the settings to the theme settings file.')
		windower.add_to_chat(8, 'If you do not save the settings will be returned to their defaults when you change themes.')
	elseif (args[1] == 'scale' and tonumber(args[2]) ~= nil) then
		settings.Theme.scale = tonumber(args[2])
		config.save(settings)
		scale(settings.Theme.scale)
	elseif (args[1] == 'winstyle' and tonumber(args[2]) ~= nil and tonumber(args[2]) <= 8) then
		copy(windower.addon_path .. 'themes/ffxi/bar_bg_style' .. tonumber(args[2]) .. '.png', windower.addon_path .. 'themes/ffxi/bar_bg.png')
		initialize()
	end
end)
