/*
	# Sistema de estado

	* No necesitas ningún include especial, aún asi el script está totalmente optimizado.
	
	Creado por Spell

*/

#include    <a_samp>

new
	MSG_String[120],
	Text3D:LABEL_Estado[MAX_PLAYERS] = {Text3D:INVALID_3DTEXT_ID, ...};

#define DRAW_DISTANCE   20.0 // Metros a los que el texto se verá.

public OnFilterScriptInit()
{
	printf("\n----------------------------------");
	print("Sistema de estado fue cargado correctamente.");
	printf("Por Spell\n----------------------------------\n");
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	#pragma unused reason

	if(LABEL_Estado[playerid] != Text3D:INVALID_3DTEXT_ID)
	{
		Delete3DTextLabel(LABEL_Estado[playerid]);
		LABEL_Estado[playerid] = Text3D:INVALID_3DTEXT_ID;
	}
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	if(strfind(cmdtext,"/estado", true) == 0)
	{
 		new
			Params[120];

		strmid(Params, cmdtext, 8, strlen(cmdtext), 128);

		if(TieneNumeros(Params)) return SendClientMessage(playerid, -1, "No puedes poner números en tu estado.");
		if(((Params[0] == 0) || (Params[0] == 1 && Params[1] == 0)))
		{
			return
				SendClientMessage(playerid,-1, "Utiliza: {FF0000}/estado <Texto> {FFFFFF}| {FF0000}/estado Off");
		}

		if(!strcmp(Params, "Off", true))
		{
			if(LABEL_Estado[playerid] != Text3D:INVALID_3DTEXT_ID)
			{
				Delete3DTextLabel(LABEL_Estado[playerid]);
				LABEL_Estado[playerid] = Text3D:INVALID_3DTEXT_ID;
				SendClientMessage(playerid, -1, "Tu estado fue borrado.");
				return 1;
			}
			return
				SendClientMessage(playerid,-1, "¡No tienes un estado!");
		}

		if(LABEL_Estado[playerid] != Text3D:INVALID_3DTEXT_ID)
		{
			format(MSG_String, 120, "Estado: {0B79C3}%s", Params);
			Update3DTextLabelText(LABEL_Estado[playerid], 0xFFFFFFFF, MSG_String);
			format(MSG_String, 120, "* Estado actualizado a: \"{0B79C3}%s\"", Params);
			SendClientMessage(playerid, 0xFFFFFFFF , MSG_String);
			return 1;
		}

		format(MSG_String, 120, "Estado: {0B79C3}%s", Params);
		SendClientMessage(playerid, 0xFFFFFFFF , MSG_String);
		LABEL_Estado[playerid] = Create3DTextLabel(MSG_String, 0xFFFFFFFF, 0.0, 0.0, 0.0, DRAW_DISTANCE, 1);
		Attach3DTextLabelToPlayer(LABEL_Estado[playerid], playerid, 0.0, 0.0, 0.40);

		return 1;
	}
	return 0;
}

stock TieneNumeros(str[])
{
	for(new i, j = strlen(str); i < j; i++)
	{
		if(str[i] >= '0' && str[i] <= '9') return 1;
	}
	return 0;
}

