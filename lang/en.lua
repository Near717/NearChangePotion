local strings = {
	NEARCP_MESSAGE = 'Changed quickslot to',

	NEARCP_LAM_NAME = 'Setup name contains',
	NEARCP_LAM_SLOT = 'Slot to change to',
	NEARCP_LAM_CHANGEBACK = 'Change back on other setups',
	NEARCP_LAM_CHANGEBACKSLOT = 'Slot to change back to',
	NEARCP_LAM_SENDMESSAGE = 'Send message on change',
}

for stringId, stringValue in pairs(strings) do
	ZO_CreateStringId(stringId, stringValue)
	SafeAddVersion(stringId, 1)
end
