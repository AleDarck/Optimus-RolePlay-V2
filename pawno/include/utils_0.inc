/*

						- INCLUDE: UTILS_0

				� UTILIZADO EXCLUSIVAMENTE PARA BESTZONE �
	
*/


#define DIFERENCIA_HORARIA 0

stock _InterpolateCameraPos(playerid, Float:oldx,Float:oldy,Float:oldz, Float:x,Float:y,Float:z, time, cut = CAMERA_MOVE)
{
	SetPVarFloat(playerid, "CAMERAPOS_X", x);
	SetPVarFloat(playerid, "CAMERAPOS_Y", y);
	SetPVarFloat(playerid, "CAMERAPOS_Z", z);
	return InterpolateCameraPos(playerid, oldx,oldy,oldz, x,y,z, time, cut);
}

stock _SetPlayerCameraPos(playerid, Float:x,Float:y,Float:z)
{
	SetPVarFloat(playerid, "CAMERAPOS_X", x);
	SetPVarFloat(playerid, "CAMERAPOS_Y", y);
	SetPVarFloat(playerid, "CAMERAPOS_Z", z);
	return SetPlayerCameraPos(playerid, x,y,z);
}

stock InterpolateCameraPos_(playerid, Float:x,Float:y,Float:z, time,cut = CAMERA_MOVE)
{
	new
		Float:x_ = GetPVarFloat(playerid, "CAMERAPOS_X"),
		Float:y_ = GetPVarFloat(playerid, "CAMERAPOS_Y"),
		Float:z_ = GetPVarFloat(playerid, "CAMERAPOS_Z");

	return _InterpolateCameraPos(playerid, x_, y_, z_, x, y, z, time, cut);
}



stock _SetPlayerCameraLookAt(playerid, Float:x,Float:y,Float:z)
{
	SetPVarFloat(playerid, "CAMERALOOK_X", x);
	SetPVarFloat(playerid, "CAMERALOOK_Y", y);
	SetPVarFloat(playerid, "CAMERALOOK_Z", z);
	return SetPlayerCameraLookAt(playerid, x,y,z);
}

stock _InterpolateCameraLookAt(playerid, Float:oldx,Float:oldy,Float:oldz, Float:x,Float:y,Float:z, time, cut = CAMERA_MOVE)
{
	SetPVarFloat(playerid, "CAMERALOOK_X", x);
	SetPVarFloat(playerid, "CAMERALOOK_Y", y);
	SetPVarFloat(playerid, "CAMERALOOK_Z", z);
	return InterpolateCameraLookAt(playerid, oldx,oldy,oldz, x,y,z, time, cut);
}

stock InterpolateCameraLookAt_(playerid, Float:x,Float:y,Float:z, time,cut = CAMERA_MOVE)
{
	new
		Float:x_ = GetPVarFloat(playerid, "CAMERALOOK_X"),
		Float:y_ = GetPVarFloat(playerid, "CAMERALOOK_Y"),
		Float:z_ = GetPVarFloat(playerid, "CAMERALOOK_Z");

	return _InterpolateCameraLookAt(playerid, x_, y_, z_, x, y, z, time, cut);
}


stock _AddStaticVehicleEx(id,Float:x,Float:y,Float:z,Float:rot,c1,c2,respawn=HORAS_RVEH)
{
	return AddStaticVehicleEx(id,x,y,z,rot,c1,c2,respawn);
}

stock AddVehicleComponentEx(vehid,componentid)
{
	OnVehicleMod(INVALID_PLAYER_ID,vehid,componentid);
	return AddVehicleComponent(vehid,componentid);
}

stock _ChangeVehicleColor(vehid,c1,c2)
{
	ChangeVehicleColor(vehid,c1,c2);
	OnVehicleRespray(INVALID_PLAYER_ID,vehid,c1,c2);
	return 1;
}

stock _SetPlayerTime(playerid, time_0, time_1)
{
	time_0 += DIFERENCIA_HORARIA;
	return SetPlayerTime(playerid, time_0, time_1);
}

stock _SetWorldTime( time )
{
	time += DIFERENCIA_HORARIA;
	return SetWorldTime( time );
}

