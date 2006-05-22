From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Mon, 22 May 2006 20:31:01 +0000
Subject: [lm-sensors] ASUS P4P 800 and sensors.conf
Message-Id: <44721F85.6040109@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <44709DB9.7000006@wanadoo.fr>
In-Reply-To: <44709DB9.7000006@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hello,

> I am using an ASUS P4P800 motherboard, and I cannot manage it to get
> lm-sensors to work properly ; I mean some output values are obviously
> quite wrong  :
> 
>> w83627thf-isa-0290 Adapter: ISA adapter in0:       +1.57 V  (min =  +1.46 V, max =  +1.60 V)
>> in1:       +3.14 V  (min =  +2.85 V, max =  +3.47 V)              e/claude/senso
>> in2:       +3.23 V  (min =  +3.14 V, max =  +3.47 V)
>> in3:       +2.96 V  (min =  +2.85 V, max =  +3.15 V)
>> in4:       +4.08 V  (min =  +0.34 V, max =  +0.80 V)       ALARM
>> in7:       +2.99 V  (min =  +2.83 V, max =  +3.12 V)
>> in8:       +0.29 V  (min =  +2.40 V, max =  +3.60 V)       ALARM
>> fan1:     1795 RPM  (min = 11250 RPM, div = 8)              ALARM
>> fan2:     2235 RPM  (min = 5113 RPM, div = 4)              ALARM
>> fan3:        0 RPM  (min =  620 RPM, div = 128)              ALARM
>> temp1:       +50?C  (high =   +60?C, hyst =   +17?C)   sensor = thermistor
>> temp2:     +41.0?C  (high =   +80?C, hyst =   +75?C)   sensor = thermistor
>> temp3:     -48.0?C  (high =   +80?C, hyst =   +75?C)   sensor = thermistor
>> vid:      +1.525 V  (VRM Version 9.0)
>> alarms:
>> beep_enable:
>>           Sound alarm enabled
> 
> I am ashamed to say that I didn't find the solution to get lm-sensors
> work ,  so I could need some good help to get a working sensors.conf for
> this motherboard and also the explication of the thing in order to
> understand how to solve this problem next time.

There is a problem that the chip manufacturers must scale down the the voltages 
to fit the ADC converters to its range. Problem is that the manuf. are free
to choose whatever resistors for scaling.

If you use acpi, please can you send us the dsdt.bin
file?

You can obtain it via cat /proc/acpi/dsdt > /tmp/dsdt.bin

Thanks,
regards
Rudolf

