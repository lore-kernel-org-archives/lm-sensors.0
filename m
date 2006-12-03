From: udovdh@xs4all.nl (Udo van den Heuvel)
Date: Sun, 03 Dec 2006 11:13:50 +0000
Subject: [lm-sensors] new vt1211 driver: Can't access procfs/sysfs file
Message-Id: <4572B16E.7030601@xs4all.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <45728865.5020308@xs4all.nl>
In-Reply-To: <45728865.5020308@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> On Sun, 03 Dec 2006 11:41:38 +0100, Udo van den Heuvel wrote:
>> Jean Delvare wrote:
>>> On Sun, 03 Dec 2006 09:18:45 +0100, Udo van den Heuvel wrote:
>>>> Also the temperature sensors are not shown.
>>> Please provide the complete output of "sensors".
>> # sensors
>> vt1211-isa-6000
>> Adapter: ISA adapter
>> VCore1:    +1.04 V  (min =  +1.13 V, max =  +1.27 V)   ALARM
>> +5V:       +4.93 V  (min =  +4.74 V, max =  +5.26 V)
>> +12V:     +12.05 V  (min = +11.38 V, max = +12.61 V)
>> +3.3V:     +5.28 V  (min =  +3.14 V, max =  +3.47 V)   ALARM
>> System:   4070 RPM  (min = 2580 RPM, div = 2)
>> vid:      +1.850 V  (VRM Version 9.1)
> 
> No errors for temperatures, they are simply missing, 

As I wrote.

> are ignore statements for them in your configuration file. 

Sure. But not for the temperatures.

> please see the vt1211 section of your configuration file? 

I only have a vt1211 section:

##########################################################################

chip "vt1211-*" "vt8231-*"
#
#
#ignore in6
#set config 12
ignore in0
ignore in1
ignore temp1
ignore temp2
ignore temp4
ignore temp5
ignore temp6
ignore temp7
#ignore fan1
#ignore fan2
#
label in3 "+5V"
label in2 "VCore1"
label in5 "+3.3V"
label in4 "+12V"

label temp3 "CPU"

label fan2 "System"
label fan1 "CPU"
ignore fan1


#
# All voltage calculations have the form
# ((@ * 100) - 3) / (K * 95.8), (@ * K * 0.958) + .03
# where K = R2 / (R1 + R2).
# Use the following K values based on input voltage.
# This of course assumes the mobo has the resistors
# recommended by Via in the datasheet.
# Voltage K
# VCore 1.0
# 2.5 0.833333333
# 3.3 (in5 internal) 0.62962963
# 3.3 (3.3V ext.) 0.595238095
# 5.0 0.4
# 12.0 0.175438596
# ok, whatever ... I fudged these below to get them to agree with the values
# that were shown in bios.

# VCORE1
compute in2 ((@ * 100) - 3) / (1.0000 * 95.8), (@ * 1.0000 * 0.958) + .03
# +3.3V
compute in5 ((@ * 100) - 3) / (0.6296 * 95.8), (@ * 0.6296 * 0.958) + .03
# +12v
compute in4 ((@ * 100) - 3) / (0.175438596 * 95.8), (@ * 0.175438596 *
0.958) +
               .03
# +5V
compute in3 ((@ * 100) - 3) / (0.4 * 95.8), (@ * 0.4 * 0.958) + .03

set vrm 9.1
set in2_min 1.2 * 0.95
set in2_max 1.2 * 1.05
set in3_min 5.0 * 0.95
set in3_max 5.0 * 1.05
set in4_min 12.0 * 0.95
set in4_max 12.0 * 1.05
set in5_min 3.3 * 0.95
set in5_max 3.3 * 1.05
# compute temp3 (@ - 65) / 0.9686, (@ * 0.9686) + 65
# Guido Brunner found this formula to copy with the non-
# linearity in temp3
#
# compute temp3 (@*@*0.0046)-(@*0.088)-0.748, (@*0.9686)+65
compute temp3 @ * 0.9756097 - 73.439, (@ + 73.439) / 0.9756097

set temp3_hyst 65
set temp3_over 70
# fan2 (system fan)
set fan1_div 2
set fan2_div 2
set fan1_min 1500
set fan2_min 1500

> BTW, I hope
> you started from the default configuration file shipped with lm_sensors
> 2.10.1 and not an older version, as it was significantly updated to
> properly support the new Linux 2.6 version of the driver.

And go though all of that config stuff that does not make sense for my
board?
I just see that temp sensors might have been renumbered?
It looks like I was using temp3 but now they are called temp1 and temp2.

> This looks all OK to me. As you can see the temperature files are
> there.

Indeed.
Temp3 was renamed to temp1.
Thanks!

