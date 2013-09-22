From: singumal <qdmd-pu1o@dea.spamcon.org>
Date: Sun, 22 Sep 2013 18:41:13 +0000
Subject: Re: [lm-sensors] ASRock IMB-170 configuration help
Message-Id: <9ceu399m2oivthd2jf912gt0dlc6c2r9mv@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <jaf739to4p5c3erfh5rc33qk1mg2iopfoo@4ax.com>
In-Reply-To: <jaf739to4p5c3erfh5rc33qk1mg2iopfoo@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

singumal <qdmd-pu1o@dea.spamcon.org> wrote:

>Guenter Roeck <linux@roeck-us.net> wrote:
>
>>On 09/16/2013 07:50 PM, singumal wrote:
>>> Guenter Roeck <linux@roeck-us.net> wrote:
>>>
>>>> On Fri, Sep 13, 2013 at 06:42:26PM -0700, singumal wrote:
>>>>> Now that I can read sensors for this ASRock IMB-170 board (see list t=
hread "Re: Cannot
>>>>> compile w83627ehf standalone driver"), I need to configure it.  I don=
't see any info
>>>>> poking around the lm-sensors.org site or in a web search.  Here is th=
e "sensors" output
>>>>
>>>> ASRock has a tuning utility which includes xml files for their various=
 boards.
>>>> The file for your board includes
>>>>
>>>>     <Voltage Enable=3D"1">
>>>>             <Item Index=3D"0" Name=3D"CPU_VCORE_V" Enable=3D"1">Vcore =
Voltage</Item>
>>>>             <Item Index=3D"1" Name=3D"P3P3_V" Enable=3D"1">+3.3V Volta=
ge</Item>
>>>>             <Item Index=3D"2" Name=3D"P5P0_V" Enable=3D"1">+5.0V Volta=
ge</Item>
>>>>             <Item Index=3D"3" Name=3D"P12_V" Enable=3D"1">+12V Voltage=
</Item>
>>>>             <Item Index=3D"4" Name=3D"DRAM_V" Enable=3D"1" VoltageCont=
rol=3D"DRAM_V">DRAM Voltage</Item>
>>>>             <Item Index=3D"5" Name=3D"CPU_NB_V" Enable=3D"0" VoltageCo=
ntrol=3D"CPU_NB_V">CPU NB Voltage</Item>
>>>>             <Item Index=3D"6" Name=3D"NB_V" Enable=3D"0" VoltageContro=
l=3D"NB_V">NB Voltage</Item>
>>>>             <Item Index=3D"7" Name=3D"HT_V" Enable=3D"0" VoltageContro=
l=3D"HT_V">HT Voltage</Item>
>>>>         </Voltage>
>>>>
>>>> Based on that, you can assign voltages from in0..in7. You'll have to f=
igure out
>>>> the scale used for in1 (3.3V) and in3(12V); best might be to record vo=
ltages
>>>> in the BIOS and compare with the actual readings. The other voltages l=
ook ok as
>>>> far as I can see.
>>>>
>>>>> (less the coretemp info) with the 3.3.4 sensors.conf.default as /etc/=
sensors3.conf:
>>>>>
>>>>> w83627uhg-isa-0290
>>>>> Adapter: ISA adapter
>>>>> in0:           +0.86 V  (min =3D  +0.00 V, max =3D  +1.74 V)
>>>>> in1:           +1.83 V  (min =3D  +0.61 V, max =3D  +1.02 V)  ALARM
>>>>> AVCC:          +5.12 V  (min =3D  +4.49 V, max =3D  +5.49 V)
>>>>> +5V:           +5.14 V  (min =3D  +4.49 V, max =3D  +5.51 V)
>>>>> in4:           +1.71 V  (min =3D  +0.80 V, max =3D  +0.62 V)  ALARM
>>>>> in5:           +1.70 V  (min =3D  +1.80 V, max =3D  +1.64 V)  ALARM
>>>>> 5VSB:          +5.12 V  (min =3D  +4.49 V, max =3D  +5.49 V)
>>>>> Vbat:          +3.37 V  (min =3D  +2.69 V, max =3D  +3.64 V)
>>>>> fan1:            0 RPM  (min =3D    0 RPM, div =3D 32)  ALARM
>>>>> fan2:         6026 RPM  (min =3D 21093 RPM, div =3D 16)  ALARM
>>>>
>>>> That is really on the high side. Wonder if the fan is configured corre=
ctly.
>>>>
>>>> Guenter
>>>>
>>>>> SYSTIN:        +42.0=B0C  (high =3D  +1.0=B0C, hyst =3D -76.0=B0C)  A=
LARM  sensor =3D thermistor
>>>>> PECI Agent 1:  +26.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  s=
ensor =3D Intel PECI
>>>>> intrusion0:   ALARM
>>>>>
>>>
>>> Guenter,
>>>
>>> Thank you.  Using that information, and experimenting, I am
>>> closer now (see below).  Questions:
>>>
>>> The default lm-sensors config also has in8 for this chip, which
>>> does seem to be hooked up per voltage reading, and might well be
>>> battery as labeled in default.  I wonder why it's not in their
>>> XML?
>>>
>>You would have to ask the vendor.
>>
>>> Why are SYSTIN limits defaulting to such odd values?  What does
>>> SYSTIN stand for?
>>>
>>It is the board temperature. It is labeled SYSTIN in the SuperIO
>>chip documentation.
>>
>>> I can't set SYSTIN to get rid of the alarm - neither SYSTIN_high
>>> nor SYSTIN_max work, the driver complains.
>>>
>>I suspect there may be a problem with the driver, but it is hard
>>to nail down as I don't have the hardware. Technically, I suspect
>>that the SYSTIN limits need to be read from a different register
>>location. That is just a wild guess, though. Maybe Jean reads
>>this e-mail and has an idea.
>>
>>What does the driver say if you set those limits ?
>>
>>> What is PECI Agent 1?  How would I label/set/ignore it since the
>>> name has spaces?  Is it measuring the same thing as coretemp, or
>>> something different?
>>>
>>That is the CPU temperature. See
>>http://en.wikipedia.org/wiki/Platform_Environment_Control_Interface.
>>
>>> Why can't I set a fan divisor?  It causes complaint from driver.
>>> doc/fan-divisors doesn't mention that this may happen.
>>>
>>> Oddly, when I set fan2_min to 3000, it also changed the divisor
>>> to 4; and when set to 1500, to 8.  This isn't mentioned in the
>>> document either.  But it fixes my problem.
>>>
>>The driver sets the divisor automatically.
>>
>>Guenter
>>
>>>
>>> Output now:
>>>
>>> w83627uhg-isa-0290
>>> Adapter: ISA adapter
>>> Vcore:         +0.85 V  (min =3D  +0.80 V, max =3D  +0.90 V)
>>> +3.3V:         +3.36 V  (min =3D  +3.09 V, max =3D  +3.51 V)
>>> +5.0V:         +5.16 V  (min =3D  +4.49 V, max =3D  +5.49 V)
>>> +12V:         +12.08 V  (min =3D +10.55 V, max =3D +12.97 V)
>>> DRAM-V:        +1.71 V  (min =3D  +1.50 V, max =3D  +1.90 V)
>>> CPU-NB-V:      +1.70 V  (min =3D  +1.50 V, max =3D  +1.90 V)
>>> HT-V:          +5.16 V  (min =3D  +4.49 V, max =3D  +5.49 V)
>>> Vbat:          +3.40 V  (min =3D  +2.69 V, max =3D  +3.64 V)
>>> CPU Fan:      5818 RPM  (min =3D 1506 RPM, div =3D 8)
>>> SYSTIN:        +46.0=B0C  (high =3D  +1.0=B0C, hyst =3D -76.0=B0C)  ALA=
RM  sensor =3D thermistor
>>> PECI Agent 1:  +29.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sen=
sor =3D Intel PECI
>>>
>>>
>>> Using config:
>>>
>>> chip "w83627uhg-*"
>>>
>>>      label in0 "Vcore"
>>>      label in1 "+3.3V"
>>>      label in2 "+5.0V"
>>>      label in3 "+12V"
>>>      label in4 "DRAM-V"
>>>      label in5 "CPU-NB-V"
>>>      label in6 "NB-V"
>>>      label in7 "HT-V"
>>>      label in8 "Vbat"   # Assumed
>>>
>>>      label fan1 "System Fan"
>>>      label fan2 "CPU Fan"
>>>
>>>      ignore fan1        # For this particular chassis, not hooked up
>>>      ignore intrusion0
>>>
>>>      compute in1 (@*3.3/1.8), (@*1.8/3.3)
>>>      compute in3 (@*12/5.1), (@*5.1/12)
>>>
>>>      set in0_min 0.80
>>>      set in0_max 0.90
>>>      set in1_min 3.1
>>>      set in1_max 3.5
>>>      set in4_min 1.5
>>>      set in4_max 1.9
>>>      set in5_min 1.5
>>>      set in5_max 1.9
>>>
>>>      #set fan2_div 1    # Doesn't work with this driver, causes complai=
nt
>>>      set fan2_min 1500
>>>
>>>      #set SYSTIN_high 80  # Doesn't work
>>>      #set SYSTIN_max 80   # Doesn't work
>>>
>
>On your question: with "SYSTIN_max 80" in sensors3.conf at line 37, gives:
>
>Starting lm_sensors: loading module coretemp w83627ehf Error: File /etc/se=
nsors3.conf,
>line 37: Unknown feature name
>w83627uhg-isa-0290: No such subfeature known
>
>Aha, figured it out, reread docs, sensors -u shows that SYSTIN is
>really temp1 (and PECI one is really temp2), set temp1_max, it
>works.
>
>So now I'm good, no more alarms.  My final config and complete
>sensors output:
>
>
>chip "w83627uhg-*"
>
>    label in0 "Vcore"
>    label in1 "+3.3V"
>    label in2 "+5.0V"
>    label in3 "+12V"
>    label in4 "DRAM-V"
>    label in5 "CPU-NB-V"
>    label in6 "NB-V"
>    label in7 "HT-V"
>    label in8 "Vbat"   # Assumed
>
>    label fan1 "System Fan"
>    label fan2 "CPU Fan"
>
>    label temp1 "MB Temperature"
>    label temp2 "CPU Temperature"
>
>    ignore fan1        # For this particular chassis, not hooked up
>    ignore intrusion0
>
>    # Values are simple, empirical by comparing w/BIOS
>
>    compute in0 (@*0.896/0.85), (@*0.85/0.896)
>    compute in1 (@*3.4/1.83), (@*1.83/3.4)
>    compute in3 (@*12/5.14), (@*5.14/12)
>
>    set in0_min 0.80
>    set in0_max 0.95
>    set in1_min 3.1
>    set in1_max 3.5
>    set in4_min 1.5
>    set in4_max 1.9
>    set in5_min 1.5
>    set in5_max 1.9
>
>    set fan2_min 1500
>
>    set temp1_max 80
>    set temp1_max_hyst 75
>
>
>
>
>[root@x59 ~]# service lm_sensors restart
>Stopping lm_sensors:                                       [  OK  ]
>Starting lm_sensors: loading module coretemp w83627ehf     [  OK  ]
>[root@x59 ~]# sensors
>w83627uhg-isa-0290
>Adapter: ISA adapter
>Vcore:            +0.90 V  (min =3D  +0.80 V, max =3D  +0.95 V)
>+3.3V:            +3.40 V  (min =3D  +3.11 V, max =3D  +3.49 V)
>+5.0V:            +5.16 V  (min =3D  +4.49 V, max =3D  +5.49 V)
>+12V:            +11.99 V  (min =3D +10.47 V, max =3D +12.87 V)
>DRAM-V:           +1.71 V  (min =3D  +1.50 V, max =3D  +1.90 V)
>CPU-NB-V:         +1.70 V  (min =3D  +1.50 V, max =3D  +1.90 V)
>HT-V:             +5.16 V  (min =3D  +4.49 V, max =3D  +5.49 V)
>Vbat:             +3.37 V  (min =3D  +2.69 V, max =3D  +3.64 V)
>CPU Fan:         5818 RPM  (min =3D 1506 RPM, div =3D 8)
>MB Temperature:   +45.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sen=
sor =3D thermistor
>CPU Temperature:  +28.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sen=
sor =3D Intel PECI
>
>coretemp-isa-0003
>Adapter: ISA adapter
>Core 3:       +34.0=B0C  (high =3D +87.0=B0C, crit =3D +105.0=B0C)
>
>coretemp-isa-0002
>Adapter: ISA adapter
>Core 2:       +29.0=B0C  (high =3D +87.0=B0C, crit =3D +105.0=B0C)
>
>coretemp-isa-0001
>Adapter: ISA adapter
>Core 1:       +29.0=B0C  (high =3D +87.0=B0C, crit =3D +105.0=B0C)
>
>coretemp-isa-0000
>Adapter: ISA adapter
>Core 0:       +28.0=B0C  (high =3D +87.0=B0C, crit =3D +105.0=B0C)
>
>[root@x59 ~]#
>
>
>

Noticed an error message on physical console when restarting
lm_sensors, look in syslog, here are all the messages:

Sep 19 08:38:49 localhost kernel: Trying to free nonexistent resource
<0000000000000295-0000000000000296>
Sep 19 08:38:49 localhost kernel: coretemp coretemp.0: TjMax is 105 C.
Sep 19 08:38:49 localhost kernel: coretemp coretemp.1: TjMax is 105 C.
Sep 19 08:38:49 localhost kernel: coretemp coretemp.2: TjMax is 105 C.
Sep 19 08:38:49 localhost kernel: coretemp coretemp.3: TjMax is 105 C.
Sep 19 08:38:49 localhost kernel: w83627ehf: Found W83627UHG chip at 0x290


Does that resource message indicate misconfiguration, or some other problem?

Also, minor changes to my previous config, worked fine on 1st
box, but tried another of the same platform, had a few alarms, so
set more limits; current config and output:


chip "w83627uhg-*"

    label in0 "Vcore"
    label in1 "+3.3V"
    label in2 "+5.0V"
    label in3 "+12V"
    label in4 "DRAM-V"
    label in5 "CPU-NB-V"
    label in6 "NB-V"
    label in7 "HT-V"
    label in8 "Vbat"   # Assumed

    label fan1 "System Fan"
    label fan2 "CPU Fan"

    label temp1 "MB Temperature"
    label temp2 "CPU Temperature"

    ignore fan1        # For this particular chassis, not hooked up
    ignore intrusion0
    ignore in6         # Driver doesn't seem to show it

    # Values chosen are simple, some empirical by comparing w/BIOS

    compute in0 (@*0.896/0.85), (@*0.85/0.896)
    compute in1 (@*3.4/1.83), (@*1.83/3.4)
    compute in3 (@*12/5.14), (@*5.14/12)

    set in0_min 0.80
    set in0_max 0.95
    set in1_min 3.1
    set in1_max 3.5
    set in2_min 4.7
    set in2_max 5.3
    set in3_min 11
    set in3_max 13
    set in4_min 1.5
    set in4_max 1.9
    set in5_min 1.5
    set in5_max 1.9
    set in7_min 4.7
    set in7_max 5.3
    set in8_min 2.8
    set in8_max 3.6

    set fan2_min 1500

    set temp1_max 80
    set temp1_max_hyst 75

---

[root@tm3 ~]# sensors
w83627uhg-isa-0290
Adapter: ISA adapter
Vcore:            +0.91 V  (min =3D  +0.80 V, max =3D  +0.95 V)
+3.3V:            +3.40 V  (min =3D  +3.11 V, max =3D  +3.49 V)
+5.0V:            +5.16 V  (min =3D  +4.69 V, max =3D  +5.29 V)
+12V:            +11.99 V  (min =3D +11.03 V, max =3D +13.03 V)
DRAM-V:           +1.71 V  (min =3D  +1.50 V, max =3D  +1.90 V)
CPU-NB-V:         +1.70 V  (min =3D  +1.50 V, max =3D  +1.90 V)
HT-V:             +5.12 V  (min =3D  +4.69 V, max =3D  +5.29 V)
Vbat:             +3.37 V  (min =3D  +2.79 V, max =3D  +3.60 V)
CPU Fan:         5818 RPM  (min =3D 1506 RPM, div =3D 8)
MB Temperature:   +43.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sens=
or =3D thermistor
CPU Temperature:  +28.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sens=
or =3D Intel PECI

coretemp-isa-0003
Adapter: ISA adapter
Core 3:       +34.0=B0C  (high =3D +87.0=B0C, crit =3D +105.0=B0C)

coretemp-isa-0002
Adapter: ISA adapter
Core 2:       +26.0=B0C  (high =3D +87.0=B0C, crit =3D +105.0=B0C)

coretemp-isa-0001
Adapter: ISA adapter
Core 1:       +28.0=B0C  (high =3D +87.0=B0C, crit =3D +105.0=B0C)

coretemp-isa-0000
Adapter: ISA adapter
Core 0:       +25.0=B0C  (high =3D +87.0=B0C, crit =3D +105.0=B0C)

[root@tm3 ~]#




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
