From: marc@corky.net (Just Marc)
Date: Wed, 05 Apr 2006 10:24:28 +0000
Subject: [lm-sensors] lmsensors in 2.6.16 on a Tyan 2882-D motherboard,
Message-Id: <44339ADC.1080504@corky.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <44325498.8060805@corky.net>
In-Reply-To: <44325498.8060805@corky.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi
>   
>> It's my first time setting lm-sensors up, the process was pretty 
>> painless after skimming the docs and FAQ.
>>     
>
> Ah sorry about that. We are now in process of setting new wiki-based
> website at http://www.lm-sensors.org/trac
>
> Feel free to improve it.
>
>   
Great, trac is good.
>> The chips detected for my board are lm85 and w83627hf,  I tried using 
>> the debian package supplied sensors.conf and the Tyan supplied at 
>> ftp://ftp.tyan.com/software/lms/lms_s2882.tgz .  Tyan say that this file
>> is for version 2.8.0 though I'm using the one which comes with the 
>> 2.6.16 kernel.
>>     
>
> This should work without problems imho.
>
>   
It does, but ...
>> I would like to monitor all of the data provided by the sensors, though 
>> it appears that I'm not getting a good reading on some of the voltages,  
>> temperatures and all the rest seem right, though.
>>
>> After a few further hours of reading various docs I still was not able 
>> to find a way to get it just right.  As this is the first time I'm using 
>> this package I don't even know how much of a skew is acceptable for 
>> these particular readings but some of the readings seem way out of the 
>> suggested min/max ranges.
>>     
>
> It may happen, Raphael what is your oppinion about this?
>
>   
>> # sensors
>> adm1027-i2c-0-2e
>> Adapter: SMBus AMD8111 adapter at 10e0
>>
>> DDR 2.5V:  +2.607 V  (min =  +2.37 V, max =  +2.63 V)   ALARM
>>     
>
> MAybe you have chosen some DDR voltage offset in BIOS? I guess
> the 2.6 should be OK maybe they used some not so precise resistors
> in the divider so this might explain the skew too. (Or the machine
> is too hot and resitor skew too)
>
>   
I believe it's set to Auto, though I'll have to check.
>> DDR VTT:   +1.304 V  (min =  +1.14 V, max =  +1.27 V)   ALARM
>>     
>
> I think this should be 50% of DDR 2.5, and because you have 1st higher
> this is also bit higher.
>
>   
I'm less worried about such a small skew.
>> 3VSB:      +3.347 V  (min =  +3.13 V, max =  +3.47 V)  
>> +5 V:     +5.039 V  (min =  +4.74 V, max =  +5.26 V)  
>> +12V:     +12.109 V  (min = +11.38 V, max = +12.62 V)  
>> fan2:      4895 RPM  (min = 4000 RPM)                    
>> fan1:      5089 RPM  (min =    0 RPM)                    
>> fan3:         0 RPM  (min =    0 RPM)                    
>> fan4:         0 RPM  (min =    0 RPM)                    
>> CPU2 Temp:+67.25?C  (low  =   +10?C, high =   +50?C)     ALARM 
>> sys Temp: +50.25?C  (low  =   +10?C, high =   +35?C)     ALARM
>> CPU1 Temp:+67.75?C  (low  =   +10?C, high =   +35?C)     ALARM 
>> vid:      +1.400 V  (VRM Version 2.4)
>>
>> w83627hf-isa-0290
>> Adapter: ISA adapter
>> CPU2 Volt: +1.42 V  (min =  +1.33 V, max =  +1.47 V)             
>> CPU1 Volt: +1.44 V  (min =  +1.33 V, max =  +1.47 V)             
>> 3.3V:      +3.30 V  (min =  +3.14 V, max =  +3.47 V)             
>> DDR VTT:   +1.30 V  (min =  +2.85 V, max =  +3.47 V)       ALARM 
>> DDR 2.5V:  +2.58 V  (min =  +0.34 V, max =  +0.80 V)       ALARM 
>>     
>
> Here are some strage limits. They are not set in the config file and they should
> similar way as for the first chip. Raphael I would suggest to fix this
> in your config file.
>
>   
>> CPU2 Fan: 5487 RPM  (min = 5625 RPM, div = 2)              ALARM 
>> CPU1 Fan: 5625 RPM  (min = 2657 RPM, div = 2)                    
>> Fan5:        0 RPM  (min = 2657 RPM, div = 2)              ALARM 
>>     
>
> The fan limits can be set by you to correct values (depends on your fan anyway)
>
>   
Right, this is a non issue.
>> Output of sensors with the debian-supplied config file:
>>     
>
> The voltage wiring is manufacturer specific so it is expected that
> this will have more problems.
>
>   
w83627hf-isa-0290
Adapter: ISA adapter
+12V:      +4.92 V  (min = +10.82 V, max = +13.19 V)       ALARM
-12V:      -1.59 V  (min = -13.18 V, max = -10.80 V)       ALARM

I'm mostly concerned about these values, they are not skews ...  are 
they just mis-named 5V and 1.5V readings?
> Regards
> Rudolf
>
>   


