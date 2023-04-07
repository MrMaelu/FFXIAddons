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

local theme = {}

theme.apply = function (settings)
    local options = {}
	options.scale = settings.Theme.scale
    
	options.total_height = settings.Theme.height
    options.total_width = settings.Theme.width
    options.offset_x = settings.Bars.OffsetX
    options.offset_y = settings.Bars.OffsetY

	local themepath = windower.addon_path .. 'themes/' .. settings.Theme.Name .. '/'
	local defaultpath = windower.addon_path .. 'data/defaults/'

	if io.open(themepath .. 'bar_bg.png') ~= nil then
		options.bar_background = themepath .. 'bar_bg.png'
	else
		options.bar_background = defaultpath .. 'bar_bg.png'
	end

	if io.open(themepath .. 'bar_fg.png') ~= nil then
		options.bar_foreground = themepath .. 'bar_fg.png'
	else
		options.bar_foreground = defaultpath .. 'bar_fg.png'
	end
	
	if io.open(themepath .. 'hp_fg.png') ~= nil then
		options.bar_hp = themepath .. 'hp_fg.png'
	else
		options.bar_hp = defaultpath .. 'hp_fg.png'
	end
	
	if io.open(themepath .. 'hp_shade.png') ~= nil then
		options.bar_hp_shade = themepath .. 'hp_shade.png'
    else
		options.bar_hp_shade = defaultpath .. 'hp_shade.png'
	end
	
	if io.open(themepath .. 'mp_fg.png') ~= nil then
		options.bar_mp = themepath .. 'mp_fg.png'
	else
		options.bar_mp = defaultpath .. 'mp_fg.png'
	end
	
	if io.open(themepath .. 'tp1_fg.png') ~= nil then
		options.bar_tp1 = themepath .. 'tp1_fg.png'
	else
		options.bar_tp1 = defaultpath .. 'tp1_fg.png'
	end

	if io.open(themepath .. 'tp2_fg.png') ~= nil then
		options.bar_tp2 = themepath .. 'tp2_fg.png'
	else
		options.bar_tp2 = defaultpath .. 'tp2_fg.png'
	end

	if io.open(themepath .. 'tp3_fg.png') ~= nil then
		options.bar_tp3 = themepath .. 'tp3_fg.png'
	else
		options.bar_tp3 = defaultpath .. 'tp3_fg.png'
	end

    options.font = settings.Texts.Font
    options.font_size = settings.Texts.Size
    options.font_alpha = settings.Texts.Color.Alpha
    options.font_color_red = settings.Texts.Color.Red
    options.font_color_green = settings.Texts.Color.Green
    options.font_color_blue = settings.Texts.Color.Blue
    options.font_stroke_width = settings.Texts.Stroke.Width
    options.font_stroke_alpha = settings.Texts.Stroke.Alpha
    options.font_stroke_color_red = settings.Texts.Stroke.Red
    options.font_stroke_color_green = settings.Texts.Stroke.Green
    options.font_stroke_color_blue = settings.Texts.Stroke.Blue
    options.full_tp_color_red = settings.Texts.FullTpColor.Red
    options.full_tp_color_green = settings.Texts.FullTpColor.Green
    options.full_tp_color_blue = settings.Texts.FullTpColor.Blue
    options.text_offset = settings.Texts.Offset
	options.numberprefix = settings.Texts.prefix
	
	options.bar_alphaMax = settings.Theme.Bar.alphamax
	options.bar_alphaMin = settings.Theme.Bar.alphamin

	options.hp_bar_width = settings.Theme.Bar.hp.width
	options.hp_bar_height = settings.Theme.Bar.hp.height
	
	options.mp_bar_width = settings.Theme.Bar.mp.width
	options.mp_bar_height = settings.Theme.Bar.mp.height
	
	options.tp_bar1_width = settings.Theme.Bar.tp.a.width
	options.tp_bar2_width = settings.Theme.Bar.tp.b.width
	options.tp_bar3_width = settings.Theme.Bar.tp.c.width
	options.tp_bar_height = settings.Theme.Bar.tp.height

    options.dim_tp_bar = settings.Theme.DimTpBar

	options.bgalpha = settings.Theme.bgalpha
	options.fgalpha = settings.Theme.fgalpha

	options.jobicon_posx = settings.Theme.jobiconposx
	options.jobicon_posy = settings.Theme.jobiconposy
	options.jobicon_alpha = settings.Theme.jobiconalpha
	options.jisx = settings.Theme.jisx
	options.jisy = settings.Theme.jisy

	options.weaponicon_posx = settings.Theme.weaponiconposx
	options.weaponicon_posy = settings.Theme.weaponiconposy
	options.weaponicon_alpha = settings.Theme.weaponiconalpha
	options.wisx = settings.Theme.wisx
	options.wisy = settings.Theme.wisy

    options.hp_bar_posx = settings.Theme.Bar.hp.posx
	options.hp_bar_posy = settings.Theme.Bar.hp.posy
    
	options.mp_bar_posx = settings.Theme.Bar.mp.posx
	options.mp_bar_posy = settings.Theme.Bar.mp.posy
	
	options.tp_bar1_posx = settings.Theme.Bar.tp.a.posx
	options.tp_bar1_posy = settings.Theme.Bar.tp.a.posy

	options.tp_bar2_posx = settings.Theme.Bar.tp.b.posx
	options.tp_bar2_posy = settings.Theme.Bar.tp.b.posy

	options.tp_bar3_posx = settings.Theme.Bar.tp.c.posx
	options.tp_bar3_posy = settings.Theme.Bar.tp.c.posy

    options.hp_text_posx = settings.Theme.Bar.hp.textx
	options.hp_text_posy = settings.Theme.Bar.hp.texty
	options.mp_text_posx = settings.Theme.Bar.mp.textx
	options.mp_text_posy = settings.Theme.Bar.mp.texty
	options.tp_text_posx = settings.Theme.Bar.tp.textx
	options.tp_text_posy = settings.Theme.Bar.tp.texty

    return options
end

return theme