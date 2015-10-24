/* First Person Include
 *
 * (c) Copyright 2012, Aeronix (Jack_Wilson)
 * This file is not to be redistributed for any reason, or resold.
 *
 * native SyncCamera(playerid);
 * native ToggleThirdPerson(playerid);
 * native SetThirdPerson(playerid);
 * native GetViewMode(playerid);
 *
 */

#include <a_samp>

#if defined _FirstPerson_included
	#endinput
#endif

#define	MODE_THIRDPERSON	1
#define	MODE_FIRSTPERSON	2

new CameraFirstPerson[MAX_PLAYERS];

public OnPlayerConnect(playerid)
{
	CameraFirstPerson[playerid] = CreateObject(19300, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	DestroyObject(CameraFirstPerson[playerid]);
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	SyncCamera(playerid);
}

public OnPlayerSpawn(playerid)
{
	SyncCamera(playerid);
}

public SyncCamera(playerid)
{
	if(GetPVarInt(playerid, "DisableFPS") == 0)
	{
		if(!IsPlayerInAnyVehicle(playerid))
		{
			AttachObjectToPlayer(CameraFirstPerson[playerid], playerid, 0.0, 0.15, 0.65, 0.0, 0.0, 0.0);
			AttachCameraToObject(playerid, CameraFirstPerson[playerid]);
		}
		else
		{
			SetCameraBehindPlayer(playerid);
		}
	}
	return 1;
}

public SetThirdPerson(playerid, status)
{
	if(status)
	{
		SetPVarInt(playerid, "DisableFPS", 1);
		SetCameraBehindPlayer(playerid);
	}
	else if(!status)
	{
	    DeletePVar(playerid, "DisableFPS");
		SyncCamera(playerid);
	}
}

public ToggleThirdPerson(playerid)
{
	if(GetPVarInt(playerid, "DisableFPS") == 0)
	{
		SetPVarInt(playerid, "DisableFPS", 1);
		SetCameraBehindPlayer(playerid);
	}
	else
	{
	    DeletePVar(playerid, "DisableFPS");
		SyncCamera(playerid);
	}
}

public GetViewMode(playerid)
{
	if(GetPVarInt(playerid, "DisableFPS") == 0)
	{
		return MODE_FIRSTPERSON;
	}
	else
	{
		return MODE_THIRDPERSON;
	}
}

forward SyncCamera(playerid);
forward CheckCameraPosition(playerid);
forward ToggleThirdPerson(playerid);
forward SetThirdPerson(playerid);
forward GetViewMode(playerid);
