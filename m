From: Marco Chiappero <marco@absence.it>
Date: Thu, 27 Nov 2008 14:41:31 +0000
Subject: Re: [lm-sensors] New Asus board and multiple
Message-Id: <492EB19B.2030608@absence.it>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------070303070405010904030805"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------070303070405010904030805
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

 > Hum, anything in dmesg?
 > Anyway I'm attacching the new version (plus patch for ACPI - diffed
 > against git-current, but it's easily adapted to older kernels).

Hi Luca,
sorry for my late reply but I've been busy these days.
I compiled and loaded the new atk driver and compiled again lm-sensors 
with the old patch (that was laying around in my /usr/src) and this time 
I managed to see the atk driver readings from the "sensors" output 
(don't know why it didn't work the first time, sorry). However I noticed 
that the code you posted recently it's a little bit different, isn't? 
Should I try that one too?
About the atk, it seems to work fine, but I haven't got the time to 
verify the presence of strange issues, regarding for example suspend 
and/or hibernate, stuff like that (does it matter?). Any suggestion 
about what to check is welcome.
The only thing to say is that in the new code now shows all the readings 
in the /sys/class/hwmon/hwmonX/ dir instead of the 
/sys/class/hwmon/hwmonX/device/ I used to see with many other sensors chips.
I know that no fan control is possible with this driver, however I was 
asking to myself whether it is possible to select on the fly one of the 
three "silent, normal, turbo" profiles available in the BIOS settings. 
Even if it is not a fine fan tuning, such regulation should be enough 
for me.
One, last thing: I use to collect and plot system data with collectd and 
rrdtool, but collectd seems to ignore the atk driver. I know, I should 
read the code, however any idea for addressing this issue? Is it 
something missing in the collectd code or the new, different chip type 
is not shown by the libsensors functions?
I'm attaching the sensors output and the dmesg one when loading the module.

Thank you!

Marco

--------------070303070405010904030805
Content-Type: text/plain;
 name="dmesg_output"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg_output"

[   49.010425] ATK0110 ATK0110:00: adding...
[   49.010439] ATK0110 ATK0110:00: board ID = P5Q-Deluxe
[   49.010444] ATK0110 ATK0110:00: Using old hwmon interface
[   49.010530] ATK0110 ATK0110:00: voltage: 0x6020000  +3.3 Voltage [2970-3630] enabled
[   49.010532] ATK0110 ATK0110:00: Sensor 0 is valid, type 0x2
[   49.010535] ATK0110 ATK0110:00: voltage: 0x6020001  +5 Voltage [4500-5500] enabled
[   49.010536] ATK0110 ATK0110:00: Sensor 1 is valid, type 0x2
[   49.010538] ATK0110 ATK0110:00: voltage: 0x6020002  +12 Voltage [10200-13800] enabled
[   49.010539] ATK0110 ATK0110:00: Sensor 2 is valid, type 0x2
[   49.010541] ATK0110 ATK0110:00: voltage: 0x6020003  Vcore Voltage [800-1800] enabled
[   49.010542] ATK0110 ATK0110:00: Sensor 3 is valid, type 0x2
[   49.010544] ATK0110 ATK0110:00: voltage: 0x6020004  DDR Voltage [1800-2100] enabled
[   49.010545] ATK0110 ATK0110:00: Sensor 4 is valid, type 0x2
[   49.010547] ATK0110 ATK0110:00: voltage: 0x6020005  SB11 Voltage [800-1300] enabled
[   49.010548] ATK0110 ATK0110:00: Sensor 5 is valid, type 0x2
[   49.010550] ATK0110 ATK0110:00: voltage: 0x6020006  SB15 Voltage [800-1800] enabled
[   49.010551] ATK0110 ATK0110:00: Sensor 6 is valid, type 0x2
[   49.010553] ATK0110 ATK0110:00: voltage: 0x6020007  CPUPLL Voltage [1200-1700] enabled
[   49.010554] ATK0110 ATK0110:00: Sensor 7 is valid, type 0x2
[   49.010556] ATK0110 ATK0110:00: voltage: 0x6020008  NB11 Voltage [800-1800] enabled
[   49.010557] ATK0110 ATK0110:00: Sensor 8 is valid, type 0x2
[   49.010559] ATK0110 ATK0110:00: voltage: 0x6020009  Dram VTT Volt [800-2000] enabled
[   49.010560] ATK0110 ATK0110:00: Sensor 9 is valid, type 0x2
[   49.010562] ATK0110 ATK0110:00: voltage: 0x602000a  VTTCPU Voltage [800-1500] enabled
[   49.010563] ATK0110 ATK0110:00: Sensor 10 is valid, type 0x2
[   49.010624] ATK0110 ATK0110:00: temperature: 0x6030000 CPU Temperature [600-950] enabled
[   49.010625] ATK0110 ATK0110:00: Sensor 11 is valid, type 0x3
[   49.010627] ATK0110 ATK0110:00: temperature: 0x6030001 MB Temperature [500-950] enabled
[   49.010628] ATK0110 ATK0110:00: Sensor 12 is valid, type 0x3
[   49.010630] ATK0110 ATK0110:00: temperature: 0x6030002 SB Temperature [650-950] enabled
[   49.010631] ATK0110 ATK0110:00: Sensor 13 is valid, type 0x3
[   49.010633] ATK0110 ATK0110:00: temperature: 0x6030003 NB Temperature [650-950] enabled
[   49.010634] ATK0110 ATK0110:00: Sensor 14 is valid, type 0x3
[   49.010636] ATK0110 ATK0110:00: temperature: 0x6030004 POWER Temperature [450-950] enabled
[   49.010637] ATK0110 ATK0110:00: Sensor 15 is valid, type 0x3
[   49.010639] ATK0110 ATK0110:00: temperature: 0x6030005 OPT_FAN3 Temperature [450-950] enabled
[   49.010641] ATK0110 ATK0110:00: Sensor 16 is valid, type 0x3
[   49.010643] ATK0110 ATK0110:00: temperature: 0x6030006 OPT_FAN2 Temperature [450-950] enabled
[   49.010644] ATK0110 ATK0110:00: Sensor 17 is valid, type 0x3
[   49.010646] ATK0110 ATK0110:00: temperature: 0x6030007 OPT_FAN1 Temperature [450-950] enabled
[   49.010647] ATK0110 ATK0110:00: Sensor 18 is valid, type 0x3
[   49.010705] ATK0110 ATK0110:00: fan: 0x6040000 CPU FAN Speed [600-7200] enabled
[   49.010707] ATK0110 ATK0110:00: Sensor 19 is valid, type 0x4
[   49.010709] ATK0110 ATK0110:00: fan: 0x6040001 CH_FAN1 Speed [600-7200] enabled
[   49.010710] ATK0110 ATK0110:00: Sensor 20 is valid, type 0x4
[   49.010711] ATK0110 ATK0110:00: fan: 0x6040002 CH_FAN2 Speed [600-7200] enabled
[   49.010713] ATK0110 ATK0110:00: Sensor 21 is valid, type 0x4
[   49.010714] ATK0110 ATK0110:00: fan: 0x6040003 CH_FAN3 Speed [600-7200] enabled
[   49.010716] ATK0110 ATK0110:00: Sensor 22 is valid, type 0x4
[   49.010717] ATK0110 ATK0110:00: fan: 0x6040004 Power_FAN Speed [600-7200] enabled
[   49.010719] ATK0110 ATK0110:00: Sensor 23 is valid, type 0x4
[   49.010720] ATK0110 ATK0110:00: fan: 0x6040005 OPT1_FAN Speed [600-7200] enabled
[   49.010722] ATK0110 ATK0110:00: Sensor 24 is valid, type 0x4
[   49.010723] ATK0110 ATK0110:00: fan: 0x6040006 OPT2_FAN Speed [600-7200] enabled
[   49.010725] ATK0110 ATK0110:00: Sensor 25 is valid, type 0x4
[   49.010726] ATK0110 ATK0110:00: fan: 0x6040007 OPT3_FAN Speed [600-7200] enabled
[   49.010728] ATK0110 ATK0110:00: Sensor 26 is valid, type 0x4
[   49.010729] ATK0110 ATK0110:00: registering hwmon device
[   49.010743] ATK0110 ATK0110:00: populating sysfs directory


