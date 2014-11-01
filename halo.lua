dofile("urlcode.lua")
dofile("table_show.lua")
JSON = (loadfile "JSON.lua")()

local url_count = 0
local tries = 0
local item_type = os.getenv('item_type')
local item_value = os.getenv('item_value')

local downloaded = {}
local addedtolist = {}

load_json_file = function(file)
  if file then
    local f = io.open(file)
    local data = f:read("*all")
    f:close()
    return JSON:decode(data)
  else
    return nil
  end
end

read_file = function(file)
  if file then
    local f = assert(io.open(file))
    local data = f:read("*all")
    f:close()
    return data
  else
    return ""
  end
end

wget.callbacks.download_child_p = function(urlpos, parent, depth, start_url_parsed, iri, verdict, reason)
  local url = urlpos["url"]["url"]
  local html = urlpos["link_expect_html"]
  local parenturl = parent["url"]
  local html = nil
  
  if downloaded[url] == true or addedtolist[url] == true then
    return false
  end
  
  if item_type == "halo3file" then
    if string.match(url, "[^0-9]"..item_value.."[0-9][0-9]")
      or string.match(url, "/javascript/")
      or string.match(url, "/base_css/")
      or string.match(url, "/images/")
      or string.match(url, "/Silverlight/")
      or string.match(url, "/Stats/")
      or string.match(url, "/App_Themes/")
      or string.match(url, "/WebResource%.axd")
      or string.match(url, "/bprovideo/")
      or string.match(url, "/ScriptResource%.axd")
      or string.match(url, "/Screenshot%.ashx")
      or string.match(url, "silverlight%.dlservice%.microsoft%.com")
      or string.match(url, "/GameStatsHalo3%.aspx") then
      if not string.match(url, "[0-9]?"..item_value.."[0-9][0-9][0-9]")
        and not string.match(url, "PlayerStatsHalo3%.aspx%?player=")
        and not string.match(url, "/Stats/Halo3/Default%.aspx%?player=") then
        return true
      else
        return false
      end
    else
      return false
    end
  end
  
end


wget.callbacks.get_urls = function(file, url, is_css, iri)
  local urls = {}
  local html = nil
        
  if string.match(url, "/Stats/GameStatsHalo3%.aspx%?gameguid=[0-9]+") then
    local customurl = string.gsub(url, "/Stats/GameStatsHalo3%.aspx%?gameguid=", "/Stats/GameFiles%.aspx%?guid=")
    if downloaded[customurl] ~= true and addedtolist[customurl] ~= true then
      table.insert(urls, { url=customurl })
    end
  end
  
  if item_type == "halo3file" then
    if string.match(url, "[^0-9]"..item_value.."[0-9][0-9]") then
      if not string.match(url, "[0-9]?"..item_value.."[0-9][0-9][0-9]") then
        html = read_file(html)
        
        for customurl in string.gmatch(html, '"(http[s]?://[^"]+)"') do
          if string.match(customurl, "[^0-9]"..item_value.."[0-9][0-9]")
            or string.match(customurl, "/javascript/")
            or string.match(customurl, "/base_css/")
            or string.match(customurl, "/images/")
            or string.match(customurl, "/Silverlight/")
            or string.match(customurl, "/Stats/")
            or string.match(customurl, "/App_Themes/")
            or string.match(customurl, "/WebResource%.axd")
            or string.match(customurl, "/bprovideo/")
            or string.match(customurl, "/ScriptResource%.axd")
            or string.match(customurl, "/Screenshot%.ashx")
            or string.match(customurl, "silverlight%.dlservice%.microsoft%.com")
            or string.match(customurl, "/GameStatsHalo3%.aspx") then
            if not string.match(customurl, "[0-9]?"..item_value.."[0-9][0-9][0-9]")
              and not string.match(customurl, "PlayerStatsHalo3%.aspx%?player=")
              and not string.match(customurl, "/Stats/Halo3/Default%.aspx%?player=") then
              if downloaded[customurl] ~= true and addedtolist[customurl] ~= true then
                table.insert(urls, { url=customurl })
              end
            end
          end
        end
        for customurl in string.gmatch(html, '%((http[s]?://[^%)]+)%)') do
          if string.match(customurl, "[^0-9]"..item_value.."[0-9][0-9]")
            or string.match(customurl, "/javascript/")
            or string.match(customurl, "/base_css/")
            or string.match(customurl, "/images/")
            or string.match(customurl, "/Silverlight/")
            or string.match(customurl, "/Stats/")
            or string.match(customurl, "/App_Themes/")
            or string.match(customurl, "/WebResource%.axd")
            or string.match(customurl, "/bprovideo/")
            or string.match(customurl, "/ScriptResource%.axd")
            or string.match(customurl, "/Screenshot%.ashx")
            or string.match(customurl, "silverlight%.dlservice%.microsoft%.com")
            or string.match(customurl, "/GameStatsHalo3%.aspx") then
            if not string.match(customurl, "[0-9]?"..item_value.."[0-9][0-9][0-9]")
              and not string.match(customurl, "PlayerStatsHalo3%.aspx%?player=")
              and not string.match(customurl, "/Stats/Halo3/Default%.aspx%?player=") then
              if downloaded[customurl] ~= true and addedtolist[customurl] ~= true then
                table.insert(urls, { url=customurl })
              end
            end
          end
        end
        for customurlnf in string.gmatch(html, '"(/[^"]+)"') do
          if string.match(customurlnf, "[^0-9]"..item_value.."[0-9][0-9]")
            or string.match(customurlnf, "/javascript/")
            or string.match(customurlnf, "/base_css/")
            or string.match(customurlnf, "/images/")
            or string.match(customurlnf, "/Silverlight/")
            or string.match(customurlnf, "/Stats/")
            or string.match(customurlnf, "/App_Themes/")
            or string.match(customurlnf, "/WebResource%.axd")
            or string.match(customurlnf, "/bprovideo/")
            or string.match(customurlnf, "/ScriptResource%.axd")
            or string.match(customurlnf, "/Screenshot%.ashx")
            or string.match(customurlnf, "/GameStatsHalo3%.aspx") then
            if not string.match(customurlnf, "[0-9]?"..item_value.."[0-9][0-9][0-9]")
              and not string.match(customurl, "PlayerStatsHalo3%.aspx%?player=")
              and not string.match(customurl, "/Stats/Halo3/Default%.aspx%?player=")  then
              local base = "http://halo.bungie.net"
              local customurl = base..customurlnf
              if downloaded[customurl] ~= true and addedtolist[customurl] ~= true then
                table.insert(urls, { url=customurl })
              end
            end
          end
        end
      end
    end
  end
  
  
  return urls
