--[[
Copyright © 2020, Kwech of Bahamut
All rights reserved.
Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of JobChange nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.
THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL Sammeh BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
]]

_addon.name = 'DNC-hud'
_addon.author = 'Kwech'
_addon.version = '1.2.2'

-- 1.2.2 first public release

texts = require('texts')
timer3 = texts.new("")
local time_start = 0

local previous = 0
local previous2 = 0

local iPosition_x = 1500
local iPosition_y = 300

-- Define size variables
local sizeScale = 1
local stemWidth = 150
local stemHeight = 300
local flourishes3Width = 150
local flourishes3Height = 150
local flourishes2Width = 75
local flourishes2Height = 75
local FM1Width = 40
local FM1Height = 50
local FM2Width = 40
local FM2Height = 50
local FM3Width = 40
local FM3Height = 50
local FM4Width = 40
local FM4Height = 50
local FM5Width = 40
local FM5Height = 50
local FM6Width = 50
local FM6Height = 50 -- Size for FM6 is different from the others

texts.visible(timer3, false)
texts.pos(timer3, (iPosition_x + 100) * sizeScale, (iPosition_y + 115) * sizeScale)
texts.bg_alpha(timer3, 0)

local vFM1 = 0
local vFM2 = 0
local vFM3 = 0
local vFM4 = 0
local vFM5 = 0
local vFM6 = 0

local temp = 0
local temp2 = 0

local mins = 0
local secs = 0


windower.register_event('load', function()

    -- Stem
    windower.prim.create('stem')
    windower.prim.set_color('stem', 255, 255, 255, 255)
    windower.prim.set_fit_to_texture('stem', false)
    windower.prim.set_texture('stem', windower.addon_path .. 'assets/stem.png')
    windower.prim.set_repeat('stem', 1, 1)
    windower.prim.set_visibility('stem', true)
    windower.prim.set_position('stem', iPosition_x * sizeScale, (iPosition_y + 125) * sizeScale)
    windower.prim.set_size('stem', stemWidth * sizeScale, stemHeight * sizeScale)

	-- Flourishes III or Large Rose
	windower.prim.create('flourishes3')
	windower.prim.set_color('flourishes3', 255, 255, 255, 255)
	windower.prim.set_fit_to_texture('flourishes3', false)
	windower.prim.set_texture('flourishes3', windower.addon_path .. 'assets/rosehead.png')
	windower.prim.set_repeat('flourishes3', 1, 1)
	windower.prim.set_visibility('flourishes3', true)
	windower.prim.set_position('flourishes3', iPosition_x * sizeScale, iPosition_y * sizeScale)
	windower.prim.set_size('flourishes3', flourishes3Width * sizeScale, flourishes3Height * sizeScale)

	-- Flourishes II or Small Rose
	windower.prim.create('flourishes2')
	windower.prim.set_color('flourishes2', 255, 255, 255, 255)
	windower.prim.set_fit_to_texture('flourishes2', false)
	windower.prim.set_texture('flourishes2', windower.addon_path .. 'assets/rosehead2.png')
	windower.prim.set_repeat('flourishes2', 1, 1)
	windower.prim.set_visibility('flourishes2', true)
	windower.prim.set_position('flourishes2', (iPosition_x + 60) * sizeScale, (iPosition_y + 250) * sizeScale)
	windower.prim.set_size('flourishes2', flourishes2Width * sizeScale, flourishes2Height * sizeScale)

	-- FM1
	windower.prim.create('FM1')
	windower.prim.set_color('FM1', vFM1, vFM1, vFM1, vFM1) -- Assuming default color; replace as necessary
	windower.prim.set_fit_to_texture('FM1', false)
	windower.prim.set_texture('FM1', windower.addon_path .. 'assets/FM1.png')
	windower.prim.set_repeat('FM1', 1, 1)
	windower.prim.set_visibility('FM1', true)
	windower.prim.set_position('FM1', (iPosition_x + 22) * sizeScale, (iPosition_y + 155) * sizeScale)
	windower.prim.set_size('FM1', FM1Width * sizeScale, FM1Height * sizeScale)

	-- FM2
	windower.prim.create('FM2')
	windower.prim.set_color('FM2', vFM2, vFM2, vFM2, vFM2)
	windower.prim.set_fit_to_texture('FM2', false)
	windower.prim.set_texture('FM2', windower.addon_path .. 'assets/FM2.png')
	windower.prim.set_repeat('FM2', 1, 1)
	windower.prim.set_visibility('FM2', true)
	windower.prim.set_position('FM2', (iPosition_x + 22) * sizeScale, (iPosition_y + 155) * sizeScale)
	windower.prim.set_size('FM2', FM2Width * sizeScale, FM2Height * sizeScale)

	-- FM3
	windower.prim.create('FM3')
	windower.prim.set_color('FM3', vFM3, vFM3, vFM3, vFM3)
	windower.prim.set_fit_to_texture('FM3', false)
	windower.prim.set_texture('FM3', windower.addon_path .. 'assets/FM3.png')
	windower.prim.set_repeat('FM3', 1, 1)
	windower.prim.set_visibility('FM3', true)
	windower.prim.set_position('FM3', (iPosition_x + 22) * sizeScale, (iPosition_y + 155) * sizeScale)
	windower.prim.set_size('FM3', FM3Width * sizeScale, FM3Height * sizeScale)

	-- FM4
	windower.prim.create('FM4')
	windower.prim.set_color('FM4', vFM4, vFM4, vFM4, vFM4)
	windower.prim.set_fit_to_texture('FM4', false)
	windower.prim.set_texture('FM4', windower.addon_path .. 'assets/FM4.png')
	windower.prim.set_repeat('FM4', 1, 1)
	windower.prim.set_visibility('FM4', true)
	windower.prim.set_position('FM4', (iPosition_x + 22) * sizeScale, (iPosition_y + 155) * sizeScale)
	windower.prim.set_size('FM4', FM4Width * sizeScale, FM4Height * sizeScale)

	-- FM5
	windower.prim.create('FM5')
	windower.prim.set_color('FM5', vFM5, vFM5, vFM5, vFM5)
	windower.prim.set_fit_to_texture('FM5', false)
	windower.prim.set_texture('FM5', windower.addon_path .. 'assets/FM5.png')
	windower.prim.set_repeat('FM5', 1, 1)
	windower.prim.set_visibility('FM5', true)
	windower.prim.set_position('FM5', (iPosition_x + 22) * sizeScale, (iPosition_y + 155) * sizeScale)
	windower.prim.set_size('FM5', FM5Width * sizeScale, FM5Height * sizeScale)

	-- FM6
	windower.prim.create('FM6')
	windower.prim.set_color('FM6', vFM6, vFM6, vFM6, vFM6)
	windower.prim.set_fit_to_texture('FM6', false)
	windower.prim.set_texture('FM6', windower.addon_path .. 'assets/FM6.png')
	windower.prim.set_repeat('FM6', 1, 1)
	windower.prim.set_visibility('FM6', true)
	windower.prim.set_position('FM6', (iPosition_x + 22) * sizeScale, (iPosition_y + 155) * sizeScale)
	windower.prim.set_size('FM6', FM6Width * sizeScale, FM6Height * sizeScale)
end);


