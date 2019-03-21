--[[
################################################################################
# 
# Copyright (c) 2014-2018 Ultraschall (http://ultraschall.fm)
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
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
# 
################################################################################
]]

dofile(reaper.GetResourcePath().."/UserPlugins/ultraschall_api.lua")
-- dofile(reaper.GetResourcePath().."/Scripts/ser.lua")

-- local serialize = require (reaper.GetResourcePath().."/Scripts/ser")


function buildRoutingMatrix ()

	local AllMainSends, number_of_tracks = ultraschall.GetAllMainSendStates()
  
  for i=1, number_of_tracks do
  	AllMainSends[i]["MainSendOn"] = 1	-- alle Kanäle senden auf den Main - solange Preshow nicht aktiv ist
  end	

  retval = ultraschall.ApplyAllMainSendStates(AllMainSends)	-- setze alle Sends zum Master

end


retval = ultraschall.ClearRoutingMatrix(true, true, true, true, false)
retval = ultraschall.AddTrackHWOut(0, 0, 0, 1, 0, 0, 0, 0, -1, 0, false) -- Soundboard-Spuren gehen immer auf den MainHardwareOut Zurück
buildRoutingMatrix ()

