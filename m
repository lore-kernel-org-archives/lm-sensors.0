From: jharvell+lists.lm-sensors@dogpad.net (Joe Harvell)
Date: Tue, 06 Feb 2007 17:11:44 +0000
Subject: [lm-sensors] Asus P5B Deluxe / Winbond 83627DHG
Message-Id: <45C8B6D0.5020200@dogpad.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <4dfa50520612211313g7906f3b0kbf8d7aebb2ddcda9@mail.gmail.com>
In-Reply-To: <4dfa50520612211313g7906f3b0kbf8d7aebb2ddcda9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Rudolf Marek wrote:

> 
>> fan1: (you state it should be the CPU_FAN) The RPM in the 1100 range 
>> matches what I'm seeing in the BIOS for CHA_FAN1 and CHA_FAN2 (both are 
>> documented to run at 1800 RPM)
> 
> ok
> 
>> fan2: (you state it should be CHA_FAN1) The RPM of 2537 is consistent 
>> with what I'm seeing in the BIOS for CPU_FAN (a Zalman CNPS9500 LED)
>> fan3: (you state it should be CHA_FAN2) My fan3 shows 0, but I have 
>> verified both fans are spinning and connected to CHA_FAN1 and CHA_FAN2
>> fan4: (you state this is PWR_FAN):  The P5B manual states that this 
>> connector is not supported by their QFan2 software monitoring.  I doubt 
>> it would be monitorable.
> 
> Hmm how many/what fans can you see in the BIOS?

I figured out why I got zero readings for fan5.  Since my case fans are 
lower speed, it seems the divisor was to low.  I remedied this by 
settting fan1_min and fan5_min to 700.  This also has the side effect of 
setting the divisor to 16.  Now I get readings in the 1100 RPM range for 
both fan1 and fan5.

Here is what I see in the BIOS Hardware Monitor after being on for about 
5 minutes:

CPU Temperature          35.5 C
MB Temperature           21 C
CPU Fan Speed            2556
CPU QFan Control         Enabled
CPU Fan Profile          Optimal
Chassis Fan1 Speed       1095
Chassis Fan2 Speed       1163
Chassis Fan3 Speed       N/A
Chassis QFan Control     Enabled
Chassis Fan Profile      Optimal
Power Fan Speed          N/A

VCore Voltage             1.176
3.3V Voltage              3.328
5V Voltage                4.992
12V Voltage              12.144

Here is my Idle sensors output

jharvell at cujo ~ $ sensors
w83627dhg-isa-0290
Adapter: ISA adapter
VCore:     +1.12 V  (min =  +0.00 V, max =  +1.74 V)
12 V:     +12.14 V  (min = +10.82 V, max = +13.20 V)
3.3V:      +3.33 V  (min =  +3.14 V, max =  +3.47 V)
5V:        +5.04 V  (min =  +4.76 V, max =  +5.25 V)
VSB:       +3.33 V  (min =  +3.14 V, max =  +3.47 V)
CHA_FAN1: 1125 RPM  (min =  703 RPM, div = 16)
CPU_FAN:  2518 RPM  (min = 1704 RPM, div = 8)
CHA_FAN2: 1222 RPM  (min =  703 RPM, div = 16)
Sys Temp:    +28 C  (high =   +40 C, hyst =   +35 C)
CPU Temp:  +34.5 C  (high = +55.0 C, hyst = +45.0 C)

Actually, I recently finished a compile, so it may still be cooling 
slightly.  Also, I am using CPU Frequency scaling.  So the CPU is at 
1.60 GHz instead of the normal 2.39 GHz.  I don't know what the 
operating CPU frequency is in the BIOS.

jharvell at cujo ~ $ cpufreq-info
cpufrequtils 002: cpufreq-info (C) Dominik Brodowski 2004-2006
Report errors and bugs to linux at brodo.de, please.
analyzing CPU 0:
   driver: centrino
   CPUs which need to switch frequency at the same time: 0
   hardware limits: 1.60 GHz - 2.39 GHz
   available frequency steps: 2.39 GHz, 1.60 GHz
   available cpufreq governors: ondemand, performance
   current policy: frequency should be within 1.60 GHz and 2.39 GHz.
                   The governor "ondemand" may decide which speed to use
                   within this range.
   current CPU frequency is 1.60 GHz.
analyzing CPU 1:
   driver: centrino
   CPUs which need to switch frequency at the same time: 1
   hardware limits: 1.60 GHz - 2.39 GHz
   available frequency steps: 2.39 GHz, 1.60 GHz
   available cpufreq governors: ondemand, performance
   current policy: frequency should be within 1.60 GHz and 2.39 GHz.
                   The governor "ondemand" may decide which speed to use
                   within this range.
   current CPU frequency is 1.60 GHz.

