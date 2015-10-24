// CONTADOR

#include <a_samp>

#define HORA_APERTURA   18

new
	Timer_UPDATETIME;

public OnFilterScriptInit()
{
	new years, days, months;
	getdate(years, months, days);
	if(years == 2013 && months == 6 && days == 2)
		Timer_UPDATETIME = SetTimer("UpdateTime", 800, true);

	return 1;
}

/*
HORA SV: 19
HORA PC: 20

DIF : 1 HS.

HORA SV REAL: 15
HORA PC REAL: 16

HORA APERTURA SV: 17
HORA APERTURA PC: 18
*/

forward UpdateTime();

public UpdateTime()
{
	static i;
	
	if(!i)
	{
	    Inicio();
	    i = 1;
	}
	
	new hours, mins, secs;
	gettime(hours, mins, secs);
	
	if(hours >= HORA_APERTURA)
	{
	    Apertura();
	    KillTimer(Timer_UPDATETIME);
	    return 1;
	}
	
	new
		temp_hour = HORA_APERTURA-hours,
		temp_min = 59 - mins,
		temp_sec = 59 - secs;
		
	temp_hour--;
	
	new str[100];
	
	format(str, 100, "hostname » Øptimus RP | Faltan %d horas %d min %d segundos!", temp_hour, temp_min, temp_sec);
	
	SendRconCommand(str);

	return 1;
}

stock Inicio()
{

	SendRconCommand("hostname » Øptimus RP | Falta CALCULANDO...");
	SendRconCommand("password op");

	return 1;
}

stock Apertura()
{
	SendRconCommand("hostname » Øptimus RP [v2] | ¡ABRIMOS!");
	SendRconCommand("password 0");

	return 1;
}

