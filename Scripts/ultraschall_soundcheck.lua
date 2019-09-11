--[[
################################################################################
#
# Copyright (c) 2014-2019 Ultraschall (http://ultraschall.fm)
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


---------------------------------------------------------------
-- Soundcheck Samplerate
-- muss 48 KHz sein wenn mindestens eine StudioLink Spur im Projekt ist
---------------------------------------------------------------

function soundcheck_samplerate()

  retval, actual_samplerate = reaper.GetAudioDeviceInfo("SRATE", "")
  -- print("noch da")
  for i=1, reaper.CountTracks(0) do

    if ultraschall.IsTrackStudioLink(i) and actual_samplerate == "48000" then  -- es gibt mindestens eine StudioLink Spur und Samplerate steht nicht auf 48000

      return_value = ultraschall.MB("Your samplerate is set to "..actual_samplerate.." please set to 48000", "WARNING - Ultraschall Soundcheck", 2, "Abbrechen", "Abschalten", "OK")

      print(actual_samplerate)
      break

    end
  end
  retval, defer2_identifier = ultraschall.Defer2(soundcheck_samplerate, 2, 3)
end


function soundcheck_samplerate_controller()

  if ultraschall.GetUSExternalState("ultraschall_settings_samplerate", "value") == "0" then
    -- Soundcheck ist in den Settings deaktiviert

    if reaper.GetExtState("ultraschall", ultraschall.ScriptIdentifier..".defer_script02") == "running" then
      retval = ultraschall.StopDeferCycle(defer2_identifier)
    end

  else  -- Soundcheck ist in den Settings aktiviert

    if reaper.GetExtState("ultraschall", ultraschall.ScriptIdentifier..".defer_script02") ~= "running" then
      soundcheck_samplerate()
    end
  end
end

--------------------

function soundcheck_main()

  soundcheck_samplerate_controller()


  retval, defer1_identifier = ultraschall.Defer1(soundcheck_main, 2, 1)

end

soundcheck_main()
