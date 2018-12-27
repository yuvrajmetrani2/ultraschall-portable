--[[
################################################################################
# 
# Copyright (c) 2014-2017 Ultraschall (http://ultraschall.fm)
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTH ER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
# 
################################################################################
]]

-- Toggles external state, that signal the Start/Stop and Start/Pause-scripts, 
-- that safemode shall be applied or not.

dofile(reaper.GetResourcePath().."/UserPlugins/ultraschall_api.lua")

state=ultraschall.GetUSExternalState("Ultraschall_Transport", "Safemode_Toggle")

if state=="ON" or state=="" or state=="-1" then -- If SafeMode is ON or was never set, turn it OFF
  ultraschall.SetUSExternalState("Ultraschall_Transport", "Safemode_Toggle", "OFF")

elseif state=="OFF" then -- If SafeMode is OFF, turn it ON
  ultraschall.SetUSExternalState("Ultraschall_Transport", "Safemode_Toggle", "ON")
end
