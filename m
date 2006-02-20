From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 20 Feb 2006 09:24:03 +0000
Subject: [lm-sensors] QDI Platinix 2E/333 chip w83627hf-isa-0290
Message-Id: <Y5j9Kih2.1140427443.3504950.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <200602200845.32417.condor@stz-bg.com>
In-Reply-To: <200602200845.32417.condor@stz-bg.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi John,

> i use lm_sensors 2.10.0 and i have problems:
>
> lsmod:
> ----
> i2c_i801                8588  0
> eepro100               27280  0
> w83627hf               22800  0
> hwmon_vid               3072  1 w83627hf
> hwmon                   3204  1 w83627hf
> eeprom                  6416  0
> i2c_isa                 4480  1 w83627hf
> i2c_core               17664  4 i2c_i801,w83627hf,eeprom,i2c_isa
> ----
>
> w83627hf-isa-0290
> Adapter: ISA adapter
> VCore 1:   +1.47 V  (min =  +1.41 V, max =  +1.55 V)
> VCore 2:   +4.08 V  (min =  +1.41 V, max =  +1.55 V)       ALARM

+4.08V is the max possible measurement on this chip, which means that
this input is saturated. Most likely it isn't used, and should be
ignored. The specifications for your motherboard mention 8 monitored
voltages, and the Winbond W83627HF has 9, so it is expected that one of
them is unused.

You'll have to edit /etc/sensors.conf. Find the "w83627hf-*" section,
and there, comment out the following lines:
#    set in1_min vid*0.95
#    set in1_max vid*1.05

And instead, add:
    ignore in1

> +3.3V:     +3.30 V  (min =  +3.14 V, max =  +3.47 V)
> +5V:       +5.13 V  (min =  +4.76 V, max =  +5.24 V)
> +12V:     +12.22 V  (min = +10.82 V, max = +13.19 V)
> -12V:     -11.95 V  (min = -13.18 V, max = -10.80 V)
> -5V:       +2.84 V  (min =  -5.25 V, max =  -4.75 V)       ALARM

This input is probably used for something different, or maybe not used at
all. Try temporarily commenting out the "compute in6", "set in6_min"
and "set in6_max" lines and see if the new reading makes sense. If it
changes all the time, it means it isn't connected. If it is stable, it
must be connected and we'll have to find out to what.

> V5SB:      +5.51 V  (min =  +4.76 V, max =  +5.24 V)       ALARM

The value is a bit high, but not by that much. Maybe your PSU is really
providing this voltage. You should check in the BIOS setup screen, anc
compare with the value displayed there (same is true for all other
values, BTW). If 5VSB has the same value in your BIOS, you may consider
increasing in8_max to get rid of the alarm. If the value is different in
the BIOS, write it down, and we'll have to figure out the proper
compute line for this input.

> VBat:      +3.23 V  (min =  +2.40 V, max =  +3.60 V)
> fan1:        0 RPM  (min = 168750 RPM, div = 8)              ALARM
> fan2:     3183 RPM  (min =   -1 RPM, div = 8)              ALARM
> fan3:        0 RPM  (min = 168750 RPM, div = 8)              ALARM

I guess you have only one fan connected to the motherboard. If so, try
the following settings:

   set fan1_min 0
   ignore fan1
   set fan2_min 3000
   label fan2 "CPU Fan"
   set fan3_min 0
   ignore fan3

> temp1:       +34?C  (high =    +0?C, hyst =    +1?C)   sensor = thermistor
> ALARM
> temp2:     +45.0?C  (high =   +75?C, hyst =   +70?C)   sensor = diode
> (beep)
> temp3:     +57.0?C  (high =   +75?C, hyst =   +70?C)   sensor = thermistor

Temperature readings look sane, but the temp1 limits need to be set to
prevent the alarm from triggering. Try:

   set temp1_over 50
   set temp1_hyst 45

By comparing with the values displayed by your BIOS, you should be able
to find out appropriate labels for the temperature inputs. Don't expect
the exact same temperature values though, as the BIOS usually isn't
idling as efficiently as Linux is.

> Do any body can say me how i fix these ALARM's because this is impossible
> i to have +4.08V for VCore 2 that the max is +1.55V and anothers ALARM's

The hints above should get you started.

Keep in mind that max and min limits are kind of misnomers. They really
are high and low limits. This is about monitoring, not setting
constraints. Setting max to +1.55V, for example, is simply going to
trigger an alarm if the measured value is above +1.55V. It cannot force
the input to stay below +1.55V.

--
Jean Delvare

