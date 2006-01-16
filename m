From: stevenkaratnyk@rogers.com (Steven Karatnyk)
Date: Mon, 16 Jan 2006 19:41:47 +0000
Subject: [lm-sensors] seeking a W83687THF patch for 2.6.15 (re: ticket
Message-Id: <43CBF6FB.6040802@rogers.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <43BDFEEE.4070408@rogers.com>
In-Reply-To: <43BDFEEE.4070408@rogers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

Steven Karatnyk wrote:
> I'm not certain if there is a 3rd 
> fan header on the mobo... would have to check manual.
>   

Checked and there is indeed a 3rd header

> Interestingly  enough, in the process of confirming the relation of the 
> in4 setting, I discovered a bug in the BIOS:  After testing, I returned 
> the Vdimm value in the BIOS to default (2.60V).  After the boot, Sensors 
> then reported in4 still at 2.72V.  I rebooted back into the BIOS, and 
> its own monitoring display confirmed the same value for Vdimm.  I 
> switched the Vdimm setting from default to a manual setting of 2.60V.  
> Sensors again reports 2.72V,  and rebooting again confirms this in the 
> BIOS reading.  I'll check later on after a cold boot, if things are 
> different.  Anyways, I digress.
>   

Just for posterity, after a cold boot the Vdimm value did revert to its 
proper value (as set in the BIOS). 


Jean Delvare wrote:
>> Interesting, I'm noticing the limits for temp1 are fluctuating on their 
>> own. For example,
>>     
>
> That's really weird. These registers are not supposed to change values
> unless you ask for a change. Please see if you can refine your
> observations as to when and how these values change.
>   

Will try, but I haven't observed any correlation yet as to why it 
changes.  I should, however, clarify that "fluctuating" was an 
inappropriate label. 
The values will remain steady for a good long while, even across days.  
But then, without apparent reason, "sensors" will unveil that they have 
changed.  For example, I'm now seeing:
temp1:       +38?C  (high =    +2?C, hyst =   +52?C)   sensor = diode

> 2.6.15.1 is out now. I've generated a patch which will apply properly
> on top of it:
> http://jdelvare.net2.nerim.net/sensors/linux-2.6.15.1-hwmon-w83687thf.diff
>   

Thanks.  Applied no problem.

>> (...) Anyways, when I had a look at my BIOS settings,  I recorded 
>> the following:
>>
>> CPU Internal Temp.    43C
>> CPU External Temp   51C
>>     
>
> It's odd that the external temperature is higher than the internal
> temperature. The picture you pointed us to above is much more logical
> (internal temperature is higher).

I hadn't thought twice about this until I read your comment.  I 
rechecked the BIOS and this is indeed the reported situation.  I think 
that, in the case of my BIOS revision, the Soltek BIOS programmer 
probably just incorrectly/accedently associated the internal temp with 
the wrong label....of course this is only my working theory.

> It's really hard to guess which temperature sensors correspond to which
> BIOS measurement. I guess that the motherboard manufacturer wouldn't
> have added a secondary monitoring chip (the LM90) if not to monitor the
> CPU temperature more accurately, so my guess is that "CPU External
> Temp" is lm90 temp2. "CPU Internal Temp" may be w83687thf temp2 or
> temp3.
>
>   
>> System Temp                 41C
>>     
>
> And this would be w83687thf temp1. This is really only a guess at this
> point though. A BIOS disassembly and/or additional information from DFI
> would be needed here.
>
> You may also put the CPU under load under Linux (with some compilation
> or compression work, or by using cpuburn) and see which temperatures
> raise quickly.
>   

I set up some Ksysguard panels with the LM90 and Winbond Temps and then 
monitored the system under load.

LM90_CPU_Temp: 75C    LM90_M/B_Temp: 43
Temp1: 42                 Temp2: 61.5            Temp3: 71.5

It looks like:
- the internal CPU temp is measured by the w83687's Temp3 and the LM90's 
CPU Temp...which corresponds to the BIOS' "CPU Internal Temp" is another 
question, but I believe its the Winbond IC (* will explain in the 
discussion about the Fans below)
- the external CPU temp is measured by the w83687's Temp2
- the system/motherboard temp is measured by the w83687's Temp1 and the 
LM90's M/B Temp


>   
>> Fan1 Speed                  1394 RPM
>> Fan2 Speed                  1360RPM
>>     
>
> Both values are similar so it'll be hard to say which is which. You may
> try to physically slow down either fan to differenciate between them.
>   
I opened up the case and unplugged the exhaust fan (not necessarily a 
trivial task when dealing with a SFF case).
The CPU Fan corresponds to the BIOS' "Fan1 Speed".  It, however, maps to 
the Winbond's Fan2 sensor.

>> Smart Fan1 Temperature 60C
>> Fan1 Tolerance Value [1]
>> Smart Fan2 Temperature 45C
>> Fan2 Tolerance Value [1]
>>     
>
> These must correspond to the "thermal cruise" mode. 

Yes, precisely (pg.30 of the datasheet). 

> We don't support it for now.
>   

It still works.  Although my experiences more or less mirror that 
described in http://www.silentpcreview.com/article235-page5.html (from 
the "BIOS Fan Control" section on pg.5 through to the end of "FAN 
(MIS)BEHAVIOUR" section on pg.6).  Buggy BIOS programming seems to 
plaque its effectiveness too (more on this in a second).

Anyways, while placing the system under load, it appeared that the 
trigger for the SmartFan1 (throttling of the CPU fan) was the Winbond 
temp3.  Seemingly, if that sensor's reading breached >66C for more then 
two occasions in a row, the cpu fan ramped up (The LM90's CPU temp was 
already bouncing around in low 70s and seemed to play no part).  * This 
is why I stated earlier that I believe the BIOS' "CPU Internal Temp" 
corresponds to the Winbond IC and not the LM90.

It's interesting to note that the threshold observed for the fan 
throttling (both ramping up and decelerating) occurred at 5C more then 
the trigger value I set in the BIOS ("Smart Fan1 Temperature 60C" and a 
"Fan1 Tolerance Value [1]") !   This is not the first time I've observed 
a 5C discrepency that has plagued the effectiveness of the "SmartFan" 
feature.  Last year,  I developed a good line of dialogue with Soltek's 
rep Lydia because I was observing some sort of misbehaviour between the 
BIOS and the sensor values.  It is hard for me to both remember 
accurately and explain in few words **, but essentially, IIRC, coming 
out of S3 the fans were at full speed because the trigger on the 
SpeedFan was being shifted down 5C irregardless of the temperatures.  
Similarly, I would observe the trigger being shifted up 5C during normal 
operation.  Lydia passed my commentary off to their BIOS engineer, and 
then provided me with a beta BIOS to test (it also contained some other 
features I was seeking).  It seemed, for the most part, to correct the 
5C speedfan trigger shifting behaviour.   I later updated to the most 
recent official BIOS release.  Unfortunately, several of the changes 
that were in the beta BIOS were no longer in the official release - 
including correct fan control coming out of S3 (this from testing within 
Windows, as I don't currently have S3 working with this system in 
Linux).  It was the very testing performed today which has revealed to 
me that the 5C shift up bug also found its way back into the current 
BIOS.  Sadly, Soltek has appeared to have abandoned the motherboard 
market, and Lydia was released quite a while back.  I doubt they're 
providing BIOS support still too, as nothing new has been released for a 
good long while.  

I also wonder if there is a connection somehow with this misbehaviour 
and the changing temp1 limit values I'm observing.

** If needed or if it might help in anyway (in relation to the current 
discussion or perhaps even for assisting future efforts to support for 
the "thermal cruise" mode),  I can find and provide links to the 
discussion I had with Lydia and they would provide a more detailed 
description of my observations about the wonky SpeedFan behaviour.


>> Vcore                             1.40V
>>     
>
> in0
>
>   
>> +1.5V                              1.50V
>>     
>
> in1
>
>   
>> +3.3V                              3.29V
>>     
>
> in2
>
>   
>> VDIMM                         2.59V       ....... although, of course, 
>> its now at 2.72V, as described above
>>     
>
> in4
>
>   
>> +5V                                 5.04V
>>     
>
> most probably in3
>
>   
>> VBAT                              3.29V
>>     
>
> in8
>
>   
>> 5VSB                              4.96V
>>     
>
> most probably in7
>
>   
Looks good.


>> - Interesting that there is no +12V reading   
> True, that's unusual, but not unseen.  

Would this be strictly a BIOS limitation of not exposing such monitoring? 

>> Let me know if you need anything else, or clarification of anything.
>>     
>
> Well, any additional information you can get regarding the temperature
> sensors is welcome. For now, please find attached a sample
> configuration file which should be suitable for your motherboard. Copy
> it to /etc/sensors.conf and give it a try, please.
>
> This is really only a first short, voltages should be OK, but fans and
> temperatures will need more work to find out the appropriate labels.
>   

Have done.  Without integrating any of the info I mentioned above into 
the /etc/sensors.conf, the following is observed:

$ sensors
lm90-i2c-0-4c
Adapter: SMBus Via Pro adapter at 5000

M/B Temp:    +36?C  (low  =   +10?C, high =   +50?C)
CPU Temp:  +52.8?C  (low  = +10.0?C, high = +70.0?C)
M/B Crit:    +70?C  (hyst =   +65?C)
CPU Crit:    +80?C  (hyst =   +75?C)

w83687thf-isa-0290
Adapter: ISA adapter
Vcore:     +1.09 V  (min =  +1.04 V, max =  +1.47 V)
+1.5V:     +1.52 V  (min =  +1.42 V, max =  +1.57 V)
+3.3V:     +3.30 V  (min =  +3.14 V, max =  +3.47 V)
+5V:       +5.03 V  (min =  +4.76 V, max =  +5.24 V)
Vdimm:     +2.59 V  (min =  +2.46 V, max =  +2.74 V)
5VSB:      +4.95 V  (min =  +4.76 V, max =  +5.24 V)
Vbat:      +3.30 V  (min =  +2.85 V, max =  +3.47 V)
fan1:        0 RPM  (min = 1102 RPM, div = 8)              ALARM
fan2:     1394 RPM  (min = 1102 RPM, div = 8)
temp1:       +39?C  (high =    +2?C, hyst =   +52?C)   sensor = diode
temp2:     +38.0?C  (high =   +80?C, hyst =   +52?C)   sensor = diode
temp3:     +56.0?C  (high =   +80?C, hyst =   +65?C)   sensor = diode
vid:      -4.825 V  (VRM Version 2.4)
alarms:
beep_enable:
          Sound alarm enabled


Notes:
- fan1 is, of course, the exhaust fan which is currently unplugged and 
sitting on my desk.
- vid is obviously incorrect

Thanks, Steven





