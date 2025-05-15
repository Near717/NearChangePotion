NearChangePotion = {
	name = 'NearChangePotion',
	title = "Near's Change Potion",
	author = "|cCC99FFnotnear|r",
	defaults = {
		slot = 3,
		name = 'mudar pot',
		changeback = false,
		changebackSlot = 4,
		sendMessage = true,
	},
}

local addon = NearChangePotion

local function SendMessage(slot)
	if addon.ASV.sendMessage then
		d(string.format("[Change Potion]: %s %s", GetString(NEARCP_MESSAGE), tostring(slot)))
	end
end

local function Init()
	ZO_PostHook(WizardsWardrobe.gui, 'SetPanelText', function (zoneTag, pageName, setupName)
		local sv = addon.ASV
		setupName = setupName:lower()

		if string.find(setupName, sv.name) then
			SetCurrentQuickslot(sv.slot)
			SendMessage(sv.slot)
		elseif sv.changeback then
			SetCurrentQuickslot(sv.changebackSlot)
			SendMessage(sv.changebackSlot)
		end
	end)
end

local function SetupSettings()
	local LAM2 = LibAddonMenu2
	local sv = addon.ASV

	local panelData = {
		type = 'panel',
		name = addon.title,
		displayName = addon.title,
		author = addon.author,
		slashCommand = '/changepotion',
		registerForRefresh	= true,
		registerForDefaults	= true,
	}
	LAM2:RegisterAddonPanel(addon.name, panelData)

	local optionsTable = {}
	local slots = {1, 2, 3, 4, 5, 6, 7, 8}

	optionsTable[#optionsTable + 1] = {
		type = 'editbox',
		name = GetString(NEARCP_LAM_NAME),
		getFunc = function() return sv.name end,
		setFunc = function(v) sv.name = v:lower() end,
		isMultiline = false,
		default = addon.defaults.name,
	}

	optionsTable[#optionsTable+1] = {
		type = 'dropdown',
		name = GetString(NEARCP_LAM_SLOT),
		choices = slots,
		getFunc = function() return sv.slot end,
		setFunc = function(v) sv.slot = v end,
		default = addon.defaults.slot,
	}

	optionsTable[#optionsTable+1] = {
		type = 'checkbox',
		name = GetString(NEARCP_LAM_CHANGEBACK),
		getFunc = function() return sv.changeback end,
		setFunc = function(v) sv.changeback = v end,
		default = addon.defaults.changeback,
	}

	optionsTable[#optionsTable+1] = {
		type = 'dropdown',
		name = GetString(NEARCP_LAM_CHANGEBACKSLOT),
		choices = slots,
		getFunc = function() return sv.changebackSlot end,
		setFunc = function(v) sv.changebackSlot = v end,
		default = addon.defaults.changebackSlot,
		disabled = function() return not sv.changeback end,
	}

	optionsTable[#optionsTable+1] = {
		type = 'checkbox',
		name = GetString(NEARCP_LAM_SENDMESSAGE),
		getFunc = function() return sv.sendMessage end,
		setFunc = function(v) sv.sendMessage = v end,
		default = addon.defaults.sendMessage,
	}

	LAM2:RegisterOptionControls(addon.name, optionsTable)
end

local function OnAddonLoaded(_, name)
	if name ~= addon.name then return end
	EVENT_MANAGER:UnregisterForEvent(addon.name, EVENT_ADD_ON_LOADED)

	addon.ASV = ZO_SavedVars:NewAccountWide(addon.name .. "_Data", 1, nil, addon.defaults)

	SetupSettings()
	Init()
end

EVENT_MANAGER:RegisterForEvent(addon.name, EVENT_ADD_ON_LOADED, OnAddonLoaded)