windower.register_event('prerender', function()

    if os.time() > time_start then
        time_start = os.time()		
        ability_hud() 
    end
	
end)

function ability_hud ()
	recasts = windower.ffxi.get_ability_recasts()
	temp = recasts[226]
	temp2 = recasts[222]
	
	if (temp ~= 0 and previous == 0) then
		windower.prim.set_color('flourishes3', 100, 100, 100, 100)
		texts.visible(timer3, true)
	end
	if (temp == 0 and previous ~= 0) then
		windower.prim.set_color('flourishes3', 255, 255, 255, 255)
		texts.visible(timer3, false)
	end
	
	previous = temp
	
	if (temp2 ~= 0 and previous2 == 0) then
		windower.prim.set_color('flourishes2', 100, 100, 100, 100)
	end
	if (temp2 == 0 and previous2 ~= 0) then
		windower.prim.set_color('flourishes2', 255, 255, 255, 255)
	end
	
	previous2 = temp2
	
	mins = math.floor(temp / 60)
	secs = temp % 60

	if (mins == 1) then
		if (secs > 9) then
			texts.text(timer3, "1:" .. tostring(secs))
		else
			texts.text(timer3, "1:0" .. tostring(secs))
		end
	else
		if (secs > 9) then
			texts.text(timer3, " :" .. tostring(secs))
		else
			texts.text(timer3, " :0" .. tostring(secs))
		end
	end
	
end

windower.register_event('lose buff', function(buff_id)
	if (buff_id == 381) then
		vFM1 = 0
		windower.prim.set_color('FM1', vFM1, vFM1, vFM1, vFM1)
	end
	if (buff_id == 382) then
		vFM2 = 0
		windower.prim.set_color('FM2', vFM2, vFM2, vFM2, vFM2)
	end
	if (buff_id == 383) then
		vFM3 = 0
		windower.prim.set_color('FM3', vFM3, vFM3, vFM3, vFM3)
	end
	if (buff_id == 384) then
		vFM4 = 0
		windower.prim.set_color('FM4', vFM4, vFM4, vFM4, vFM4)
	end
	if (buff_id == 385) then
		vFM5 = 0
		windower.prim.set_color('FM5', vFM5, vFM5, vFM5, vFM5)
	end
	if (buff_id == 588) then
		vFM6 = 0
		windower.prim.set_color('FM6', vFM6, vFM6, vFM6, vFM6)
	end
end)

windower.register_event('gain buff', function(buff_id)
	if (buff_id == 381) then
		vFM1 = 255
		windower.prim.set_color('FM1', vFM1, vFM1, vFM1, vFM1)
	end
	if (buff_id == 382) then
		vFM2 = 255
		windower.prim.set_color('FM2', vFM2, vFM2, vFM2, vFM2)
	end
	if (buff_id == 383) then
		vFM3 = 255
		windower.prim.set_color('FM3', vFM3, vFM3, vFM3, vFM3)
	end
	if (buff_id == 384) then
		vFM4 = 255
		windower.prim.set_color('FM4', vFM4, vFM4, vFM4, vFM4)
	end
	if (buff_id == 385) then
		vFM5 = 255
		windower.prim.set_color('FM5', vFM5, vFM5, vFM5, vFM5)
	end
	if (buff_id == 588) then
		vFM6 = 255
		windower.prim.set_color('FM6', vFM6, vFM6, vFM6, vFM6)
	end
end)

function delete()
	windower.prim.delete('stem')
	windower.prim.delete('flourishes3')	
	windower.prim.delete('flourishes2')
	windower.prim.delete('FM1')
	windower.prim.delete('FM2')
	windower.prim.delete('FM3')
	windower.prim.delete('FM4')
	windower.prim.delete('FM5')
	windower.prim.delete('FM6')
end

windower.register_event('unload',function()
	delete()
end)

windower.register_event('logout',function()
	windower.send_command('lua u DNC-hud')
end)

windower.register_event('job change',function(main_job_id)
	if (main_job_id ~= 19) then
		print(main_job_id)
		windower.send_command('lua u DNC-hud')
	end
end)
