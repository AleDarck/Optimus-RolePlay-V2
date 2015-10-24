/*


** -Test del sistema de vehículos Optimus RolePlay


		> Spell.
		
*/

#include <a_samp>
#include <YSI\y_ini>
#include <foreach>

native IsValidVehicle(vehicleid);

#define MAX_VEH_JUGADOR     			(5) // Cantidad máxima de vehículos por jugador
#define MAX_VEH_MODS        			(12)// Capacidad de Mods (Componentes). Dejar así..
#define MAX_MINS_DESTROY_VEH    		(5) // Minutos a esperar para que el vehículo se destruya cuando el dueño se desconecta.
#define MINS_AGREGADOS_POR_ACTIVIDAD    (2) // Cantidad de minutos a sumar de auto en server cuando el auto se va a destuir, pero hay alguien dentro.

enum E_VEH_GENERAL
{
	vehFamilia,
	bool:vehVenta,
	vehDueno[MAX_PLAYER_NAME],
	bool:vehDuenoOn,
	vehTiempoOff
}

enum E_VEH_JUGADOR
{
	vModel,
	Float: vPos_x,
	Float: vPos_y,
	Float: vPos_z,
	Float: vAngle,
	vColor_1,
	vColor_2,
	vFamilia
}

new
	PlayerVehData[MAX_PLAYERS][MAX_VEH_JUGADOR][E_VEH_JUGADOR],
	PlayerVehMods[MAX_PLAYERS][MAX_VEH_JUGADOR][MAX_VEH_MODS],
	PlayerVehID[MAX_PLAYERS][MAX_VEH_JUGADOR],
	Veh[MAX_VEHICLES][E_VEH_GENERAL];
	
public OnPlayerConnect(playerid)
{
	for(new a; a < MAX_VEH_JUGADOR; a++)
	{
		for(new i; E_VEH_JUGADOR: i < E_VEH_JUGADOR; i++)
		{
		    PlayerVehData[playerid][a][E_VEH_JUGADOR: i] = _:0;
		}
		for(new i; i < MAX_VEH_MODS; i++)
		{
			PlayerVehMods[playerid][a][i] = 0;
		}
		PlayerVehID[playerid][a] = 0;
	}
	return 1;
}

public OnGameModeInit()
{
	SetTimer("CheckOldVehicles", 60000, true);
	return 1;
}

forward CheckOldVehicles();
public CheckOldVehicles()
{
	printf("[VehícleSystem.pwn] CheckOldVehicles()");
	
	for(new i; i < MAX_VEHICLES; i++)
	{
	    if(Veh[i][vehVenta])
	    {
		    if(Veh[i][vehDuenoOn] == false)
		    {
		        Veh[i][vehTiempoOff] ++;
				printf("[VehícleSystem.pwn] Vehículo ID: %d | Se le sumó un minuto de inactividad (total: %d)", i, Veh[i][vehTiempoOff]);
		        if(Veh[i][vehTiempoOff] >= MAX_MINS_DESTROY_VEH)
		        {
		            DestroyOwnedVehicle(i);
				}
		    }
		}
	}
	return 1;
}

stock DestroyOwnedVehicle(vehid)
{
	foreach(Player, i)
	{
	    if(GetPlayerVehicleID(i) == vehid)
	    {
	        Veh[i][vehTiempoOff] -= MINS_AGREGADOS_POR_ACTIVIDAD;
	        return 1;
		}
	}
	
	DestroyVehicle(vehid);
	
	for(new i; E_VEH_GENERAL: i < E_VEH_GENERAL; i++)
	    Veh[vehid][E_VEH_GENERAL: i] = _:0;

	printf("[VehícleSystem.pwn] Vehículo ID: %d destruido por %d minutos de inactividad del dueño.", vehid, MAX_MINS_DESTROY_VEH);
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	for(new i; i < MAX_VEH_JUGADOR; i++)
	{
		if(PlayerVehID[playerid][i] != 0)
		{
		    Veh[PlayerVehID[playerid][i]][vehDuenoOn] = false;
		    Veh[PlayerVehID[playerid][i]][vehTiempoOff] = 0;
			printf("[VehícleSystem.pwn] Vehículo ID: %d | Dueño se desconectó (index: %d)", PlayerVehID[playerid][i], i);
		}
	}
	return 1;
}

