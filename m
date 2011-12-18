From: Charles <c@catcons.co.uk>
Date: Sun, 18 Dec 2011 11:08:18 +0000
Subject: Re: [lm-sensors] ASUS P8H67-V temperatures and voltages
Message-Id: <4EEDC6D2.8020200@catcons.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <5F95FFA0E7734A8C8482C93BDC03F4C1@portable2>
In-Reply-To: <5F95FFA0E7734A8C8482C93BDC03F4C1@portable2>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 18/12/11 15:23, Ian Dobson wrote:
> 
> --------------------------------------------------
> From: "Charles" <c@catcons.co.uk>
> Sent: Sunday, December 18, 2011 8:50 AM
> To: <lm-sensors@lm-sensors.org>
> Subject: [lm-sensors] ASUS P8H67-V temperatures and voltages
> forsensors3.conf
> 
>> Hello :)
>>
>> In case anybody is interested in creating a sensors3.conf for this
>> motherboard, here are some temperatures and voltages from an essentially
>> idle system displayed by:
>> * BIOS
>> * ASUS AI monitoring software running on WXP
>> * GkrellM running on Linux
>>
>> BIOS and AI temperatures
>>
>>  CPU:        38-40 degrees
>>  Motherboard: 34.0 degrees
>>
>> GKrellM temperatures
>>
>>  Cores (all *.0)
>>    Core 0: 37.0 to 39.0
>>    Core 1: 39.0 to 48.0 (with a max jump of 9.0!)
>>  Others (all *.[05] except SYSTIN *.0)
>>    SYSTIN:       34.0 to 35.0
>>    CPUTIN:       83.5 to 92.5
>>    AUXTIN:       77.5 to 78.5
>>    PECI Agent 0: 39.5 to 41.0
>>
>> BIOS and AI voltages
>>
>>  Vcore:  0.944
>>  +12 V: 12.096
>>  +5V:    5.000
>>  +3.3V:  3.344
>>
>> GKrellM voltages
>>
>>  in0: 0.71 to 0.83
>>  in1: 1.01
>>  in2: 3.34
>>  in3: 3.34
>>  in4: 1.00
>>  in5: 2.04
>>  in7: 3.38 to 3.39
>>  in8: 3.34
>>  Note: in6 not displayed by GKrellM.
>>
>> Best
>>
>> Charles
>>
>> _______________________________________________
>> lm-sensors mailing list
>> lm-sensors@lm-sensors.org
>> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
> Hi,
> 
> What does sensors from the terminal prompt show?
> 
> Regards
> Ian Dobson

Thanks Ian :)

It shows (with degree signs removed):

nct6776-isa-0290
Adapter: ISA adapter
in0:           +0.78 V  (min =  +0.00 V, max =  +1.74 V)
in1:           +1.01 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
in2:           +3.34 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
in3:           +3.34 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
in4:           +1.00 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
in5:           +2.04 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
in7:           +3.39 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
in8:           +3.34 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
[snip fan speeds]
SYSTIN:        +31.0C  (high =  +0.0C, hyst =  +0.0C)  ALARM  sensor thermistor
CPUTIN:        +92.5C  (high = +81.0C, hyst = +76.0C)  ALARM  sensor thermistor
AUXTIN:        +78.5C  (high = +80.0C, hyst = +75.0C)  sensor = thermistor
PECI Agent 0:  +35.0C
cpu0_vid:     +2.050 V
intrusion0:   OK
intrusion1:   ALARM

coretemp-isa-0000
Adapter: ISA adapter
Core 0:       +32.0C  (high = +82.0C, crit = +102.0C)

coretemp-isa-0001
Adapter: ISA adapter
Core 1:       +37.0C  (high = +82.0C, crit = +102.0C)

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
