#include <sourcemod>
#include <sdktools>

#pragma semicolon 1
#pragma newdecls required

public Plugin myinfo = 
{
	name = "Wings Icon (CS2 Style)",
	author = "v0tekick",
	description = "Adds airborne icon (using noscope flag) to killfeed just like CS2",
	version = "1.0",
	url = "https://github.com/v0tekick/wingshx"
};

public void OnPluginStart()
{
	HookEvent("player_death", Event_PlayerDeath, EventHookMode_Pre);
}

public Action Event_PlayerDeath(Event event, const char[] name, bool dontBroadcast)
{
	int attacker = GetClientOfUserId(event.GetInt("attacker"));
	int victim = GetClientOfUserId(event.GetInt("userid"));
	
	// Skip if it's not a player or if it's self-kill
	if (attacker == 0 || attacker == victim)
	{
		return Plugin_Continue;
	}
	
	char weapon[64];
	event.GetString("weapon", weapon, sizeof(weapon));
	
	// Filter out utility weapons (grenades)
	if (StrEqual(weapon, "hegrenade", false) || 
		StrEqual(weapon, "flashbang", false) || 
		StrEqual(weapon, "smokegrenade", false) || 
		StrEqual(weapon, "molotov", false) || 
		StrEqual(weapon, "incgrenade", false) || 
		StrEqual(weapon, "decoy", false) ||
		StrEqual(weapon, "inferno", false)) // Molotov fire
	{
		return Plugin_Continue;
	}
	
	// Check if the attacker is in the air
	if (!(GetEntityFlags(attacker) & FL_ONGROUND))
	{
		// Set the 'noscope' flag.
		// NOTE: In CS:GO, this natively triggers the no-scope icon.
		// For a true CS2 experience, a custom HUD replacement for the icon is recommended.
		event.SetBool("noscope", true);
	}
	
	return Plugin_Changed;
}
