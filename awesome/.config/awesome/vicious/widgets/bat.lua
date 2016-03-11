---------------------------------------------------
-- Licensed under the GNU General Public License v2
--  * (c) 2010, Adrian C. <anrxc@sysphere.org>
--  * (c) 2013, NormalRa  <normalrawr@gmail.com>
---------------------------------------------------
-- Modified by: spcmd
---------------------------------------------------

-- {{{ Grab environment
local tonumber = tonumber
local setmetatable = setmetatable
local string = { format = string.format }
local helpers = require("vicious.helpers")
local math = {
    min = math.min,
    floor = math.floor
}
-- }}}


-- Bat: provides state, charge, remaining time, and wear for a requested battery
-- vicious.widgets.bat
local bat = {}


-- {{{ Battery widget type
local function worker(format, warg)
    if not warg then return end

    -- symbols (unicode and fontawesome ttf): ⌁ ↯ ⚡  
    --local bat_charging = "<span color='#55BF47' weight='bold'> </span>"
    --local bat_discharging = " "
    --local bat_discharging = "<span color='#d90000' weight='bold'> </span>"
    --local bat_full = " "

    local bat_charging = widget_separator.." Charging: </span>"
    local bat_discharging = widget_separator.." Bat: "
    local bat_full = widget_separator.." Bat: "

    local battery = helpers.pathtotable("/sys/class/power_supply/"..warg)
    local battery_state = {
        ["Full\n"]        = bat_full,
        ["Unknown\n"]     = "",
        ["Charged\n"]     = "",
        ["Charging\n"]    = bat_charging,
        ["Discharging\n"] = bat_discharging
    }

    -- Check if the battery is present
    if battery.present ~= "1\n" then
        return {battery_state["Unknown\n"], 0, "N/A", 0}
    end


    -- Get state information
    local state = battery_state[battery.status] or battery_state["Unknown\n"]

    -- Get capacity information
    if battery.charge_now then
        remaining, capacity = battery.charge_now, battery.charge_full
        capacity_design = battery.charge_full_design or capacity
    elseif battery.energy_now then
        remaining, capacity = battery.energy_now, battery.energy_full
        capacity_design = battery.energy_full_design or capacity
    else
        return {battery_state["Unknown\n"], 0, "N/A", 0}
    end

    -- Calculate capacity and wear percentage (but work around broken BAT/ACPI implementations)
    local percent = math.min(math.floor(remaining / capacity * 100), 100)
    local wear = math.floor(100 - capacity / capacity_design * 100)


    -- Get charge information
    if battery.current_now then
        rate = tonumber(battery.current_now)
    elseif battery.power_now then
        rate = tonumber(battery.power_now)
    else
        return {state, percent, "N/A", wear}
    end

    -- Calculate remaining (charging or discharging) time
    local time = "fully charged"

    if rate ~= nil and rate ~= 0 then
        if state == bat_charging then
            timeleft = (tonumber(capacity) - tonumber(remaining)) / tonumber(rate)
        elseif state == bat_discharging then
            timeleft = tonumber(remaining) / tonumber(rate)
        else
            return {state, percent, time, wear}
        end

        -- Calculate time
        local hoursleft   = math.floor(timeleft)
        local minutesleft = math.floor((timeleft - hoursleft) * 60 )

        time = string.format("%02d:%02d", hoursleft, minutesleft)
    end
    
    -- Colorize percentage depending on the battery level
    if state == bat_discharging and percent <= 20 then
        percent = "<span color='#FF3B3B' weight='bold'>" .. percent .. "%%</span>"
    elseif state == bat_discharging and percent <= 30 then
        percent = "<span color='#FFE490' weight='bold'>" .. percent .. "%%</span>"
    else
       percent = percent .. "%%"
    end

    return {state, percent, time, wear}
end
-- }}}

return setmetatable(bat, { __call = function(_, ...) return worker(...) end })
