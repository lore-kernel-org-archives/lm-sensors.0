From: "Ian Dobson" <i.dobson@planet-ian.com>
Date: Sun, 06 Feb 2011 16:03:15 +0000
Subject: Re: [lm-sensors] Standalone driver for W83677HG-I, NCT6775F,
Message-Id: <DFEA73D7CE2849AA9EACC4440D5BB4C1@portable2>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110205175852.GA26672@ericsson.com>
In-Reply-To: <20110205175852.GA26672@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org



--------------------------------------------------
From: "Jean Delvare" <khali@linux-fr.org>
Sent: Sunday, February 06, 2011 4:53 PM
To: "Ian Dobson" <i.dobson@planet-ian.com>
Cc: <lm-sensors@lm-sensors.org>
Subject: Re: [lm-sensors] Standalone driver for W83677HG-I, NCT6775F, 
NCT6776F voltage input multipliers

> On Sun, 6 Feb 2011 14:37:48 +0100, Ian Dobson wrote:
>> OK Here's the infomation
>> nct6776-isa-0290
>> Adapter: ISA adapter
>> Vcore:       +1.18 V  (min =  +0.00 V, max =  +1.74 V)
>> in1:         +1.02 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
>> AVCC:        +3.36 V  (min =  +2.98 V, max =  +3.63 V)
>> +3.3V:       +3.34 V  (min =  +2.98 V, max =  +3.63 V)
>> in4:         +1.03 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
>> in5:         +2.04 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
>> in6:         +0.78 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
>> 3VSB:        +3.42 V  (min =  +2.98 V, max =  +3.63 V)
>> Vbat:        +3.30 V  (min =  +2.70 V, max =  +3.30 V)   ALARM
>> fan1:        550 RPM  (min =    0 RPM)  ALARM
>> fan2:       1013 RPM  (min =    0 RPM)  ALARM
>> fan3:          0 RPM  (min =    0 RPM)  ALARM
>> fan4:        824 RPM  (min =    0 RPM)  ALARM
>> fan5:          0 RPM  (min =    0 RPM)  ALARM
>> temp1:       +24.0°C  (high =  +0.0°C, hyst =  +0.0°C)  ALARM  sensor 
>> >> thermistor
>> temp2:       -60.0°C  (high = +80.0°C, hyst = +75.0°C)  sensor = diode
>> temp3:       +38.0°C  (high = +80.0°C, hyst = +75.0°C)  sensor >> thermistor
>> cpu0_vid:   +2.050 V
>>
>> and BIOS
>> CPU temp 43
>> MB temp 25
>>
>> CPU Volt 1.114-1.1176
>> 3.3Volt     3.36 - 3.34
>> 5Volt     5.160
>> 12Volt  12.288
>>
>> So it looks as if in4 * 5 is 5Volt, in5 * 6 is 12volt. This is on a asus
>> p8p67 pro, but I've seen the same values on a asus p8p67 delux.
>
> in4 * 5 = 5V is possible, in5 * 6 = 12V is not. 2.04 is the saturation
> value for the ADC so it looks like in5 isn't used on your system. I'd
> rather think that in1 * 12 = 12V.
>
>> Looking in the n6776f specification if looks as if AUXTIN(temp3) and in6
>> share the same pin (pin 109) so we can't have both enabled.
>
> This was the case on the W83667HG already, so I'm not surprised, and it
> should be very easy to implement in the driver.
>
> -- 
> Jean Delvare

Yep, your right, here's the config I'm now using and the output

chip "nct6775-*" "nct6776-*"
# nct6776 values for Asus p8p67 pro
    label temp1 "Motherboard"
    ignore temp2
    label temp3 "CPU"

    label in0 "Vcore"
    set in0_min  1.1 * 0.85
    set in0_max  1.1 * 1.20

    label in1 "+12V"
    compute in1 @ * 12, @ / 12
    set in1_min  12 * 0.90
    set in1_max  12 * 1.15

    label in2 "AVCC"
    set in2_min  3.3 * 0.90
    set in2_max  3.3 * 1.10

    label in3 "+3.3V"
    set in3_min  3.3 * 0.90
    set in3_max  3.3 * 1.10

    label in4 "+5V"
    compute in4 @ * 5, @ / 5
    set in4_min  5 * 0.90
    set in4_max  5 * 1.10

    ignore in6

    label in7 "3VSB"
    set in7_min  3.3 * 0.90
    set in7_min  3.3 * 0.90
    set in7_max  3.3 * 1.10

    label in8 "Vbat"
    set in8_min  3.0 * 0.90
    set in8_max  3.0 * 1.15

nct6776-isa-0290
Adapter: ISA adapter
Vcore:       +1.18 V  (min =  +0.94 V, max =  +1.32 V)
+12V:       +12.29 V  (min = +10.85 V, max = +13.82 V)
AVCC:        +3.36 V  (min =  +2.98 V, max =  +3.63 V)
+3.3V:       +3.34 V  (min =  +2.98 V, max =  +3.63 V)
+5V:         +5.16 V  (min =  +4.52 V, max =  +5.52 V)
in5:         +2.04 V  (min =  +1.80 V, max =  +2.04 V)   ALARM
3VSB:        +3.42 V  (min =  +2.98 V, max =  +3.63 V)
Vbat:        +3.30 V  (min =  +2.70 V, max =  +3.46 V)
fan1:        526 RPM  (min =    0 RPM)  ALARM
fan2:        995 RPM  (min =    0 RPM)  ALARM
fan3:          0 RPM  (min =    0 RPM)  ALARM
fan4:        773 RPM  (min =    0 RPM)  ALARM
fan5:          0 RPM  (min =    0 RPM)  ALARM
Motherboard: +23.0°C  (high =  +0.0°C, hyst =  +0.0°C)  ALARM  sensor = 
thermistor
CPU:         +37.5°C  (high = +80.0°C, hyst = +75.0°C)  sensor = 
thermistor
cpu0_vid:   +2.050 V

Note 5V and 12V correspond to bios within 0.01volt

Regards
Ian Dobson
 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
