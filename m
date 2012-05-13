From: James <bjlockie@lockie.ca>
Date: Sun, 13 May 2012 02:55:13 +0000
Subject: Re: [lm-sensors] missing fan RPMS
Message-Id: <4FAF2291.4020101@lockie.ca>
List-Id: <lm-sensors.vger.kernel.org>
References: <4FAED541.7080201@lockie.ca>
In-Reply-To: <4FAED541.7080201@lockie.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 05/12/12 22:37, Guenter Roeck wrote:
> On Sat, May 12, 2012 at 10:03:25PM -0400, James wrote:
>> On 05/12/12 21:53, Guenter Roeck wrote:
>>> On Sat, May 12, 2012 at 05:25:21PM -0400, James wrote:
>>>>
>>>> I bought a new motherboard (ASRock 970 Extreme3) and it doesn't report the fans.
>>>>
>>> Hi James,
>>>
>>>> nct6776-isa-0290
>>>> Adapter: ISA adapter
>>>> Vcore:        +0.86 V  (min =  +0.00 V, max =  +1.74 V)
>>>> in1:          +1.85 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
>>>> AVCC:         +3.33 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
>>>> +3.3V:        +3.33 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
>>>> in4:          +1.58 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
>>>> in5:          +1.70 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
>>>> 3VSB:         +3.44 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
>>>> Vbat:         +3.34 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
>>>> fan1:           0 RPM  (min =    0 RPM)  ALARM
>>>> fan2:           0 RPM  (min =    0 RPM)  ALARM
>>>> fan3:           0 RPM  (min =    0 RPM)  ALARM
>>>> fan4:           0 RPM  (min =    0 RPM)  ALARM
>>>> fan5:           0 RPM  (min =    0 RPM)  ALARM
>>>
>>> Weird. We had a bug where fans where not recognized at all, but I have not seen
>>> zero RPM reported.
>>>
>>> If you like, you can try my experimental new driver from https://github.com/groeck/nct6775.
>>>
>>>> sensors also doesn't show +12V or +5V.
>>>>
>>> Those will be among in1, in4, and in5. The ADC is range of the NCT6776F limited,
>>> so the voltage passed to the chip is scaled. Question is which one is which.
>>> Have a look at http://www.lm-sensors.org/wiki/VoltageLabelsAndScaling;
>>> maybe it helps you finding out.
>>>
>>> Guenter
>>>
>>
>> I forgot to mention that the RPM of the fans is reported in the BIOS screen.
>>
> You did, actually. So we know the rpm is measured, we just don't know if it is done
> through the NCT6776F.
> 
> Guenter
> 
Can I assume it is using the module I compiled because it has some data?
Still no fan data
nct6776-isa-0290
Adapter: ISA adapter
Vcore:          +0.97 V  (min =  +0.00 V, max =  +1.74 V)
in1:            +1.85 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
AVCC:           +3.33 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
+3.3V:          +3.31 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
in4:            +1.58 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
in5:            +1.70 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
3VSB:           +3.44 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
Vbat:           +3.36 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
fan1:             0 RPM  (min =    0 RPM)  ALARM
fan2:             0 RPM  (min =    0 RPM)  ALARM
fan3:             0 RPM  (min =    0 RPM)  ALARM
fan4:             0 RPM  (min =    0 RPM)  ALARM
fan5:             0 RPM  (min =    0 RPM)  ALARM
SYSTIN:         +37.0 C  (high =  +0.0 C, hyst =  +0.0 C)  ALARM  sensor = thermistor
CPUTIN:         +37.0 C  (high = +80.0 C, hyst = +75.0 C)  sensor = thermistor
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
