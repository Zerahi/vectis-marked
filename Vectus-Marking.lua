---do combat log instead, gather group info with tank spec people
--mark people based on group, from combat log buff once four buffs, go out each cycle
-- add,warning if same person gets 2
-- auto assign group color initially, add config later
local addonName, VA = ...;


VA.f = CreateFrame("Frame", "CAmain", UIParent, "")
local BUFF = "Unending Breath"
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
			local name = AuraUtil.FindAuraByName(BUFF, sel)
			if name ~= nil then
				local cur = false;
				for i = 1, 4 do
					if groups[i][1] ~= nil then
						if AuraUtil.FindAuraByName(BUFF, groups[i][1]) == nil then
							SetRaidTarget(groups[i][1], 0);
							groups[i][1] = nil;
						end
					end
					if groups[i][1] ~= sel then cur = true;
				end
				
				if cur ~= true then
					SetRaidTarget(groups[i][1], mark[group]);
					-- break the loop once no groups have a [1] value
					-- if [0] doesn't belong in this group and their is a [1] in this group switch them and move the other
					-- if they both belong to the group move the new one
					while true do
						if groups[1][2] ~= nil then
							sort(1);
						elseif groups[2][2] ~= nil then
							sort(2);
						elseif groups[3][2] ~= nil then
							sort(3);
						elseif groups[4][2] ~= nil then
							sort(4);
						else
							break
						end
					end
				end
					--[[if groupMarks[group] == nil then
						if groupMarks[sel] ~= nil then
							groupMarks[sel] = nil;
						end
						groupMarks[group] = sel;
						SetRaidTarget(sel, mark[group]);
						print(mark[group]);
					elseif Raid_Info[groupMarks[group] ~= group then
						table.insert(missed, groupMarks[group]);
						groupMarks[group] = sel;
						SetRaidTarget(sel, mark[group]);
					else
						table.insert(missed, sel);
					end
					if missed[1] ~= nil then
						for i = 1, 4 do
							if groupMarks[i] == nil then
								groupMarks[i] = missed[1];
								print(groupMarks[i])
								print(mark[i])
								SetRaidTarget(groupMarks[i], mark[i]);
								table.remove(missed, 1)
								break
							end
						end
					end]]--
				end
			end
		end
	end
end
VA.f:SetScript( "OnEvent", VA.OnEvent)
VA.f:RegisterEvent("PLAYER_LOGIN")
VA.f:RegisterEvent("UNIT_AURA");
VA.f:RegisterEvent("GROUP_ROSTER_UPDATE");

function Unit_ID(grp)
	if Raid_Info[groups[grp][2]] == Raid_Info[groups[grp][1] then
		for i = 1, 4 do
			if groups[i][1] == nil then
				groups[i][1] = groups[grp][2]];
				table.remove(groups[grp], 2)
				break
			end
		end
	else
		if [Raid_Info[groups[grp][1]] ~= grp]
			local tmp = groups[grp][2]
			groups[grp][2] = groups[grp][1]
			groups[grp][1]
		else
			if groups[i][1] == nil then
				groups[i][1] = groups[grp][2]];
				break
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