stock _TextDrawSetString(Text:Text_ID, text[])
{
	for(new i; i < strlen(text); i++)
	{
		switch(text[i])
	 	{
	  		case '�', '�': text[i] = '�';
	    	case '�', '�': text[i] = '�';
	     	case '�', '�': text[i] = '�';
	        case '�', '�': text[i] = '�';
	        case '�', '�': text[i] = '�';
	        case '�', '�': text[i] = '�';
	        case '�': text[i] = '�';
	        case '�': text[i] = '^';
		}
	}
	
	return TextDrawSetString(Text_ID, text);
}

stock _PlayerTextDrawSetString(playerid, PlayerText:Text_ID, text[])
{
	for(new i; i < strlen(text); i++)
	{
		switch(text[i])
	 	{
	  		case '�', '�': text[i] = '�';
	    	case '�', '�': text[i] = '�';
	     	case '�', '�': text[i] = '�';
	        case '�', '�': text[i] = '�';
	        case '�', '�': text[i] = '�';
	        case '�', '�': text[i] = '�';
	        case '�': text[i] = '�';
	        case '�': text[i] = '^';
		}
	}
	
	return PlayerTextDrawSetString(playerid, Text_ID, text);
}

stock MensajeLargo(playerid, color, const message[])
{
	new
	    len = strlen(message);
	    
	if(len >= 100)
	{
	    new
	        Part1[105];
	        
		strmid(Part1, message, 0, 100);
		strcat(Part1, "...");
		
		SendClientMessage(playerid, color, Part1);

		strmid(Part1, message, 100, len);
		strins(Part1, "...", 0);

		SendClientMessage(playerid, color, Part1);
		return 1;
	}
	return SendClientMessage(playerid, color, message);
}
		
#if defined _ALS_SetPlayerCheckpoint
	#undef SetPlayerCheckpoint
#else
	#define _ALS_SetPlayerCheckpoint
#endif

#define SetPlayerCheckpoint 	_2SetPlayerCheckpoint

#if defined _ALS_DisablePlayerCheckpoint
	#undef DisablePlayerCheckpoint
#else
	#define _ALS_DisablePlayerCheckpoint
#endif

#define DisablePlayerCheckpoint _DisablePlayerCheckpoint

#if defined _ALS_AddStaticVehicleEx
	#undef AddStaticVehicleEx
#else
	#define _ALS_AddStaticVehicleEx
#endif

#define AddStaticVehicleEx _AddStaticVehicleEx

#if defined _ALS_ChangeVehicleColor
	#undef ChangeVehicleColor
#else
	#define _ALS_ChangeVehicleColor
#endif

#define ChangeVehicleColor _ChangeVehicleColor

#if defined _ALS_SetPlayerTime
	#undef SetPlayerTime
#else
	#define _ALS_SetPlayerTime
#endif

#define SetPlayerTime 	_SetPlayerTime

#if defined _ALS_SetWorldTime
	#undef SetWorldTime
#else
	#define _ALS_SetWorldTime
#endif

#define SetWorldTime 	_SetWorldTime

#if defined _ALS_TextDrawSetString
	#undef TextDrawSetString
#else
	#define _ALS_TextDrawSetString
#endif

#define TextDrawSetString 	_TextDrawSetString

#if defined _ALS_PlayerTextDrawSetString
	#undef PlayerTextDrawSetString
#else
	#define _ALS_PlayerTextDrawSetString
#endif

#define PlayerTextDrawSetString 	_PlayerTextDrawSetString

#if defined _ALS_InterpolateCameraLookAt
	#undef InterpolateCameraLookAt
#else
	#define _ALS_InterpolateCameraLookAt
#endif

#define InterpolateCameraLookAt 	_InterpolateCameraLookAt

#if defined _ALS_SetPlayerCameraLookAt
	#undef SetPlayerCameraLookAt
#else
	#define _ALS_SetPlayerCameraLookAt
#endif

#define SetPlayerCameraLookAt 	_SetPlayerCameraLookAt

#if defined _ALS_InterpolateCameraPos
	#undef InterpolateCameraPos
#else
	#define _ALS_InterpolateCameraPos
#endif

#define InterpolateCameraPos 	_InterpolateCameraPos

#if defined _ALS_SetPlayerCameraPos
	#undef SetPlayerCameraPos
#else
	#define _ALS_SetPlayerCameraPos
#endif

#define SetPlayerCameraPos 	_SetPlayerCameraPos

#define InterpolateCameraPos 	_InterpolateCameraPos