--------------070303070405010904030805
Content-Type: text/plain;
 name="sensors_output"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="sensors_output"

coretemp-isa-0000
Adapter: ISA adapter
Core 0:      +37.0������C  (high = +78.0������C, crit = +100.0������C)  

coretemp-isa-0001
Adapter: ISA adapter
Core 1:      +37.0������C  (high = +78.0������C, crit = +100.0������C)  

atk0110-acpi-0
Adapter: ACPI device
 +3.3 Voltage:        +3.33 V  (min =  +2.97 V, max =  +3.63 V)
 +5 Voltage:          +5.14 V  (min =  +4.50 V, max =  +5.50 V)
 +12 Voltage:        +12.15 V  (min = +10.20 V, max = +13.80 V)
 Vcore Voltage:       +1.07 V  (min =  +0.80 V, max =  +1.80 V)
 DDR Voltage:         +2.11 V  (min =  +1.80 V, max =  +2.10 V)
 SB11 Voltage:        +1.12 V  (min =  +0.80 V, max =  +1.30 V)
 SB15 Voltage:        +1.50 V  (min =  +0.80 V, max =  +1.80 V)
 CPUPLL Voltage:      +1.53 V  (min =  +1.20 V, max =  +1.70 V)
 NB11 Voltage:        +1.12 V  (min =  +0.80 V, max =  +1.80 V)
 Dram VTT Volt:       +1.05 V  (min =  +0.80 V, max =  +2.00 V)
 VTTCPU Voltage:      +1.12 V  (min =  +0.80 V, max =  +1.50 V)
CPU FAN Speed:        897 RPM  (min =  600 RPM)
CH_FAN1 Speed:        638 RPM  (min =  600 RPM)
CH_FAN2 Speed:        936 RPM  (min =  600 RPM)
CH_FAN3 Speed:        837 RPM  (min =  600 RPM)
Power_FAN Speed:        0 RPM  (min =  600 RPM)
OPT1_FAN Speed:         0 RPM  (min =  600 RPM)
OPT2_FAN Speed:         0 RPM  (min =  600 RPM)
OPT3_FAN Speed:         0 RPM  (min =  600 RPM)
CPU Temperature:      +29.5������C  (high = +60.0������C, crit = +95.0������C)  
MB Temperature:       +39.0������C  (high = +50.0������C, crit = +95.0������C)  
SB Temperature:       +53.0������C  (high = +65.0������C, crit = +95.0������C)  
NB Temperature:       +49.0������C  (high = +65.0������C, crit = +95.0������C)  
POWER Temperature:    +39.0������C  (high = +45.0������C, crit = +95.0������C)  
OPT_FAN3 Temperature: +36.0������C  (high = +45.0������C, crit = +95.0������C)  
OPT_FAN2 Temperature: +22.0������C  (high = +45.0������C, crit = +95.0������C)  
OPT_FAN1 Temperature: +38.0������C  (high = +45.0������C, crit = +95.0������C)  


--------------070303070405010904030805
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------070303070405010904030805--
