From: Moofie <moofie@shaw.ca>
Date: Sat, 10 Apr 2010 07:30:31 +0000
Subject: Re: [lm-sensors] Soltek K8T800Pro (it87-isa-0290),
Message-Id: <4BC02917.2090207@shaw.ca>
List-Id: <lm-sensors.vger.kernel.org>
References: <4BBA227C.7010205@shaw.ca>
In-Reply-To: <4BBA227C.7010205@shaw.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> On Thu, 08 Apr 2010 16:30:26 -0700, Moofie wrote:
>> Moofie wrote:
>>> Hello list, this is my first time posting here, and I come with some 
>>> questions about my server motherboard with the hopes that I configure 
>>> sensors on it correctly.
>>>
>>> While this Soltek board is relatively old (as the company is no longer 
>>> in business), I had never used it since the day that I bought it.  The 
>>> board was recently installed into a server role and I hope to monitor 
>>> its health from a distance.
>>>
>>> While sensors detects the correct chips installed on the board, the 
>>> values are useless.
>>>
>>> I'm wondering if anyone can shed light on how to set the values 
>>> correctly for this board.  Here's some pertinent info:
>>>
>>>
>>>
>>> ITE IT8712F, National LM90 (ISA 290h, SMBus 4Ch)
>>>
>>>
>>>
>>> acpitz-virtual-0
>>> Adapter: Virtual device
>>> temp1:       +40.0°C  (crit = +75.0°C)
>>>
>>> k8temp-pci-00c3
>>> Adapter: PCI adapter
>>> Core0 Temp:  +50.0°C
>>> Core1 Temp:  +42.0°C
>>>
>>> it87-isa-0290
> 
> This would be an IT8705F chip, not IT8712F as you wrote above.
> 

OK, I was going off of a forum post (one of a few about this specific 
motherboard, as the site is now unavailable, and finding information is 
scarce)

>>> Adapter: ISA adapter
>>> in0:         +1.31 V  (min =  +0.00 V, max =  +4.08 V)
>>> in1:         +2.54 V  (min =  +0.00 V, max =  +4.08 V)
>>> in2:         +3.28 V  (min =  +0.00 V, max =  +4.08 V)
>>> in3:         +2.90 V  (min =  +0.00 V, max =  +4.08 V)
>>> in4:         +2.91 V  (min =  +0.00 V, max =  +4.08 V)
>>> in5:         +0.96 V  (min =  +0.00 V, max =  +4.08 V)
>>> in6:         +1.12 V  (min =  +0.00 V, max =  +4.08 V)
>>> in7:         +2.94 V  (min =  +0.00 V, max =  +4.08 V)
>>> Vbat:        +3.26 V
>>> fan1:       11250 RPM  (min = 3245 RPM)
>>> fan2:       4963 RPM  (min =    0 RPM)
>>> temp1:       +26.0°C  (low  =  -1.0°C, high = +127.0°C)  sensor = 
>>> thermistor
>>> temp2:       -86.0°C  (low  =  -1.0°C, high = +127.0°C)  sensor = 
>>> thermal diode
>>> temp3:       +14.0°C  (low  =  -1.0°C, high = +127.0°C)  sensor = 
>>> thermistor
>>>
>>> lm90-i2c-0-4c
>>> Adapter: SMBus Via Pro adapter at 5000
>>> temp1:       +38.0°C  (low  =  +0.0°C, high = +70.0°C)
>>>                       (crit = +85.0°C, hyst = +75.0°C)
>>> temp2:       +63.1°C  (low  =  +0.0°C, high = +70.0°C)
>>>                       (crit = +85.0°C, hyst = +75.0°C)
>>>
>>>
>>> If I can provide more information, let me know.
>> I have been playing with the values and I feel that I have made some 
>> progress.  Identifying the sensors is difficult as they all seem to show 
>> different patterns.
>>
>> Under it87, temp1 is almost constant, it hovers around 26C, currently 
>> it's at 24C and I've seen it go as high as 27C.  Using stress (with all 
>> the different hogs), the temperature does climb, but not right away and 
>> this leads me to believe that this is indeed a sensor and it monitors 
>> the ambient/case temperature.
>>
>> temp2 is a negative value and stays constant within a 3 degree range if 
>> set to a thermal diode, if set to thermistor it seems to stay constant 
>> at negative 55.  This is all throughout multiple stress runs, both 
>> memory, i/o, disk and CPU.  I'm assuming that this sensor is not connected.
>>
>> temp3 swings wildly from -110 to about 108 degrees, and all over in 
>> between.  I've tried setting it as a thermistor or diode, and it still 
>> goes all over the place.  I'm wondering what I can do with this sensor 
>> as it's not really reading correctly.  It must be sensing something, as 
>> it does produce values all over the range, I'm just stumped as to what 
>> kind of compute function I would need to use to make this thing make any 
>> kind of sense.
> 
> If it jumps all over the place no matter the setting, then you can
> safely conclude that it is left floating and should be disabled/ignored.
> 

I visited your site and found a few examples that said the manufacturer 
left the sensor floating.  I was unaware as to what that meant exactly. 
  Thanks for letting me know.  I have now disabled all three temperature 
readings.

>> I will further ask questions about the rest of the detected chips as I 
>> get to them, though I'd appreciate any thoughts on the above temperature 
>> sensors.
> 
> Given that the board vendor used a dedicated LM90 temperature
> monitoring chip to track the CPU temperature, I wouldn't be surprised
> if most or all of the IT8705F temperatures inputs were left unused. The

I was getting that feeling through my many attempts at computing the values.

> it87 driver forcibly enables temperature monitoring channels if they
> are found all disabled when the driver is loaded. It probably shouldn't
> do that, especially given that each channel can be configured in two
> different modes (thermistor and thermal diode) and the driver has no
> way to know which mode would be correct. Incidentally, your modes
> configuration for temp1, temp2 and temp3 matches the arbitrary default
> set by the it87 driver, so it is possible that all sensors were indeed
> disabled originally.
> 

OK, understood.

> I will fix the it87 driver later today to no longer arbitrarily enable
> temperature sensors. This should clear some confusion as least on some
> boards.
>
> What temperatures are reported by the BIOS on this machine? This would
> be a valuable hint.
> 

The BIOS reports that CPU temp is at 60C and that SYS temp is at 20C.

I've run across a few posts about the CPU temperature reported via the 
windows utility and the bios reports as being off.  I know the 
manufacturer released a BIOS revision after mine, though unfortunately 
it's quite buggy and most of the people who ran/run this board 
downgraded back to the version I'm running.

I've guessed at the second temperature that the LM90 reports and used a 
calculate formula to reduce the reading by 10% as 60C is very high for 
an undervolted Opteron 165.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
