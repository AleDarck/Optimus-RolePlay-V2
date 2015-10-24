// FS by Spell
// This FS export the error code to "crashdetect_debug.txt" (thanks Y_Less(fixes2) and 0x5A656578 (zeex?) for crashdetect.

#include <a_samp>
#include <fixes2>

public OnServerMessage(const msg[])
{
	if(msg[0] == '[' && msg[6] == ']' && msg[5] == 'g')
	{
	    new
	        File: Debug_txt = fopen("crashdetect_debug.txt", io_append),
			string[120],
			fecha[3], hora[3];
			
		getdate(fecha[0],fecha[1],fecha[2]);
		gettime(hora[0],hora[1],hora[2]);

		format(string, 120, "[%d/%d/%d-%d:%d:%d] %s\r\n", fecha[2], fecha[1], fecha[0], hora[0], hora[1], hora[2], msg[8]);
		fwrite(Debug_txt, string);
		fclose(Debug_txt);
	}
	return 1;
}
