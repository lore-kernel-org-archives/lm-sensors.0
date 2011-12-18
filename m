From: "Ian Dobson" <i.dobson@planet-ian.com>
Date: Sun, 18 Dec 2011 11:04:40 +0000
Subject: Re: [lm-sensors] ASUS P8H67-V temperatures and voltages
Message-Id: <0DD9373E102B497293C3C1E17EBDC0CB@portable2>
List-Id: <lm-sensors.vger.kernel.org>
References: <5F95FFA0E7734A8C8482C93BDC03F4C1@portable2>
In-Reply-To: <5F95FFA0E7734A8C8482C93BDC03F4C1@portable2>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


--------------------------------------------------
From: "Charles" <c@catcons.co.uk>
Sent: Sunday, December 18, 2011 11:56 AM
To: "Ian Dobson" <i.dobson@planet-ian.com>; <lm-sensors@lm-sensors.org>
Subject: Re: [lm-sensors] ASUS P8H67-V temperatures and voltages 
forsensors3.conf

> On 18/12/11 15:23, Ian Dobson wrote:
>>
>> --------------------------------------------------
>> From: "Charles" <c@catcons.co.uk>
>> Sent: Sunday, December 18, 2011 8:50 AM
>> To: <lm-sensors@lm-sensors.org>
>> Subject: [lm-sensors] ASUS P8H67-V temperatures and voltages
>> forsensors3.conf
>>
>>> Hello :)
>>>
>>> In case anybody is interested in creating a sensors3.conf for this
>>> motherboard, here are some temperatures and voltages from an essentially
>>> idle system displayed by:
>>> * BIOS
>>> * ASUS AI monitoring software running on WXP
>>> * GkrellM running on Linux
>>>
>>> BIOS and AI temperatures
>>>
[SNIP]
> It shows (with degree signs removed):
>
> nct6776-isa-0290
> Adapter: ISA adapter
> in0:           +0.78 V  (min =  +0.00 V, max =  +1.74 V)
> in1:           +1.01 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
> in2:           +3.34 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
> in3:           +3.34 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
> in4:           +1.00 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
> in5:           +2.04 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
> in7:           +3.39 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
> in8:           +3.34 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
> [snip fan speeds]
> SYSTIN:        +31.0C  (high =  +0.0C, hyst =  +0.0C)  ALARM  sensor > thermistor
> CPUTIN:        +92.5C  (high = +81.0C, hyst = +76.0C)  ALARM  sensor > thermistor
> AUXTIN:        +78.5C  (high = +80.0C, hyst = +75.0C)  sensor = thermistor
> PECI Agent 0:  +35.0C
> cpu0_vid:     +2.050 V
> intrusion0:   OK
> intrusion1:   ALARM
>
> coretemp-isa-0000
> Adapter: ISA adapter
> Core 0:       +32.0C  (high = +82.0C, crit = +102.0C)
>
> coretemp-isa-0001
> Adapter: ISA adapter
> Core 1:       +37.0C  (high = +82.0C, crit = +102.0C)

Hi,

Try adding this to your sensors3.conf

chip "nct6775-*" "nct6776-*"
# nct6776 values for Asus p8p67 pro
    label temp1 "MB"
    set temp1_max 38
    set temp1_max_hyst 35

    ignore temp2
    ignore temp3

    set fan1_min 200
    set fan2_min 400
    set fan3_min 300
    set fan4_min 200
    set fan5_min 200

    label in0 "Vcore"
    set in0_min  1.1 * 0.9
    set in0_max  1.1 * 1.15

    label in1 "+12V"
    compute in1 @ * 12, @ / 12
    set in1_min  12 * 0.95
    set in1_max  12 * 1.1

    label in2 "AVCC"
    set in2_min  3.3 * 0.95
    set in2_max  3.3 * 1.1

    label in3 "+3.3V"
    set in3_min  3.3 * 0.95
    set in3_max  3.3 * 1.1

    label in4 "+5V"
    compute in4 @ * 5, @ / 5
    set in4_min  5 * 0.95
    set in4_max  5 * 1.1
    ignore in5

    label in7 "3VSB"
    set in7_min  3.3 * 0.95
    set in7_max  3.3 * 1.1

    label in8 "Vbat"
    set in8_min  3.3 * 0.95
    set in8_max  3.3 * 1.1

These parameters are based on my asus p8p67 pro.

Regards
Ian Dobson
 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