public OnPlayerSpawn(playerid)
{
	if(!GetPVarInt(playerid, "CarsLoaded"))
	{
		SetPVarInt(playerid, "CarsLoaded", true);
		CargarAutos(playerid);
	}
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(newkeys & KEY_YES)
	{
		new
		    VehID = GetPlayerVehicleID(playerid);

		if(VehID)
		{
		    static
		        index;

			if(index >= MAX_VEH_JUGADOR)
			    return SendClientMessage(playerid, -1, "No se pueden comprar más.");
			    
			new
			    Float:x, Float:y, Float:z, Float:Angle;
			    
			GetVehiclePos(VehID, x, y, z);
			GetVehicleZAngle(VehID, Angle);

			PlayerVehID[playerid][index] = VehID;
			PlayerVehData[playerid][index][vModel] = GetVehicleModel(VehID);
			PlayerVehData[playerid][index][vPos_x] = x;
			PlayerVehData[playerid][index][vPos_y] = y;
			PlayerVehData[playerid][index][vPos_z] = z;
			PlayerVehData[playerid][index][vAngle] = Angle;

			printf("[VehícleSystem.pwn] Jugador compró vehículo en index %d", index);
		    UpdateVehicle(playerid, index);
		    index++;
		    
			SendClientMessage(playerid, random(0xFFFFFFFF), "->> Boughted");
		}
	}
	return 1;
}

stock UpdateVehicle(playerid, i)
{
	if(0 <= i < MAX_VEH_JUGADOR)
	{
		new
		    str_file[MAX_PLAYER_NAME + 20],
			name[MAX_PLAYER_NAME],
			INI:Arch,
			startgtc = GetTickCount();

		GetPlayerName(playerid, name, MAX_PLAYER_NAME);
		format(str_file, sizeof(str_file), "Vehiculos/%s.ini", name);

		Arch = INI_Open(str_file);

		INI_SetTag(Arch, "data");
		
		new
		    string[20],
			string2[20];

	    format(string, 20, "Model%d", i);
	    INI_WriteInt(Arch, string, PlayerVehData[playerid][i][vModel]);
	    format(string, 20, "Posx%d", i);
	    INI_WriteFloat(Arch, string, PlayerVehData[playerid][i][vPos_x]);
	    format(string, 20, "Posy%d", i);
	    INI_WriteFloat(Arch, string, PlayerVehData[playerid][i][vPos_y]);
	    format(string, 20, "Posz%d", i);
	    INI_WriteFloat(Arch, string, PlayerVehData[playerid][i][vPos_z]);
	    format(string, 20, "Angle%d", i);
	    INI_WriteFloat(Arch, string, PlayerVehData[playerid][i][vAngle]);
	    format(string, 20, "Color1%d", i);
	    INI_WriteInt(Arch, string, PlayerVehData[playerid][i][vColor_1]);
	    format(string, 20, "Color2%d", i);
	    INI_WriteInt(Arch, string, PlayerVehData[playerid][i][vColor_2]);
	    format(string, 20, "Familia%d", i);
	    INI_WriteInt(Arch, string, PlayerVehData[playerid][i][vFamilia]);
	    for(new a; a < MAX_VEH_MODS; a++)
	    {
	        format(string2, 20, "Mod%d%d", a, i);
	        INI_WriteInt(Arch, string2, PlayerVehMods[playerid][i][a]);
	    }
	    INI_Close(Arch);
		printf("[VehícleSystem.pwn] Vehiculo index %d fue actualizado (Tiempo: %dms)", i, GetTickCount() - startgtc);
	}
	return 1;
}

