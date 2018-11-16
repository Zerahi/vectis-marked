local addonName, VA = ...;


VA.f = CreateFrame("Frame", "CAmain", UIParent, "")
local BUFF = "Omega Vector"
local raiders = { };
local Raid_Info = { };
local group1 = { };
local group2 = { };
local group3 = { };
local group4 = { };
local groups = {group1, group2, group3, group4}
local mark = {1,2,3,4};


function VA.OnEvent(frame, event, ...)
	if event == "PLAYER_LOGIN" or event == "GROUP_ROSTER_UPDATE" then
		Unit_ID();
	elseif event == "UNIT_AURA" then
		local sel = UnitName(select(1, ...));
		local group = Raid_Info[UnitName(sel)];
		if group ~= nil then
			local cur = false;
			for i = 1, 4 do
				if groups[i][1] ~= nil then
					if AuraUtil.FindAuraByName(BUFF, groups[i][1], "HARMFUL") == nil then
						SetRaidTarget(groups[i][1], 0);
						groups[i][1] = nil;
					end
				end
				if groups[i][1] == sel then
					cur = true;
				end
			end
			local name = AuraUtil.FindAuraByName(BUFF, sel, "HARMFUL")
			if name ~= nil then
				if cur ~= true then
					table.insert(groups[group], sel)
					while true do
						if groups[1][2] ~= nil then
							srt(1);
						elseif groups[2][2] ~= nil then
							srt(2);
						elseif groups[3][2] ~= nil then
							srt(3);
						elseif groups[4][2] ~= nil then
							srt(4);
						else
							break
						end
					end
					for i = 1, 4 do
						if groups[i][1] ~= nil then
							SetRaidTarget(groups[i][1], mark[i]);
						end
					end
				end
			end
		end
	end
end
VA.f:SetScript( "OnEvent", VA.OnEvent)
VA.f:RegisterEvent("PLAYER_LOGIN");
VA.f:RegisterEvent("UNIT_AURA");
VA.f:RegisterEvent("GROUP_ROSTER_UPDATE");

function srt(grp)
	if Raid_Info[groups[grp][2]] == Raid_Info[groups[grp][1]] then
		for i = 1, 4 do
			if groups[i][1] == nil then
				groups[i][1] = groups[grp][2];
				table.remove(groups[grp], 2)
				break
			end
		end
	else
		if Raid_Info[groups[grp][1]] ~= grp then
			local tmp = groups[grp][2]
			groups[grp][2] = groups[grp][1]
			groups[grp][1] = tmp
		else
			for i = 1, 4 do
				if groups[i][1] == nil then
					groups[i][1] = groups[grp][2];
					table.remove(groups[grp], 2)
					break
				end
			end
		end
	end
end

function Unit_ID()
	raiders = table.wipe(raiders);

	for i = 1, 41 do
		local name, rank, subgroup, level, class, fileName, zone, online, isDead, role, isML = GetRaidRosterInfo(i)
		raiders[i] = "raid"..i;
		local unitname = UnitName(raiders[i]);
		
		if unitname ~= nil and unitname ~= "Unknown" then
			Raid_Info[unitname] = { };
			Raid_Info[unitname] = subgroup;
		end
	end
end
