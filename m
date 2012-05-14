From: James <bjlockie@lockie.ca>
Date: Mon, 14 May 2012 00:08:28 +0000
Subject: Re: [lm-sensors] missing fan RPMS
Message-Id: <4FB04CFC.4080403@lockie.ca>
List-Id: <lm-sensors.vger.kernel.org>
References: <4FAED541.7080201@lockie.ca>
In-Reply-To: <4FAED541.7080201@lockie.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 05/13/12 19:18, James wrote:
> On 05/12/12 23:40, Guenter Roeck wrote:
>> On Sat, May 12, 2012 at 10:55:13PM -0400, James wrote:
>> [ ... ]
>>>>
>>> Can I assume it is using the module I compiled because it has some data?
>>> Still no fan data
>>> nct6776-isa-0290
>>> Adapter: ISA adapter
>>> Vcore:          +0.97 V  (min =  +0.00 V, max =  +1.74 V)
>>> in1:            +1.85 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
>>> AVCC:           +3.33 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
>>> +3.3V:          +3.31 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
>>> in4:            +1.58 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
>>> in5:            +1.70 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
>>> 3VSB:           +3.44 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
>>> Vbat:           +3.36 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
>>> fan1:             0 RPM  (min =    0 RPM)  ALARM
>>> fan2:             0 RPM  (min =    0 RPM)  ALARM
>>> fan3:             0 RPM  (min =    0 RPM)  ALARM
>>> fan4:             0 RPM  (min =    0 RPM)  ALARM
>>> fan5:             0 RPM  (min =    0 RPM)  ALARM
>>> SYSTIN:         +37.0 C  (high =  +0.0 C, hyst =  +0.0 C)  ALARM  sensor = thermistor
>>> CPUTIN:         +37.0 C  (high = +80.0 C, hyst = +75.0 C)  sensor = thermistor
>>> AUXTIN:          -1.5 C  (high = +80.0 C, hyst = +75.0 C)  sensor = thermistor
>>> PCH_CHIP_TEMP:   +0.0 C  
>>> PCH_CPU_TEMP:    +0.0 C  
>>> PCH_MCH_TEMP:    +0.0 C  
>>
>> Yes, because the above are only seen with the new driver.
>>
>> Still, see my other e-mail - looks like AsRock is using a gpio pin based multiplexer
>> to connect fans to the chip. I looks like specific gpio pins must be enabled to let
>> you see fan speeds.
>>
>> Guenter
>>
>>
> 
> I bought another case fan and it sees it.
> 
> $ sudo sensors
> nouveau-pci-0100
> Adapter: PCI adapter
> temp1:         +0.0 C  (high = +100.0 C, crit = +110.0 C)
> 
> fam15h_power-pci-00c4
> Adapter: PCI adapter
> power1:       74.54 W  (crit =  95.01 W)
> 
> k10temp-pci-00c3
> Adapter: PCI adapter
> temp1:        +14.4 C  (high = +70.0 C)
>                        (crit = +70.0 C, hyst = +67.0 C)
> 
> nct6776-isa-0290
> Adapter: ISA adapter
> Vcore:          +0.86 V  (min =  +0.00 V, max =  +1.74 V)
> in1:            +1.85 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
> AVCC:           +3.33 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
> +3.3V:          +3.33 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
> in4:            +1.58 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
> in5:            +1.70 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
> 3VSB:           +3.46 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
> Vbat:           +3.36 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
> fan1:          1369 RPM  (min =    0 RPM)  ALARM
> fan2:             0 RPM  (min =    0 RPM)  ALARM
> fan3:             0 RPM  (min =    0 RPM)  ALARM
> fan4:             0 RPM  (min =    0 RPM)  ALARM
> fan5:             0 RPM  (min =    0 RPM)  ALARM
> SYSTIN:         +36.0 C  (high =  +0.0 C, hyst =  +0.0 C)  ALARM  sensor = thermistor
> CPUTIN:         +35.0 C  (high = +80.0 C, hyst = +75.0 C)  sensor = thermistor
> AUXTIN:          -2.0 C  (high = +80.0 C, hyst = +75.0 C)  sensor = thermistor
> PCH_CHIP_TEMP:   +0.0 C  
> PCH_CPU_TEMP:    +0.0 C  
> PCH_MCH_TEMP:    +0.0 C  
> cpu0_vid:      +0.000 V
> intrusion0:    ALARM
> intrusion1:    ALARM
> 
> It is labelled 'Chassis fan connector 1" by the motherboard manual.
> The other is 'Chassis fan 3'
> 
> The difference is fan1 is 3 pin and fan3 is 4 pin.
> I will try moving the 4 pin over so it is only using 3 pins.
> 
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
> 

:-(
Both fans connected but only one shows up.

# sensors
nouveau-pci-0100
Adapter: PCI adapter
temp1:         +0.0 C  (high = +100.0 C, crit = +110.0 C)

fam15h_power-pci-00c4
Adapter: PCI adapter
power1:      101.17 W  (crit =  95.01 W)

k10temp-pci-00c3
Adapter: PCI adapter
temp1:        +15.2 C  (high = +70.0 C)
                       (crit = +70.0 C, hyst = +67.0 C)

nct6776-isa-0290
Adapter: ISA adapter
Vcore:          +0.86 V  (min =  +0.00 V, max =  +1.74 V)
in1:            +1.85 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
AVCC:           +3.33 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
+3.3V:          +3.33 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
in4:            +1.58 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
in5:            +1.70 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
3VSB:           +3.46 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
Vbat:           +3.36 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
fan1:          1374 RPM  (min =    0 RPM)  ALARM
fan2:             0 RPM  (min =    0 RPM)  ALARM
fan3:             0 RPM  (min =    0 RPM)  ALARM
fan4:             0 RPM  (min =    0 RPM)  ALARM
fan5:             0 RPM  (min =    0 RPM)  ALARM
SYSTIN:         +36.0 C  (high =  +0.0 C, hyst =  +0.0 C)  ALARM  sensor = thermistor
CPUTIN:         +35.5 C  (high = +80.0 C, hyst = +75.0 C)  sensor = thermistor
AUXTIN:          -1.5 C  (high = +80.0 C, hyst = +75.0 C)  sensor = thermistor
PCH_CHIP_TEMP:   +0.0 C  
PCH_CPU_TEMP:    +0.0 C  
PCH_MCH_TEMP:    +0.0 C  
cpu0_vid:      +0.000 V                                                         
intrusion0:    ALARM                                                            
intrusion1:    ALARM 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
