From: stevenkaratnyk@rogers.com (Steven Karatnyk)
Date: Sat, 14 Jan 2006 23:54:33 +0000
Subject: [lm-sensors] seeking a W83687THF patch for 2.6.15 (re: ticket
Message-Id: <43C98F39.6010602@rogers.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <43BDFEEE.4070408@rogers.com>
In-Reply-To: <43BDFEEE.4070408@rogers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

>>> in3: +2.99 V (min = +2.05 V, max = +3.36 V)
>>> in4: +2.59 V (min = +3.49 V, max = +2.14 V) ALARM
>>> in7: +2.94 V (min = +0.16 V, max = +0.42 V) ALARM 
>>>       
>> These ones are probably greater voltages (+5V, +12V...) scaled down. Or
>> in4 may be Vdimm.
>>   
>>     
> I think in4 is the Vdimm. IIRC, I have it set at 2.6V in the BIOS. Will
> have to check, but think its a safe bet.
>


Indeed, in4 is Vdimm.  I bumped the value in the BIOS up to 2.70V and 
sensors now reports in4 at 2.72V.  

Interestingly  enough, in the process of confirming the relation of the 
in4 setting, I discovered a bug in the BIOS:  After testing, I returned 
the Vdimm value in the BIOS to default (2.60V).  After the boot, Sensors 
then reported in4 still at 2.72V.  I rebooted back into the BIOS, and 
its own monitoring display confirmed the same value for Vdimm.  I 
switched the Vdimm setting from default to a manual setting of 2.60V.  
Sensors again reports 2.72V,  and rebooting again confirms this in the 
BIOS reading.  I'll check later on after a cold boot, if things are 
different.  Anyways, I digress.


>>> temp1: +39?C (high = -122?C, hyst = -41?C) sensor = diode ALARM
>>> temp2: +39.0?C (high = +80?C, hyst = +75?C) sensor = diode
>>> temp3: +59.0?C (high = +80?C, hyst = +75?C) sensor = diode    
>>>       
>> May be OK too. You should set temp1's limits to something more
>> reasonable though.  
>>     
> Temp3 is definitely CPU, but it looks a bit off .... I suspect the lm90
> output (CPU Temp: +54.4?C) is closer to accurate.
> Temp2 looks to be the Mobo, but it too is a bit off ... again, I suspect
> the lm90 output (M/B Temp: +37?C) is closer to the true value
>
> I'm a little uncertain about temp1 (i.e what it actually is) or why its
> limits are like that (I did do a sensors -s first.....haven't touched
> the etc/sensors.conf file yet though). I'm wondering if its a bogus
> sensor....although the "diode Alarm " makes me wonder if its actually
> tied to the BIOS alarm temp setting in anyway.

Interesting, I'm noticing the limits for temp1 are fluctuating on their 
own. For example,

$ sensors
lm90-i2c-0-4c
Adapter: SMBus Via Pro adapter at 5000

M/B Temp:    +38?C  (low  =    +0?C, high =   +70?C)
CPU Temp:  +55.9?C  (low  =  +0.0?C, high = +70.0?C)
M/B Crit:    +85?C  (hyst =   +75?C)
CPU Crit:    +85?C  (hyst =   +75?C)

w83687thf-isa-0290
Adapter: ISA adapter
in0:       +1.09 V  (min =  +0.00 V, max =  +3.84 V)
in1:       +1.50 V  (min =  +2.48 V, max =  +2.11 V)       ALARM
in2:       +3.33 V  (min =  +2.86 V, max =  +1.15 V)       ALARM
in3:       +2.99 V  (min =  +2.05 V, max =  +3.36 V)
in4:       +2.72 V  (min =  +3.49 V, max =  +0.03 V)       ALARM
in7:       +2.94 V  (min =  +0.16 V, max =  +0.42 V)       ALARM
in8:       +3.30 V  (min =  +0.38 V, max =  +3.14 V)       ALARM
fan1:     1339 RPM  (min = 9375 RPM, div = 8)              ALARM
fan2:     1394 RPM  (min = 1016 RPM, div = 8)
fan3:        0 RPM  (min = 6367 RPM, div = 2)              ALARM
temp1:       +43?C  (high =    +6?C, hyst =   -43?C)   sensor = diode   
ALARM
temp2:     +44.5?C  (high =   +80?C, hyst =   +75?C)   sensor = diode
temp3:     +59.5?C  (high =   +80?C, hyst =   +75?C)   sensor = diode
vid:      -1.200 V  (VRM Version 8.2)
alarms:
beep_enable:
          Sound alarm enabled


>> a new patch is available here:
>>
>> http://jdelvare.net2.nerim.net/sensors/hwmon-w83627hf-add-w83687thf-support.patch
>>
>> Note that it only applies to Linus' git tree (or any recent mm tree),
>> not 2.6.15 - unless you fix the few rejects manually.
>> ...
>> If you happen to test the patch linked above, please
>> report the result.
>>     
> Awesome. I'll look into that. Will report back.

Haven't tried the patch yet - been busy tracking down some other 
problems.   Will probably hold off till 2.6.15.1 comes out and then 
manually make the changes then.

>> maybe we can simply write a configuration file for your board. Can you please visit the
>> BIOS setup screens of your system and report all the hardware
>> monitoring items listed there, in order, with value? Then I'll provide
>> a configuration file for you to test.  
>>     
>
> Will do.

There is a "SmartDoc Anti-Burn Shield" Menu in my BIOS that can be seen 
here: http://www.silentpcreview.com/files/images/soltek3901/Fan-control.jpg
However, I just noticed that the user adjustable "Shutdown Temperature" 
in the BIOS version I'm running has been removed (although , as 
illustrated in the pic above, it was available in earlier revisions of 
the BIOS!).  Anyways, when I had a look at my BIOS settings,  I recorded 
the following:

CPU Internal Temp.    43C
CPU External Temp   51C
System Temp                 41C
Fan1 Speed                  1394 RPM
Fan2 Speed                  1360RPM
Vcore                             1.40V
+1.5V                              1.50V
+3.3V                              3.29V
VDIMM                         2.59V       ....... although, of course, 
its now at 2.72V, as described above
+5V                                 5.04V
VBAT                              3.29V
5VSB                              4.96V

Smart Fan1 Temperature 60C
Fan1 Tolerance Value [1]
Smart Fan2 Temperature 45C
Fan2 Tolerance Value [1]

- Interesting that there is no +12V reading
- Of course, only the bottom Smart Fan stuff is user adjustable

In the " Frequency / Voltage Control " BIOS menu, there are relevant 
entries for:

CPU Vcore Select
AGP Voltage Select
DIMM Voltage Select

All of which I have set on "Default"


Let me know if you need anything else, or clarification of anything.

Thanks, Steven






