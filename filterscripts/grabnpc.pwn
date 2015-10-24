/*

			FILTERSCRIPT NPC
			
			     POR
			     
			   TRENICO
			   
*/

#include <a_samp>
#include <zcmd>

#define color_rojo 0xFF0000FF
#define color_blanco 0xFFFFFFFF
#define color_gris 0x5C5D5EFF

new bool:GrabandoNpc[MAX_PLAYERS];

public OnFilterScriptInit()
{
	print("||_____________________________||\n");
	print("        FILTERSCRIPT NPC\n");
	print("               POR\n");
	print("             TRENICO\n");
	print("||_____________________________||\n");
	return 1;
}

//_________comandos_________//

cmd(npcveh,playerid,params[])
{
	new nombre[30];
	if (IsPlayerAdmin(playerid))
	{
	    if (IsPlayerInAnyVehicle(playerid))
	    {
		    if (!sscanf(params,"s",nombre))
		    {
		        if (GrabandoNpc[playerid] == true) return SendClientMessage(playerid,color_rojo,"Ya estas grabando un npc, usa /npcparar para grabar otro!");
				if (strlen(nombre) > 30) return SendClientMessage(playerid,color_rojo,"El nombre del archivo npc no debe de ser de mas de 30 caracteres!");
                StartRecordingPlayerData(playerid,1,nombre);
                SendClientMessage(playerid,color_blanco,"Haz comenzado a grabar, para terminar usa /npcparar!");
                GrabandoNpc[playerid] = true;
			}
			else SendClientMessage(playerid,color_blanco,"Info: Usa /npcveh [nombre]");
		}
        else SendClientMessage(playerid,color_blanco,"Debes estar en un vehiculo para usar este comando!");
	}
	else SendClientMessage(playerid,color_blanco,"Debes ser admin rcon para usar este comando!");
	return 1;
}

cmd(npcpie,playerid,params[])
{
	new nombre[30];
	if (IsPlayerAdmin(playerid))
	{
	    if (!IsPlayerInAnyVehicle(playerid))
	    {
		    if (!sscanf(params,"s",nombre))
		    {
				if (GrabandoNpc[playerid] == true) return SendClientMessage(playerid,color_rojo,"Ya estas grabando un npc, usa /npcparar para grabar otro!");
				if (strlen(nombre) > 30) return SendClientMessage(playerid,color_rojo,"El nombre del archivo npc no debe de ser de mas de 30 caracteres!");
                StartRecordingPlayerData(playerid,2,nombre);
                SendClientMessage(playerid,color_blanco,"Haz comenzado a grabar, para terminar usa /npcparar!");
                GrabandoNpc[playerid] = true;
			}
			else SendClientMessage(playerid,color_blanco,"Info: Usa /npcpie [nombre]");
		}
        else SendClientMessage(playerid,color_blanco,"Debes estar a pie para usar este comando!");
	}
	else SendClientMessage(playerid,color_blanco,"Debes ser admin rcon para usar este comando!");
	return 1;
}

cmd(npcparar,playerid,params[])
{
	new nombre[30];
	if (IsPlayerAdmin(playerid))
	{
	    if (GrabandoNpc[playerid] == true)
	    {
			if (strlen(nombre) > 30) return SendClientMessage(playerid,color_rojo,"El nombre del archivo npc no debe de ser de mas de 30 caracteres!");
   			StopRecordingPlayerData(playerid);
      		SendClientMessage(playerid,color_blanco,"Haz terminado de grabar, busca tu archivo en scriptfiles!");
        	GrabandoNpc[playerid] = false;
		}
        else SendClientMessage(playerid,color_blanco,"No estas grabando un npc, usa /npcveh o /npcpie para grabar uno!");
	}
	else SendClientMessage(playerid,color_blanco,"Debes ser admin rcon para usar este comando!");
	return 1;
}

