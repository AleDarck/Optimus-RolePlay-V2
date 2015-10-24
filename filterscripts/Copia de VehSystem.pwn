/*


** -Test del sistema de vehículos Optimus RolePlay


		> Spell.
		
*/

#include <a_samp>
#include <YSI\y_ini>
#include <foreach>

native IsValidVehicle(vehicleid);

#define MAX_VEH_JUGADOR     	(5)
#define MAX_VEH_MODS        	(12)
#define MAX_MINS_DESTROY_VEH    (5)

enum E_VEH_GENERAL
{
	vehFamilia,
	bool:vehVenta,
	bool:vehDuenoOn,
	vehDueno[MAX_PLAYER_NAME],
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


