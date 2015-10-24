/*
*
*           -> First person system <-
*               by Aeronix (see fp_.pwn)
*
*  Changelog:
*    v1.1:
*       • Arreglado bug de desactivar FirstPerson.
*       • Mejorada la posición de la cámara.
*    v1.2:
*       • Agregada "DuckSync" (cuando estas agachado la cámara se baja)
*
*/


#include <a_samp>

#define PP_VERSION	"1.2"

new
	Object_FirstPerson[MAX_PLAYERS] = {INVALID_OBJECT_ID, ...},
	Float:CameraPos[MAX_PLAYERS][3];

forward DuckSync();

public OnFilterScriptInit()
{
	SetTimer("DuckSync", 50, true);
	
	//Load
	printf("========================================================\n\n");
	printf("    - First person system (v"PP_VERSION") by Spell loaded!  ");
	printf("\n\n========================================================");
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	if(Object_FirstPerson[playerid] != INVALID_OBJECT_ID)
	{
	    DestroyObject(Object_FirstPerson[playerid]);
	    Object_FirstPerson[playerid] = INVALID_OBJECT_ID;
	}
	return 1;
}
public OnPlayerCommandText(playerid, cmdtext[])
{
	if(strfind(cmdtext, "/primerapersona", true) == 0)
	{
		if(GetPVarInt(playerid,"PP_ON") == 1)
		{
			if(Object_FirstPerson[playerid] != INVALID_OBJECT_ID)
			{
			    DestroyObject(Object_FirstPerson[playerid]);
			    Object_FirstPerson[playerid] = INVALID_OBJECT_ID;
			}

			DeletePVar(playerid,"PP_ON");
			SetCameraBehindPlayer(playerid);
		}
		else
		{
			if(Object_FirstPerson[playerid] != INVALID_OBJECT_ID)
			{
			    DestroyObject(Object_FirstPerson[playerid]);
			}

			Object_FirstPerson[playerid] = CreateObject(19300, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);

		    CameraPos[playerid][0] = 0.0;
		    CameraPos[playerid][1] = 0.15;
		    CameraPos[playerid][2] = 0.65;

			if(!IsPlayerInAnyVehicle(playerid))
				UpdateCamera(playerid);
				
			SetPVarInt(playerid,"PP_ON",1);
		}
	    return 1;
	}
	return 0;
}

public DuckSync()
{
	for(new playerid; playerid < MAX_PLAYERS; playerid++)
	{
	    if(IsPlayerConnected(playerid) && !IsPlayerNPC(playerid))
	    {
	        if(!IsPlayerInAnyVehicle(playerid))
	        {
				if(GetPVarInt(playerid,"PP_ON"))
				{
				    new
						Float: Pos[3], Float: CamPos[3];
				        
					GetPlayerPos(playerid, Pos[0], Pos[1], Pos[2]);
					GetPlayerCameraFrontVector(playerid, CamPos[0], CamPos[1], CamPos[2]);
					
					CamPos[0] = Pos[0] + (CamPos[0]*3);
					CamPos[1] = Pos[1] + (CamPos[1]*3);
					CamPos[2] = Pos[2] + (CamPos[2]*3);

					new
					    Float: Angle = floatabs(360.0-atan2(Pos[0]-CamPos[0], Pos[1]-CamPos[1]));
					    
					Angle -= 180.0;
					
					SetPlayerFacingAngle(playerid, Angle);
					
		            if(GetPlayerSpecialAction(playerid) & SPECIAL_ACTION_DUCK && GetPlayerState(playerid) != 5 && GetPlayerState(playerid) != 6)
		            {
		                if(CameraPos[playerid][2] != 0.0)
		                {
		                    CameraPos[playerid][2] = 0.0;
		                    UpdateCamera(playerid);
						}
					}
					else
					{
		                if(CameraPos[playerid][2] == 0.0)
		                {
		                    CameraPos[playerid][2] = 0.65;
		                    UpdateCamera(playerid);
						}
					}
				}
			}
		}
	}
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(GetPVarInt(playerid,"PP_ON") == 1)
	{
		if(IsPlayerInAnyVehicle(playerid))
			SetCameraBehindPlayer(playerid);
		else
			UpdateCamera(playerid);
	}
	return 1;
}

public OnPlayerSpawn(playerid)
{
	if(GetPVarInt(playerid,"PP_ON") == 1)
	{
		UpdateCamera(playerid);
	}
	return 1;
}

stock UpdateCamera(playerid)
{
	AttachObjectToPlayer(Object_FirstPerson[playerid], playerid, CameraPos[playerid][0], CameraPos[playerid][1], CameraPos[playerid][2], 0.0, 0.0, 0.0);
	AttachCameraToObject(playerid, Object_FirstPerson[playerid]);
	return 1;
}
