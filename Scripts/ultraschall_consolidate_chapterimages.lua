--[[
################################################################################
#
# Copyright (c) 2014-2020 Ultraschall (http://ultraschall.fm)
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

-- item = reaper.GetSelectedMediaItem(0, 0)

function CountProjectValues(section)

  for i = 0, 100 do
    if not reaper.EnumProjExtState (0, section, i) then
      return i
    end
  end
end



retval = ultraschall.DeleteProjExtState_Section("chapterimages") -- erst mal alles löschen
retval2 = ultraschall.DeleteProjExtState_Section("lostimages") -- erst mal alles löschen

itemcount = reaper.CountMediaItems(0)

if itemcount > 0 then
  for i = 0, itemcount-1 do -- gehe alle Items durch

    media_item = reaper.GetMediaItem(0, i)

    take = reaper.GetActiveTake(media_item)
    src = reaper.GetMediaItemTake_Source(take)
    filename = reaper.GetMediaSourceFileName(src, "")
    fileformat, supported_by_reaper, mediatype = ultraschall.CheckForValidFileFormats(filename)

    if mediatype == "Image" then

      position = ultraschall.GetItemPosition(media_item)

      -- print (ultraschall.GetMarkerByTime(position, true))

      if ultraschall.GetMarkerByTime(position, true) ~= "" then  -- da liegt auch ein Marker, alles gut
        section = "chapterimages"

      else  -- Bild liegt ohne Marker rum
        section = "lostimages"

      end

      imagecount = reaper.SetProjExtState(0, section, position, filename)
      --reaper.SetExtState(section, position, filename, true) -- nur debugging

    end
  end
end






-- key_count = ultraschall.CountUSExternalState_key(sectionName, "ultraschall-settings.ini")


-- for i = 1, key_count , 1 do


-- keyscount_chapterimages = ultraschall.CountUSExternalState_key("chapterimages", "reaper-extstate.ini")
-- keyscount_lostimages = ultraschall.CountUSExternalState_key("lostimages", "reaper-extstate.ini")

-- keyscount_chapterimages = CountProjectValues("chapterimages")
-- keyscount_lostimages = CountProjectValues("lostimages")

-- print (keyscount_chapterimages .. " - " .. keyscount_lostimages)

-- Message = "+;ExportContext;".."\nChapterImages with chapter: "..tostring(keyscount_chapterimages).."\nUnassigned Images: " ..tostring(keyscount_lostimages)

-- reaper.SetExtState("ultraschall_messages", "message_0", Message, false) -- nur debugging
-- reaper.SetExtState("ultraschall_messages", "message_count", "1", false) -- nur debugging







-- print (fileformat .." - " .. tostring(supported_by_reaper)  .." - " .. mediatype)

-- print(filename)
-- print(position)
-- print(markers)
--[[ copy stuff, wird erst mal nicht gebraucht

project_path = reaper.GetProjectPath("")
print(project_path)
dirname = project_path.."/chapterimages"
os.execute("mkdir " .. dirname)
os.execute("cp " .. filename .. " " .. dirname)

]]


-- image_key = tostring(position) .. "_img"