/*  
	+-----------------------------+
	|                             |
	|   Interiores de Edificios   |
	|      Creado por GROVE4L     |
	|   www.pawnoscripting.com    |
	|                             |
 	+-----------------------------+
 */

//CONTROLES

#define COLORLABEL 		(0xFFFFFFFF) \
//Define el color del texto al cargar el edificio. (Defecto: 0x008080FF)


#define RADIO3D			(30) \
// Define la distancia a la cual se vera el Texto del Edificio. (Defecto: 40)


#define PICKUPID    	(1318) \
// Define la ID del pickup al cargar los edificios. (Defecto: 19135)


#define MAX_EDIFICIOS 	(18) \
//Define la cantidad maxima de edificios. (Defecto: 50)

//FIN CONTROLES




enum EIntGR
{
	ENombre[50],
	Float:AfueraCordX,
	Float:AfueraCordY,
	Float:AfueraCordZ,
	Float:AdentroCordX,
	Float:AdentroCordY,
	Float:AdentroCordZ,
    Interior,
    TiempoC
}
new IntGR[MAX_EDIFICIOS][EIntGR];
new Text3D:LabelInteriorsGR[MAX_EDIFICIOS];
new Destino[9][50];
new Archivo[128];
new ide;
new File:iniedificios;
new stringedi[60];

forward EntrarEdificio(playerid,newkeys);
public EntrarEdificio(playerid,newkeys)
{
	if(newkeys == KEY_YES)
	{
	    for(new i = 0; i < sizeof(IntGR); i++)
	    {
	        if(IsPlayerInRangeOfPoint(playerid,2,IntGR[i][AfueraCordX],IntGR[i][AfueraCordY],IntGR[i][AfueraCordZ]))
	        {
	            if(!IsPlayerInAnyVehicle(playerid))
	            {
	                SetPlayerInterior(playerid, IntGR[i][Interior]);
	   				SetPlayerPos(playerid, IntGR[i][AdentroCordX], IntGR[i][AdentroCordY], IntGR[i][AdentroCordZ]);
					if(IntGR[i][TiempoC])
					{
						CongelarEx(playerid,IntGR[i][TiempoC]);
						GameTextForPlayer(playerid,"~w~cargando~n~~b~~h~~h~~h~espera un momento..",IntGR[i][TiempoC]*1000,3);
					}
					return 1;
	            }
	        }
	        else if(IsPlayerInRangeOfPoint(playerid,2,IntGR[i][AdentroCordX], IntGR[i][AdentroCordY], IntGR[i][AdentroCordZ]))
	        {
	            SetPlayerInterior(playerid, 0);
	            SetPlayerPos(playerid, IntGR[i][AfueraCordX],IntGR[i][AfueraCordY],IntGR[i][AfueraCordZ]);
				return 1;
	        }
	    }
	}
	return 0;
}

forward CargarInteriores();
public CargarInteriores()
{
	iniedificios = fopen("Edificios.ini", io_read);
	while(ide < sizeof(IntGR))
	{
		fread(iniedificios, Archivo);
		splitg(Archivo, Destino, '|');
		strmid(IntGR[ide][ENombre], Destino[0], 0, strlen(Destino[0]), 255);
		IntGR[ide][AfueraCordX] = floatstr(Destino[1]);
		IntGR[ide][AfueraCordY] = floatstr(Destino[2]);
		IntGR[ide][AfueraCordZ] = floatstr(Destino[3]);
		IntGR[ide][AdentroCordX] = floatstr(Destino[4]);
		IntGR[ide][AdentroCordY] = floatstr(Destino[5]);
		IntGR[ide][AdentroCordZ] = floatstr(Destino[6]);
		IntGR[ide][Interior] = strval(Destino[7]);
		IntGR[ide][TiempoC] = strval(Destino[8]);
		CreatePickup(PICKUPID,1,IntGR[ide][AfueraCordX],IntGR[ide][AfueraCordY],IntGR[ide][AfueraCordZ]);
		format(stringedi, 50, "%s\n\n{85B1C6}Presione [Y]", IntGR[ide][ENombre]);
		LabelInteriorsGR[ide] = Create3DTextLabel(stringedi,COLORLABEL,IntGR[ide][AfueraCordX],IntGR[ide][AfueraCordY],IntGR[ide][AfueraCordZ]+1,RADIO3D,0,1);
		ide ++;
	}
	fclose(iniedificios);
	return 1;
}

forward splitg(const strsrc[], strdest[][], delimiter);
public splitg(const strsrc[], strdest[][], delimiter)
{
	new i, li;
	new aNum;
	new len;
	while(i <= strlen(strsrc))
	{
	    if(strsrc[i] == delimiter || i == strlen(strsrc))
		{
	        len = strmid(strdest[aNum], strsrc, li, i, 128);
	        strdest[aNum][len] = 0;
	        li = i+1;
	        aNum++;
		}
		i++;
	}
	return 1;
}
