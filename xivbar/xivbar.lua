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

-- Addon description
_addon.name = 'XIV Bar'
_addon.author = 'Edeon'
_addon.version = '1.0'
_addon.language = 'english'

-- Libs
config = require('config')
texts  = require('texts')
images = require('images')
res = require('resources')

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
local hp_bar_width = theme_options.hp_bar_width
local hp_bar_height = theme_options.hp_bar_height

local mp_bar_width = theme_options.mp_bar_width
local mp_bar_height = theme_options.mp_bar_height

local tp_bar1_width = theme_options.tp_bar1_width
local tp_bar2_width = theme_options.tp_bar2_width
local tp_bar3_width = theme_options.tp_bar3_width
local tp_bar_height = theme_options.tp_bar_height

local deathmessage = theme_options.deathmessage

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

    xivbar.initialized = true
end

-- update a bar
function update_bar(bar, text, width, current, pp, flag)
    local old_width = width

	if flag == 1 then
		new_width = math.floor((pp / 100) * hp_bar_width)
	elseif flag == 2 then
		new_width = math.floor((pp / 100) * mp_bar_width)
	elseif flag >= 3 then
		new_width = math.floor((pp / 100) * tp_bar1_width)
	end

    if new_width ~= nil and new_width >= 0 then
        if old_width == new_width then
            if new_width == 0 then
                bar:hide()
            end
			
        else
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
				--xivbar.update_hp = false
                xivbar.hp_bar_width = x
				bar:size(x, hp_bar_height)
				if x == hp_bar_width then
					bar:alpha(theme_options.bar_alphaMax)
				else
					bar:alpha(theme_options.bar_alphaMin)
				end
				bar:show()
            elseif flag == 2 then
				--xivbar.update_mp = false
                xivbar.mp_bar_width = x
				bar:size(x, mp_bar_height)
				if x == mp_bar_width then
					bar:alpha(theme_options.bar_alphaMax)
				else
					bar:alpha(theme_options.bar_alphaMin)
				end
				bar:show()
            elseif flag == 5 then
				--xivbar.update_tp = false
				xivbar.tp_bar1_width = tp_bar1_width
				xivbar.tp_bar2_width = tp_bar2_width
				xivbar.tp_bar3_width = x

				ui.tp_bar1:size(tp_bar1_width, tp_bar_height)
				ui.tp_bar2:size(tp_bar2_width, tp_bar_height)
				ui.tp_bar3:size(x, tp_bar_height)
				
				ui.tp_bar1:show()
				ui.tp_bar2:show()
				ui.tp_bar3:show()				
			elseif flag == 4 then
				--xivbar.update_tp = false
				xivbar.tp_bar1_width = tp_bar1_width
				xivbar.tp_bar2_width = x
				xivbar.tp_bar3_width = 0
				
				ui.tp_bar1:size(tp_bar1_width, tp_bar_height)
				ui.tp_bar2:size(x, tp_bar_height)
				ui.tp_bar3:size(0, tp_bar_height)
				
				ui.tp_bar1:show()
				ui.tp_bar2:show()
				ui.tp_bar3:hide()
			elseif flag == 3 then
				--xivbar.update_tp = false
				xivbar.tp_bar1_width = x
				xivbar.tp_bar2_width = 0
				xivbar.tp_bar3_width = 0
				
				ui.tp_bar1:size(x, tp_bar_height)
				ui.tp_bar2:size(0, tp_bar_height)
				ui.tp_bar3:size(0, tp_bar_height)
				
				ui.tp_bar1:show()
				ui.tp_bar2:hide()
				ui.tp_bar3:hide()
            end
		
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
		prefix = 'MP '
	end
else
	prefix = ''
end

text:text(prefix .. tostring(current))
text:alpha(theme_options.font_alpha)

end

-- Updates the job icon. Hides TP bar since it shows as full after changing.
function update_job(job)
	xivbar.update_job = false
	ui:hide()
	theme_options.bar_jobicon = windower.addon_path .. 'themes/' .. settings.Theme.Name .. '/' .. job .. '.png'
	initialize()
	ui:show()
	ui.tp_bar1:hide()
	ui.tp_bar2:hide()
	ui.tp_bar3:hide()
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
    xivbar.update_hp = true
    xivbar.update_mp = true
    xivbar.update_tp = true
	xivbar.update_job = true
end

-- Bind Events
-- ON LOAD
windower.register_event('load', function()
    if windower.ffxi.get_info().logged_in then
        initialize()
        show()
    end
end)

-- ON LOGIN
windower.register_event('login', function()
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
    xivbar.update_hp = true
end)

windower.register_event('hpp change', function(new, old)
    player.hpp = new
    xivbar.update_hp = true
end)

windower.register_event('mp change', function(new, old)
    player.current_mp = new
    xivbar.update_mp = true
end)

windower.register_event('mpp change', function(new, old)
    player.mpp = new
    xivbar.update_mp = true
end)

windower.register_event('tp change', function(new, old)
    player.current_tp = new
    player:calculate_tpp()
    xivbar.update_tp = true
end)

windower.register_event('job change', function(new)
	player.job = new
	xivbar.update_job = true
end)

windower.register_event('prerender', function()
    if xivbar.ready == false then
        return
    end

    if xivbar.update_hp then
        update_bar(ui.hp_bar, ui.hp_text, xivbar.hp_bar_width, player.current_hp, player.hpp, 1)
    end

    if xivbar.update_mp then
        update_bar(ui.mp_bar, ui.mp_text, xivbar.mp_bar_width, player.current_mp, player.mpp, 2)
    end

    if xivbar.update_tp then
		update_bar(ui.tp_bar1, ui.tp_text, xivbar.tp_bar1_width, player.current_tp, player.tpp1, 3)
		update_bar(ui.tp_bar2, ui.tp_text, xivbar.tp_bar2_width, player.current_tp, player.tpp2, 4)
		update_bar(ui.tp_bar3, ui.tp_text, xivbar.tp_bar3_width, player.current_tp, player.tpp3, 5)
    end

	if xivbar.update_job then
		update_job(player.job)
	end

end)

windower.register_event('status change', function(new_status_id)
print(new_status_id)
    if xivbar.hide_bars == false and (new_status_id == 4) then
        xivbar.hide_bars = true
        hide()
    elseif xivbar.hide_bars and new_status_id ~= 4 then
        xivbar.hide_bars = false
        show()
	end
	if new_status_id == 2 then
		ui.dead:show()
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
		theme_options.bar_weaponicon = windower.addon_path .. 'themes/' .. settings.Theme.Name .. '/' .. skill .. 'w.png'
		initialize()
		ui:show()
		ui.tp_bar1:hide()
		ui.tp_bar2:hide()
		ui.tp_bar3:hide()
	elseif not check_weapon or coroutine.status(check_weapon) ~= 'suspended' then
        check_weapon = coroutine.schedule(update_weapon, 10)
    end
end

windower.register_event('load', function()
    if windower.ffxi.get_info().logged_in then
        local equip = windower.ffxi.get_items('equipment')
        info.main_weapon = equip.main
        info.main_bag = equip.main_bag
        info.range = equip.range
        info.range_bag = equip.range_bag
        update_weapon()
    end
end)
