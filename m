From: warder@warder.ath.cx (Todor T. Zviskov)
Date: Thu, 19 May 2005 06:24:05 +0000
Subject: sensor readings using kernel 2.5.x/2.6.0-test1
Message-Id: <3F1599A7.8070808@warder.ath.cx>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F14E4B0.6080006@warder.ath.cx>
In-Reply-To: <3F14E4B0.6080006@warder.ath.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Greg KH wrote:

>On Wed, Jul 16, 2003 at 01:37:52AM -0400, Todor T. Zviskov wrote:
>  
>
>>Hi,
>>
>>I'm sorry if I'm bothering you but I just discovered something that 
>>might interest you. I just noticed I got sensor readings in gkrellm with 
>>the 2.6.0-test1 kernel. At first it was disabled when I booted in the 
>>new kernel and opened gkrellm but then I noticed that the readings were 
>>just disabled (for some reason) in the config. I previously thought 
>>gkrellm was using the `sensors' program for the readings (cause they say 
>>lm_sensors is required) but I guess I was wrong and it's actually 
>>getting the info from /sys/bus/i2c/devices/ or something (1-6000 in 
>>mycase - via686a chip). I find the readings in /sys/bus/i2c/devices/ to 
>>be pretty straight forward (at least for my mobo).
>>    
>>
>
>lmsensors does not work with 2.5/2.6 yet, sorry.
>
>Any help would be appreciated in porting :)
>
>thanks,
>
>greg k-h
>
>  
>
Ok, I wrote a quick sensors prog that works with the 2.6.0-test1 (and 
possibly recent 2.5.x) kernel (kernel I2C stuff compiled) with my mobo 
(via686 chipset). I'm not sure if it's gonna work `properly' with other 
chipsets (don't have more HW to test on) but if it doesn't, the readings 
may be adjusted with a .conf file or something (using the lm_sensors 
confs might work perfectly). I'm also not sure if the temperature 
readings change to C or F depending on the locale (someone might want to 
check that). Hope this will help at least a bit.

sensors.c is attached and I'll upload it to 
http://warder.ath.cx:81/projects/ as well.

Regards,
Todor
-------------- next part --------------
/****************************************************************************

Author:      Todor T. Zviskov (a.k.a. Warder) - http://warder.ath.cx:81/
Name:        sensors.c
Version:     0.1
Description: Prints the hardware sensors readings from
             /sys/devices/legacy/i2c-# in linux kernel 2.6 (and recent 2.5.x)
             Tested with via686 chipset only, other chipsets may return
             strange values.
License:     GPL-2 - http://www.gnu.org/licenses/gpl.txt

****************************************************************************/

#include <stdio.h>
#include <sys/types.h>
#include <dirent.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
int main()
{
	//names that in /sys/devices/legacy/i2c-# for via686
	char names[31][80] = {"name", "in_input0", "in_min0", "in_max0",
				"in_input1", "in_min1", "in_max1",
				"in_input2", "in_min2", "in_max2",
				"in_input3", "in_min3", "in_max3",
				"in_input4", "in_min4", "in_max4",
				"fan_input1", "fan_min1", "fan_div1",
				"fan_input2", "fan_min2", "fan_div2",
				"temp_input1", "temp_min1", "temp_max1",
				"temp_input2", "temp_min2", "temp_max2",
				"temp_input3", "temp_min3", "temp_max3"};
	//user-friendly translations of the above
	char via686[31][80] = {"", "VCore:", "min =", "max =",
				"+2.5V:", "min =", "max =",
				"+3.3V:", "min =", "max =",
				"+5V:", "min =", "max =",
				"+12V:", "min =", "max =",
				"CPU fan:", "min =", "max =",
				"case fan:", "min =", "max =",
				"sys temp:", "limit =", "hysteresis =",
				"CPU temp:", "limit =", "hysteresis =",
				"sBr temp:", "limit =", "hysteresis ="};
	float values[31];
	char i2c_dir[80] = "/sys/devices/legacy";
	char i2c_dir_num[80];
	char data_file[80];
	char name[80];
	FILE *inFile;
	int i, j;
	DIR *dirp;
	struct dirent *dp;

	//see if we /sys (kernel 2.5/2.6)
	if ((inFile = fopen (i2c_dir, "r")) = NULL)
	{
		printf ("You are NOT running a 2.5/2.6 kernel.\nFor 2.0.x-2.4.x kernels, please use the lm_sensors package.\n\n");
		return 1;
	}
	fclose (inFile);
	
	//loop for /sys/devices/legacy/i2c-#
	for (i=0; i<20; i++)
	{
		sprintf (i2c_dir_num, "%s/i2c-%d/", i2c_dir, i);
		dirp = opendir(i2c_dir_num);
		if (dirp = NULL)
		{
			//we got no i2c-0, we got no info
			if (i = 0)
			{
				printf ("I2C and Sensors are not enabled in your kernel or you don't have the modules loaded.\n\n");
				return 1;
			}
		}
		else
		{
			//find the #-xxxx dir in /sys/devices/legacy/i2c-#
			while (dirp)
			{
				if ((dp = readdir(dirp)) != NULL)
				{
					if (strstr(dp->d_name, "-"))
						sprintf(i2c_dir_num, "%s%s/", i2c_dir_num, dp->d_name);
				}
				else
				break;
			}
			closedir(dirp);

			//retreive the name of the sensor/chipset
			sprintf (data_file, "%s%s", i2c_dir_num, names[0]);
			if ((inFile = fopen (data_file, "r")) != NULL);
			{
				fgets (name, 80, inFile);
				printf ("Device:	%s\n", name);
			}
			fclose (inFile);
			if (strstr (name, "via686"))
				printf ("NOTE: This program has only been tested with via686 chip and might return strange values with other chipsets!\n\n");

			//read and print all files containing the info
			for (j=1; j<31; j++)
			{
				sprintf (data_file, "%s%s", i2c_dir_num, names[j]);
				if ((inFile = fopen (data_file, "r")) != NULL)
				{
					fscanf (inFile, "%f", &values[j]);

					//adjust the values
					if (j <= 15)
						values[j]=values[j]/1000;
					if (j >= 22)
						values[j]=values[j]/100;

					//format and print the output
					if (strstr (names[j], "in_input"))
						printf ("%s		%.2f V	(", via686[j],values[j]);
					if (strstr (names[j], "in_min"))
						printf ("%s %.2f V, ", via686[j],values[j]);
					if (strstr (names[j], "in_max"))
						printf ("%s %.2f V)\n", via686[j],values[j]);
					if (strstr (names[j], "fan_input"))
						printf ("%s	%.0fRPM	(", via686[j],values[j]);
					if (strstr (names[j], "fan_min"))
						printf ("%s %.0f RPM, ", via686[j],values[j]);
					if (strstr (names[j], "fan_div"))
						printf ("%s %.0f)\n", via686[j],values[j]);
					if (strstr (names[j], "temp_input"))
						printf ("%s	%.1fC	(", via686[j],values[j]);
					if (strstr (names[j], "temp_min"))
						printf ("%s %.1fC, ", via686[j],values[j]);
					if (strstr (names[j], "temp_max"))
						printf ("%s %.1fC)\n", via686[j],values[j]);

					//printf ("%s:	%.2f\n", via686[j], values[j]);
					fclose (inFile);
				}
			}
		}
	}
	return 0;
}
