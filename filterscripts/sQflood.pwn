/*
*
--------------------------------------------------------------------------------
				sQflood: PROTECTION for Query flood.
--------------------------------------------------------------------------------
*
*
*   CREDITS:
*       *- Spell (script)
*       *- JaTochNietDan (plugin exec)
*       *- Y_Less (fixes2)
*
*           RESPECT CREDITS!!!!
*           RESPETA CREDITOS!!!!
*/

#include <a_samp>
#include <fixes2>

#define _sQflood_version    (1.0)

#define MAX_INDEX_IP    			(150)//EN: If you have too many users, increase this value | ES: si tienes mucha gente, aumentá este valor
#define MAX_QUERIES_FOR_BLOCK   	(100)//Dont change
#define isnull(%1)    				((%1[0] == 0) || (%1[0] == 1 && %1[1] == 0))

#define LANG_EN     (0)
#define LANG_ES     (1)

// ==> Languaje
#define lang LANG_EN // Options: LANG_ES | LANG_EN

native exec(cmd[]);

new
	Name_IP[MAX_INDEX_IP][28],
	Last_query[MAX_INDEX_IP],
	Warn_IP[MAX_INDEX_IP];

public OnFilterScriptInit()
{
	SetTimer("StartLogQueries", 5000,  false);
	SetTimer("ClearOldQueries", 20000, true);
	printf("\n\n\t========================================================\n");
	#if lang == LANG_EN
	printf("\t  -- sQflood v(%.1f) (anti queryflood) by Spell loaded! --",   _sQflood_version);
	#elseif lang == LANG_ES
	printf("\t  -- sQflood v(%.1f) (anti queryflood) por Spell cargado! --", _sQflood_version);
	#endif
	printf("\n\t========================================================\n\n");
	
	
	// ==-> Speed test
	/* 
	
	new
		t = GetTickCount(),
		IP[40];
	for(new i; i < 4000; i++)
	{
		format(IP, 40, "[query:x] from %d.%d.%d.%d", random(500), random(500), random(500), random(500));
		printf(IP);
		CallRemoteFunction("OnServerMessage", "s", IP);
	}
	new
	    Float: Time_passed = float(GetTickCount()-t) / 4000;
	    
	printf("Time for executing OnServerMessage: [1 time: %f | 4000 times: %d]", Time_passed, GetTickCount()-t);
	
	*/
	return 1;
}

public OnFilterScriptExit()
{
	printf("\n\n\t========================================================\n");
	#if lang == LANG_EN
	printf("\t  -- sQflood v(%.1f) (anti queryflood) by Spell unloaded --",   _sQflood_version);
	#elseif lang == LANG_ES
	printf("\t  -- sQflood v(%.1f) (anti queryflood) por Spell descargado --", _sQflood_version);
	#endif
	printf("\n\t========================================================\n\n");

	return 1;
}


//============================================================================//
forward StartLogQueries();
forward ClearOldQueries();

public StartLogQueries()
	return SendRconCommand("logqueries 1");
	
public ClearOldQueries()
{
	for(new i; i < MAX_INDEX_IP; i++) if(!isnull(Name_IP[i]) && !Warn_IP[i])
	{
	    if(GetTickCount() - Last_query[i] > 30000)
	    {
	        ClearIPData(i);
	        continue;
		}
	}
	return 1;
}

//============================================================================//

public OnServerMessage(const msg[])
{
	if(strfind(msg, "[query:") == 0)
	{
	    new IP[27];
	    
	    strmid(IP, msg, 15, strlen(msg));
	    
		if(!IsIPRegistered(IP))
		{
		    //printf("[sQflood] IP %s is not registered, register ip %s..", IP, IP);
		    RegisterIP(IP);
		    return 1;
		}

	    new
			i = GetIPIndex(IP);

		//printf("[sQflood] GetIPIndex(\"%s\") = (%d).", IP, i);
		if((GetTickCount() - Last_query[i]) < 2000)
		{
		    Warn_IP[i] ++;
		    if(Warn_IP[i] >= MAX_QUERIES_FOR_BLOCK)//100 queries in 2 sec? ..BAN!!
		    {
		        BanIP(IP, true);
		        ClearIPData(i);
		        SendRconCommand("logqueries 0");//Activa esto si queres testear que el FS funciona, y no tenes linux.
				SetTimer("StartLogQueries", 5000,  false);
		        return 1;
			}
		}
		else
		{
			Warn_IP[i] = 0;
			Last_query[i] = GetTickCount();
		}
	}
	return 1;
}

stock BanIP(IP[], player = false)
{
	if(strcmp(IP, "255.255.255.255") == 0) return 0;
	
	if(player)
	{
		new
		    Temp_IP[28];
		for(new i; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i) && !IsPlayerNPC(i))
		{
		    GetPlayerIp(i, Temp_IP, 28);
		    if(strcmp(Temp_IP, IP) == 0)
		    {
				#if lang == LANG_EN
		        SendClientMessage(i, -1, "You has been banned by {FFFF00}sQflood. {FFFFFF}Reason: {FF0000}[QUERY-FLOOD FROM YOUR IP]");
		        #elseif lang == LANG_ES
		        SendClientMessage(i, -1, "Fuiste baneado por {FFFF00}sQflood. {FFFFFF}Razón: {FF0000}[QUERY-FLOOD DETECTADO DESDE TU IP]");
		        #endif
		        BanEx(i, "Query flood");
		        
			}
		}
	}
	
    new
		banString[100],
		File: Log = fopen("sQflood_log.txt", io_append),
		Data[5];

    format(banString, sizeof(banString), "iptables -A INPUT -s %s -j DROP", IP);
    exec(banString);
    
    getdate(Data[2], Data[1], Data[0]);
    gettime(Data[3], Data[4]);
    
	#if lang == LANG_EN
    format(banString, sizeof(banString), "[%02d/%02d/%d - %02d:%02d] -- Blocking attack from IP %s..\r\n", Data[0], Data[1], Data[2], Data[3], Data[4], IP);
	printf("[sQflood] Blocked attack from IP %s ..", IP);
    #elseif lang == LANG_ES
    format(banString, sizeof(banString), "[%02d/%02d/%d - %02d:%02d] -- Bloqueado ataque de la IP %s..\r\n", Data[0], Data[1], Data[2], Data[3], Data[4], IP);
	printf("[sQflood] Ataque bloqueado desde la IP %s ..", IP);
	#endif
	fwrite(Log, banString);
	fclose(Log);
	
	return 1;
}


stock RegisterIP(IP[])
{
	for(new i; i < MAX_INDEX_IP; i++)
	{
		if(isnull(Name_IP[i]))
		{
		    strcat(Name_IP[i], IP);
			Last_query[i] = GetTickCount();
		    return 1;
		}
	}
	return 0;
}

stock IsIPRegistered(IP[])
{
	for(new i; i < MAX_INDEX_IP; i++)
	{
	    if(!isnull(Name_IP[i]) && strcmp(Name_IP[i], IP) == 0)
	    {
	        return 1;
		}
	}
	return 0;
}

stock GetIPIndex(IP[])
{
	for(new i; i < MAX_INDEX_IP; i++)
	{
	    if(strcmp(Name_IP[i], IP) == 0)
	    {
	        return i;
		}
	}
	return -1;
}

stock ClearIPData(index)
{
	if(0 <= index < MAX_INDEX_IP)
	{
	    Name_IP[index][0] = 0;
	    Last_query[index] = 0;
	    Warn_IP[index] = 0;
	    return 1;
	}
	return 0;
}

/*
--------------------------------------------------------------------------------
				EOF
--------------------------------------------------------------------------------
*/
