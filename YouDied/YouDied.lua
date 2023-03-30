--[[
        Copyright © 2023, MrMaelu
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
        DISCLAIMED. IN NO EVENT SHALL MrMaelu BE LIABLE FOR ANY
        DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
        (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
        LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
        ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
        (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
        SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
]]

-- Addon description
_addon.name = 'YouDied'
_addon.author = 'MrMaelu'
_addon.version = '1.0'
_addon.language = 'english'

images = require('images')

local images_setup = {
    draggable = false
}

deadshade = windower.addon_path .. 'deads.png'
deadtext = windower.addon_path .. 'deadt.png'

deads = images.new(images_setup)
deadt = images.new(images_setup)

local images_setup = {
    draggable = false
}

function setup_image(image, path)
    image:path(path)
    image:draggable(false)
    image:fit(true)
end

setup_image(deads, deadshade)
setup_image(deadt, deadtext)

deads:pos(-2500 + (windower.get_windower_settings().x_res/2), windower.get_windower_settings().y_res /2 -300)
deadt:pos(-2500 + (windower.get_windower_settings().x_res/2), windower.get_windower_settings().y_res /2 -300)

windower.register_event('status change', function(new_status_id)
	if new_status_id == 2 then
		-- show
		deads:show()
		deadt:alpha(0)
		deadt:show()
		coroutine.sleep(0.1)
		deadt:alpha(25)
		deadt:show()
		coroutine.sleep(0.1)
		deadt:alpha(50)
		deadt:show()
		coroutine.sleep(0.1)
		deadt:alpha(75)
		deadt:show()
		coroutine.sleep(0.1)
		deadt:alpha(100)
		deadt:show()
		coroutine.sleep(0.1)
		deadt:alpha(125)
		deadt:show()
		coroutine.sleep(0.1)
		deadt:alpha(150)
		deadt:show()
		coroutine.sleep(0.1)
		deadt:alpha(175)
		deadt:show()
		coroutine.sleep(0.1)
		deadt:alpha(200)
		deadt:show()
		coroutine.sleep(0.1)
		deadt:alpha(225)
		deadt:show()
		coroutine.sleep(0.1)
		deadt:alpha(250)
		deadt:show()
		coroutine.sleep(0.1)
		deadt:alpha(255)
		deadt:show()
		coroutine.sleep(0.1)
	else
		-- hide
		deads:hide()
		deadt:hide()
	end
end)