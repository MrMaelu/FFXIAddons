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


local ui = {}

local text_setup = {
    flags = {
        draggable = false
    }
}

local images_setup = {
    draggable = true
}

-- ui variables

ui.background = images.new(images_setup)

ui.hp_bar = images.new(images_setup)
ui.hp_shade = images.new(images_setup)
ui.mp_bar = images.new(images_setup)

ui.tp_bar1 = images.new(images_setup)
ui.tp_bar2 = images.new(images_setup)
ui.tp_bar3 = images.new(images_setup)

ui.foreground = images.new(images_setup)

ui.hp_text = texts.new(text_setup)
ui.mp_text = texts.new(text_setup)
ui.tp_text = texts.new(text_setup)

ui.jobicon = images.new(images_setup)
ui.weaponicon = images.new(images_setup)

ui.dead = images.new(images_setup)

-- setup images
function setup_image(image, path)
    image:path(path)
    image:repeat_xy(1, 1)
    image:draggable(true)
    image:fit(true)
    image:show()
end

-- setup text
function setup_text(text, theme_options)
    text:bg_alpha(0)
    text:bg_visible(false)
    text:font(theme_options.font)
    text:size(theme_options.font_size)
    text:color(theme_options.font_color_red, theme_options.font_color_green, theme_options.font_color_blue)
    text:stroke_transparency(theme_options.font_stroke_alpha)
    text:stroke_color(theme_options.font_stroke_color_red, theme_options.font_stroke_color_green, theme_options.font_stroke_color_blue)
    text:stroke_width(theme_options.font_stroke_width)
    text:right_justified()
    text:show()
end

-- load the images and text
function ui:load(theme_options)
    setup_image(self.background, theme_options.bar_background)
	setup_image(self.foreground, theme_options.bar_foreground)
	setup_image(self.weaponicon, theme_options.bar_weaponicon)
	setup_image(self.jobicon, theme_options.bar_jobicon)
    setup_image(self.hp_bar, theme_options.bar_hp)
	setup_image(self.hp_shade, theme_options.bar_hp_shade)
    setup_image(self.mp_bar, theme_options.bar_mp)
    
	setup_image(self.tp_bar1, theme_options.bar_tp1)
	setup_image(self.tp_bar2, theme_options.bar_tp2)
	setup_image(self.tp_bar3, theme_options.bar_tp3)
    
	setup_text(self.hp_text, theme_options)
    setup_text(self.mp_text, theme_options)
    setup_text(self.tp_text, theme_options)

	setup_image(self.dead, theme_options.deathmessage)

    self:position(theme_options)
end

-- position the images and text
function ui:position(theme_options)
    local x = windower.get_windower_settings().x_res / 2 - (theme_options.total_width / 2) + theme_options.offset_x
    local y = windower.get_windower_settings().y_res + theme_options.offset_y

    self.background:pos(x, y)
	self.background:alpha(theme_options.bgalpha)
	self.foreground:pos(x, y)
	self.foreground:alpha(theme_options.fgalpha)

	self.jobicon:pos(x + theme_options.jobicon_posx , y + theme_options.jobicon_posy)
	self.jobicon:alpha(theme_options.jobicon_alpha)
	self.weaponicon:pos(x + theme_options.weaponicon_posx, y + theme_options.weaponicon_posy)
	self.weaponicon:alpha(theme_options.weaponicon_alpha)

    self.hp_bar:pos(x + theme_options.hp_bar_posx, y + theme_options.hp_bar_posy)
	self.hp_shade:pos(x , y)
	self.hp_shade:alpha(255)
    self.mp_bar:pos(x + theme_options.mp_bar_posx, y + theme_options.mp_bar_posy)
	self.tp_bar1:pos(x + theme_options.tp_bar1_posx, y + theme_options.tp_bar1_posy)
	self.tp_bar2:pos(x + theme_options.tp_bar2_posx, y + theme_options.tp_bar2_posy)
	self.tp_bar3:pos(x + theme_options.tp_bar3_posx, y + theme_options.tp_bar3_posy)

    self.mp_bar:width(0)
    
	self.tp_bar1:width(0)
	self.tp_bar2:width(0)
	self.tp_bar3:width(0)

    self.hp_text:pos(x + theme_options.hp_text_posx, self.background:pos_y() + theme_options.hp_text_posy)
	self.mp_text:pos(x + theme_options.mp_text_posx, self.background:pos_y() + theme_options.mp_text_posy)
	self.tp_text:pos(x + theme_options.tp_text_posx, self.background:pos_y() + theme_options.tp_text_posy)

	self.dead:pos(-2500 + (windower.get_windower_settings().x_res/2), windower.get_windower_settings().y_res /2 -300)
	self.dead:hide()
end

-- hide ui
function ui:hide()
    self.background:hide()
    self.foreground:hide()
	self.jobicon:hide()
	self.weaponicon:hide()
    self.hp_bar:hide()
	self.hp_shade:hide()
    self.hp_text:hide()
    self.mp_bar:hide()
    self.mp_text:hide()
    
	self.tp_bar1:hide()
    self.tp_bar2:hide()
	self.tp_bar3:hide()
	
	self.tp_text:hide()
end

-- show ui
function ui:show()
    self.background:show()
	self.foreground:show()
	self.jobicon:show()
	self.weaponicon:show()
    self.hp_bar:show()
    self.hp_shade:show()
	self.hp_text:show()
    self.mp_bar:show()
    self.mp_text:show()

	self.tp_bar1:show()
    self.tp_bar2:show()
	self.tp_bar3:show()

    self.tp_text:show()
end

return ui