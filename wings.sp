#include <sourcemod>
#include <sdktools>

#pragma semicolon 1
#pragma newdecls required

public Plugin myinfo = 
{
	name = "Wings Icon (CS2 Style)",
	author = "v0tekick",
	description = "Adds airborne wings icon to killfeed and handles file downloads",
	version = "1.2",
	url = "https://github.com/v0tekick/wingshx"
};

char g_sWeaponIcons[54][32] = {
	"ak47", "m4a1", "m4a1_silencer", "awp", "ssg08", "deagle", "usp_silencer", "glock", "p250", 
	"fiveseven", "tec9", "cz75a", "revolver", "galilar", "famas", "aug", "sg556", "g3sg1", 
	"scar20", "mac10", "mp9", "mp7", "mp5sd", "ump45", "p90", "bizon", "nova", "xm1014", 
	"mag7", "sawedoff", "m249", "negev", "taser", "knife", "knifegg", "knife_t", "knife_karambit", 
	"knife_m9_bayonet", "knife_butterfly", "knife_falchion", "knife_flip", "knife_gut", 
	"knife_tactical", "knife_shadow_dagger", "knife_survival_bowie", "knife_ursus", 
	"knife_gypsy_jackknife", "knife_stiletto", "knife_widowmaker", "knife_canis", 
	"knife_cord", "knife_skeleton", "knife_outdoor", "knife_css"
};

public void OnPluginStart()
{
	HookEvent("player_death", Event_PlayerDeath, EventHookMode_Pre);
}

public void OnMapStart()
{
	char sPath[PLATFORM_MAX_PATH];
	for (int i = 0; i < sizeof(g_sWeaponIcons); i++)
	{
		// Note: The game engine expects paths relative to the 'csgo' directory,
		// but for AddFileToDownloadsTable to work with your specific structure,
		// we use the 'panorama/...' path which should be mirrored on FastDL.
		Format(sPath, sizeof(sPath), "panorama/images/icons/equipment/%s_wings.svg", g_sWeaponIcons[i]);
		
		// We check for the file in the 'csgo/panorama/...' path on the server
		char sFullServerPath[PLATFORM_MAX_PATH];
		Format(sFullServerPath, sizeof(sFullServerPath), "csgo/%s", sPath);
		
		if (FileExists(sFullServerPath))
		{
			AddFileToDownloadsTable(sFullServerPath);
		}
	}
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
