/*
*
*	- Creador de portones en una sola linea. By spell =D
*	- Conserve los creditos...
*
*/

#define MAX_PORTONES     15//Cambien esto, según la cantidad de portones que creen que vallan a crear
#define DISTANCIA        20//metros a los que se abrirá la puerta
#define TECLA       	 KEY_YES//Con qué tecla se podrá abrir las puertas.

/*

native CrearPorton(id_obj,Float:x,Float:y,Float:z,Float:rx,Float:ry,Float:rz,Float:x2,Float:y2,Float:z2,Float:Velocidad,idfam)

*/

enum pInfo
{
	pID,
	Float:pPosx,
	Float:pPosy,
	Float:pPosz,
	Float:pMovex,
	Float:pMovey,
	Float:pMovez,
	Float:pVelocidad,
	pFamilia
}

new
		InfoPorton[MAX_PORTONES][pInfo],
		Total_Portones_Creados,
		Porton_Actual;

forward CrearPorton(id_obj,Float:x,Float:y,Float:z,Float:rx,Float:ry,Float:rz,Float:x2,Float:y2,Float:z2,Float:Velocidad,idfam);

public CrearPorton(id_obj,Float:x,Float:y,Float:z,Float:rx,Float:ry,Float:rz,Float:x2,Float:y2,Float:z2,Float:Velocidad,idfam)
{
	Total_Portones_Creados++;
	InfoPorton[Total_Portones_Creados][pID] = CreateDynamicObject(id_obj,x,y,z,rx,ry,rz);
	InfoPorton[Total_Portones_Creados][pPosx] = x;
	InfoPorton[Total_Portones_Creados][pPosy] = y;
	InfoPorton[Total_Portones_Creados][pPosz] = z;
	InfoPorton[Total_Portones_Creados][pMovex] = x2;
	InfoPorton[Total_Portones_Creados][pMovey] = y2;
	InfoPorton[Total_Portones_Creados][pMovez] = z2;
	InfoPorton[Total_Portones_Creados][pVelocidad] = Velocidad;
	InfoPorton[Total_Portones_Creados][pFamilia] = idfam;
	return 1;
}


forward CerrarPortones();

public CerrarPortones()
{
	new i;
	while( i++ != Total_Portones_Creados )
	{
		if(Porton_Actual == i)
		{
			MoveDynamicObject(InfoPorton[i][pID],InfoPorton[i][pPosx],InfoPorton[i][pPosy],InfoPorton[i][pPosz],InfoPorton[i][pVelocidad]);
			Porton_Actual = 0;
		}
	}
	return 1;
}