end
  

wget.callbacks.httploop_result = function(url, err, http_stat)
  -- NEW for 2014: Slightly more verbose messages because people keep
  -- complaining that it's not moving or not working
  local status_code = http_stat["statcode"]
  
  url_count = url_count + 1
  io.stdout:write(url_count .. "=" .. status_code .. " " .. url["url"] .. ".  \n")
  io.stdout:flush()
  
  if (status_code >= 200 and status_code <= 399) or status_code == 403 then
    if string.match(url.url, "https://") then
      local newurl = string.gsub(url.url, "https://", "http://")
      downloaded[newurl] = true
    else
      downloaded[url.url] = true
    end
  end
  
  if status_code >= 500 or
    (status_code >= 400 and status_code ~= 404 and status_code ~= 403) then
    io.stdout:write("\nServer returned "..http_stat.statcode..". Sleeping.\n")
    io.stdout:flush()

    os.execute("sleep 1")

    tries = tries + 1

    if tries >= 20 then
      io.stdout:write("\nI give up...\n")
      io.stdout:flush()
      return wget.actions.ABORT
    else
      return wget.actions.CONTINUE
    end
  elseif status_code == 0 then
    io.stdout:write("\nServer returned "..http_stat.statcode..". Sleeping.\n")
    io.stdout:flush()

    os.execute("sleep 10")

    tries = tries + 1

    if tries >= 10 then
      io.stdout:write("\nI give up...\n")
      io.stdout:flush()
      return wget.actions.ABORT
    else
      return wget.actions.CONTINUE
    end
  end

  tries = 0

  -- We're okay; sleep a bit (if we have to) and continue
  -- local sleep_time = 0.1 * (math.random(75, 1000) / 100.0)
  local sleep_time = 0

  --  if string.match(url["host"], "cdn") or string.match(url["host"], "media") then
  --    -- We should be able to go fast on images since that's what a web browser does
  --    sleep_time = 0
  --  end

  if sleep_time > 0.001 then
    os.execute("sleep " .. sleep_time)
  end

  return wget.actions.NOTHING
end