stock sscanf(str[], format[], {Float,_}:...)
{
	#if defined isnull
		if (isnull(str))
	#else
		if (str[0] == 0 || (str[0] == 1 && str[1] == 0))
	#endif
		{
			return format[0];
		}
	#pragma tabsize 4
	new
		formatPos = 0,
		stringPos = 0,
		paramPos = 2,
		paramCount = numargs(),
		delim = ' ';
	while (str[stringPos] && str[stringPos] <= ' ')
	{
		stringPos++;
	}
	while (paramPos < paramCount && str[stringPos])
	{
		switch (format[formatPos++])
		{
			case '\0':
			{
				return 0;
			}
			case 'i', 'd':
			{
				new
					neg = 1,
					num = 0,
					ch = str[stringPos];
				if (ch == '-')
				{
					neg = -1;
					ch = str[++stringPos];
				}
				do
				{
					stringPos++;
					if ('0' <= ch <= '9')
					{
						num = (num * 10) + (ch - '0');
					}
					else
					{
						return -1;
					}
				}
				while ((ch = str[stringPos]) > ' ' && ch != delim);
				setarg(paramPos, 0, num * neg);
			}
			case 'h', 'x':
			{
				new
					num = 0,
					ch = str[stringPos];
				do
				{
					stringPos++;
					switch (ch)
					{
						case 'x', 'X':
						{
							num = 0;
							continue;
						}
						case '0' .. '9':
						{
							num = (num << 4) | (ch - '0');
						}
						case 'a' .. 'f':
						{
							num = (num << 4) | (ch - ('a' - 10));
						}
						case 'A' .. 'F':
						{
							num = (num << 4) | (ch - ('A' - 10));
						}
						default:
						{
							return -1;
						}
					}
				}
				while ((ch = str[stringPos]) > ' ' && ch != delim);
				setarg(paramPos, 0, num);
			}
			case 'c':
			{
				setarg(paramPos, 0, str[stringPos++]);
			}
			case 'f':
			{
				setarg(paramPos, 0, _:floatstr(str[stringPos]));
			}
			case 'p':
			{
				delim = format[formatPos++];
				continue;
			}
			case '\'':
			{
				new
					end = formatPos - 1,
					ch;
				while ((ch = format[++end]) && ch != '\'') {}
				if (!ch)
				{
					return -1;
				}
				format[end] = '\0';
				if ((ch = strfind(str, format[formatPos], false, stringPos)) == -1)
				{
					if (format[end + 1])
					{
						return -1;
					}
					return 0;
				}
				format[end] = '\'';
				stringPos = ch + (end - formatPos);
				formatPos = end + 1;
			}
			case 'u':
			{
				new
					end = stringPos - 1,
					id = 0,
					bool:num = true,
					ch;
				while ((ch = str[++end]) && ch != delim)
				{
					if (num)
					{
						if ('0' <= ch <= '9')
						{
							id = (id * 10) + (ch - '0');
						}
						else
						{
							num = false;
						}
					}
				}
				if (num && IsPlayerConnected(id))
				{
					setarg(paramPos, 0, id);
				}
				else
				{
					#if !defined foreach
						#define foreach(%1,%2) for (new %2 = 0; %2 < MAX_PLAYERS; %2++) if (IsPlayerConnected(%2))
						#define __SSCANF_FOREACH__
					#endif
					str[end] = '\0';
					num = false;
					id = end - stringPos;
					new
						name[MAX_PLAYER_NAME];
					foreach (Player, playerid)
					{
					    GetPlayerName(playerid,name,sizeof(name));
						if(!strcmp(name,str[stringPos],true,id))
						{
							setarg(paramPos, 0, playerid);
							num = true;
							break;
						}
					}
					if (!num)
					{
						setarg(paramPos, 0, INVALID_PLAYER_ID);
					}
					str[end] = ch;
					#if defined __SSCANF_FOREACH__
						#undef foreach
						#undef __SSCANF_FOREACH__
					#endif
				}
				stringPos = end;
			}
			case 's', 'z':
			{
				new
					i = 0,
					ch;
				if (format[formatPos])
				{
					while ((ch = str[stringPos++]) && ch != delim)
					{
						setarg(paramPos, i++, ch);
					}
					if (!i)
					{
						return -1;
					}
				}
				else
				{
					while ((ch = str[stringPos++]))
					{
						setarg(paramPos, i++, ch);
					}
				}
				stringPos--;
				setarg(paramPos, i, '\0');
			}
			default:
			{
				continue;
			}
		}
		while (str[stringPos] && str[stringPos] != delim && str[stringPos] > ' ')
		{
			stringPos++;
		}
		while (str[stringPos] && (str[stringPos] == delim || str[stringPos] <= ' '))
		{
			stringPos++;
		}
		paramPos++;
	}
	do
	{
		if ((delim = format[formatPos++]) > ' ')
		{
			if (delim == '\'')
			{
				while ((delim = format[formatPos++]) && delim != '\'') {}
			}
			else if (delim != 'z')
			{
				return delim;
			}
		}
	}
	while (delim > ' ');
	return 0;
}

public OnPlayerConnect(playerid)
{
	GrabandoNpc[playerid] = false;
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	if (GrabandoNpc[playerid] == true)
	{
	    StopRecordingPlayerData(playerid);
	    SendClientMessage(playerid,color_blanco,"La grabacion del npc ha sido parada porque has abandonado el vehiculo!");
	}
	return 1;
}
