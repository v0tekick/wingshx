#include <sourcemod>
#include <sdktools>

#pragma semicolon 1
#pragma newdecls required

public Plugin myinfo = 
{
	name = "Wings Icon (CS2 Style)",
	author = "v0tekick",
	description = "Adds airborne wings icon to killfeed without replacing existing features",
	version = "1.1",
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
		// To add a brand new icon without replacing existing ones (like noscope),
		// we append a suffix to the weapon name.
		// The game will look for a custom icon named {weapon}_wings.svg
		char newWeapon[72];
		Format(newWeapon, sizeof(newWeapon), "%s_wings", weapon);
		event.SetString("weapon", newWeapon);
	}
	
	return Plugin_Changed;
}
