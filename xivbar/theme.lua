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

    options.total_height = settings.Theme.height
    options.total_width = settings.Theme.width
    options.offset_x = settings.Bars.OffsetX
    options.offset_y = settings.Bars.OffsetY

	options.bar_background = windower.addon_path .. 'themes/' .. settings.Theme.Name .. '/bar_bg.png'
    options.bar_foreground = windower.addon_path .. 'themes/' .. settings.Theme.Name .. '/bar_fg.png'
    options.bar_hp = windower.addon_path .. 'themes/' .. settings.Theme.Name .. '/hp_fg.png'
    options.bar_mp = windower.addon_path .. 'themes/' .. settings.Theme.Name .. '/mp_fg.png'
    options.bar_tp1 = windower.addon_path .. 'themes/' .. settings.Theme.Name .. '/tp1_fg.png'
	options.bar_tp2 = windower.addon_path .. 'themes/' .. settings.Theme.Name .. '/tp2_fg.png'
	options.bar_tp3 = windower.addon_path .. 'themes/' .. settings.Theme.Name .. '/tp3_fg.png'

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

    options.bar_spacing = settings.Theme.Bar.Spacing
    options.bar_offset = settings.Theme.Bar.Offset

    options.dim_tp_bar = settings.Theme.DimTpBar

	options.bgalpha = settings.Theme.bgalpha
	options.fgalpha = settings.Theme.fgalpha

	options.jobicon_posx = settings.Theme.jobiconposx
	options.jobicon_posy = settings.Theme.jobiconposy
	options.jobicon_alpha = settings.Theme.jobiconalpha

	options.weaponicon_posx = settings.Theme.weaponiconposx
	options.weaponicon_posy = settings.Theme.weaponiconposy
	options.weaponicon_alpha = settings.Theme.weaponiconalpha

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