stock CargarAutos(playerid)
{
	new
	    str_file[MAX_PLAYER_NAME + 20],
		name[MAX_PLAYER_NAME],
		startgtc = GetTickCount();
	    
	GetPlayerName(playerid, name, MAX_PLAYER_NAME);
	format(str_file, sizeof(str_file), "Vehiculos/%s.ini", name);
	
	INI_ParseFile(str_file, "CargarVeh_data", .bExtra = true, .extra = playerid);
	
	printf("[VehícleSystem.pwn] Vehiculos del jugador (ParseFile) cargados en %dms", GetTickCount() - startgtc);

	for(new i; i < MAX_VEH_JUGADOR; i++)
	{
	    if(400 <= PlayerVehData[playerid][i][vModel] < 613)
	    {
			PlayerVehID[playerid][i] = CreateVehicle(	PlayerVehData[playerid][i][vModel],
			                                        	PlayerVehData[playerid][i][vPos_x],
			                                        	PlayerVehData[playerid][i][vPos_y],
			                                        	PlayerVehData[playerid][i][vPos_z],
			                                        	PlayerVehData[playerid][i][vAngle],
			                                        	PlayerVehData[playerid][i][vColor_1],
			                                        	PlayerVehData[playerid][i][vColor_2],
			                                        	60*60*60*60);

			printf("[VehícleSystem.pwn] Vehiculo index %d cargado (ID:%d)", i, PlayerVehID[playerid][i]);
			
			if(PlayerVehID[playerid][i] == INVALID_VEHICLE_ID)
			{
				SendClientMessage(playerid, -1, "Tu vehículo no se pudo cargar. ¡Reportar esto en el foro!.");
                PlayerVehID[playerid][i] = 0;
				continue;
			}
			
			for(new a; a < MAX_VEH_MODS; a++)
			{
				if(PlayerVehMods[playerid][i][a])
					AddVehicleComponent(PlayerVehID[playerid][i], PlayerVehMods[playerid][i][a]);
			}

			Veh[PlayerVehID[playerid][i]][vehFamilia] = PlayerVehData[playerid][i][vFamilia];
			Veh[PlayerVehID[playerid][i]][vehDuenoOn] = true;
			Veh[PlayerVehID[playerid][i]][vehVenta] = true;
			Veh[PlayerVehID[playerid][i]][vehTiempoOff] = 0;
		}
	}
	printf("[VehícleSystem.pwn] Todo el código ejecutado en: %dms", GetTickCount() - startgtc);
	return 1;
}

forward CargarVeh_data(playerid, name[], value[]);
public CargarVeh_data(playerid, name[], value[])
{
	new
	    string[20],
		string2[20];
	    
	for(new i; i < MAX_VEH_JUGADOR; i++)
	{
	    format(string, 20, "Model%d", i);
	    INI_Int(string, PlayerVehData[playerid][i][vModel]);
	    format(string, 20, "Posx%d", i);
	    INI_Float(string, PlayerVehData[playerid][i][vPos_x]);
	    format(string, 20, "Posy%d", i);
	    INI_Float(string, PlayerVehData[playerid][i][vPos_y]);
	    format(string, 20, "Posz%d", i);
	    INI_Float(string, PlayerVehData[playerid][i][vPos_z]);
	    format(string, 20, "Angle%d", i);
	    INI_Float(string, PlayerVehData[playerid][i][vAngle]);
	    format(string, 20, "Color1%d", i);
	    INI_Int(string, PlayerVehData[playerid][i][vColor_1]);
	    format(string, 20, "Color2%d", i);
	    INI_Int(string, PlayerVehData[playerid][i][vColor_2]);
	    format(string, 20, "Familia%d", i);
	    INI_Int(string, PlayerVehData[playerid][i][vFamilia]);
	    for(new a; a < MAX_VEH_MODS; a++)
	    {
	        format(string2, 20, "Mod%d%d", a, i);
	        INI_Int(string2, PlayerVehMods[playerid][i][a]);
	    }
	}
	return 1;
}

