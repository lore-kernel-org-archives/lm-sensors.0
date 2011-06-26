From: Jaap de Wolff <jaap@de-wolff.org>
Date: Sun, 26 Jun 2011 10:57:53 +0000
Subject: Re: [lm-sensors] ASRock E350M1 configuration
Message-Id: <4E0710B1.3080405@de-wolff.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4DFB9AF0.500@de-wolff.org>
In-Reply-To: <4DFB9AF0.500@de-wolff.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi,

I modified my config file for in2,3,7 and 8 as you told me.
Now it tells me for in8 that it is 3.42 V which is (very) high for a=20
CMOS battery.

The voltage of the DRAM can be set in BIOS (as almost all voltages are=20
on this MB), between 1.3 and 2 V.
But you are right, if I adjust it to 1.8 V, the reading of in4 does not=20
change, so it has to be another value.

Most read voltage values are pretty  stable.
The only values that are really fluctuating are in0 and in1, both=20
between 0.95 and 1.35 V
Other voltages only change 0.01 or at most 0.02 V.

In4 fluctuates between 1.37 and 1.38V.

The PCH voltage can be set in the bios, but changing it does not change=20
any reading.

Jaap

Op 6/23/2011 0:34, Guenter Roeck schreef:
> On Wed, Jun 22, 2011 at 04:55:16PM -0400, Jean Delvare wrote:
>> Hi Japp,
>>
>> On Fri, 17 Jun 2011 20:20:32 +0200, Jaap de Wolff wrote:
>>> I did build a w83627ehf.ko driver for Ubuntu Natty system with the
>>> ubuntu 2.6.38-8-generic kernel.
>>>
>>> After some experiments I came to the following configuration file  for
>>> my ASRock E350M1 MB:
>>>
>>> The used config file and the sensor output are at the bottom of this po=
st.
>>>
>>> The values of in4 - in7 I am quite sure about:
>>> The values match almost exact the values of what I see in the bios read=
ing.
>>> The same is true for the temp1 and temp2, and for the fan speed.
>>>
>>> The raw value of in8 is just below the value of in7, but that it is
>>> reading the -12V is just a wild guess.
>> It's a very long time since I last saw a board monitoring -12V. I'm not
>> sure if it is still used at all.
>>
>>> in2 and in3 are always exactly 3.3 V, so I suppose those are Vcc
>> Yes, these are internally routed and scaled so always correct.
>>
>>> in0 and in1 fluctuate between 0.95 and 1.35 V where in0 rises first when
>>> there is more processor activity.
>>> I called them VCore 1 and 2, but not sure about those.
>> Strange, you have a single CPU so there should be a single Vcore value.
>>
> I'm not sure if the voltage on the PCH or a similar chip in the system
> is variable as well. Maybe that is what is happening here.
>
> Guenter
>
>>> there is always a reading in the sensors that is labeled cpu0_vid, and
>>> always has the value 0.0V, but I have no idea what this is telling, or
>>> how I can remove it.
>> cpu0_vid is the voltage your CPU is requesting from the motherboard, if
>> the signal is properly routed to the monitoring chip. In your case it
>> doesn't work, either because the decoding for your CPU model isn't
>> known (you'd get a warning in the kernel log) or because the signal
>> isn't routed to the monitoring chip.
>>
>> You can read more about VID pins at:
>> http://www.lm-sensors.org/browser/lm-sensors/trunk/doc/vid
>> (Not necessarily up-to-date, but still a good introduction.)
>>
>> If you want to ignore cpu0_vid, just add:
>>
>>     ignore cpu0_vid
>>
>> as for any other input.
>>
>>> Anyone can confirm or give comment on those settings?
>>>
>>> Jaap
>>>
>>>
>>> $ cat /etc/sensors.d/sensors.conf
>>> ################################ start config part ###
>>> chip "nct6775-*"
>>>
>>>       label in0 "VCore1"
>>>       label in1 "VCore2"
>>>       label in2 "VCC1"
>>>       label in3 "VCC2"
>>>       label in4 "DRAM"
>>>       label in5 "+1.8"
>>>       label in6 "5V"
>>>       label in7 "12V"
>>>       label in8 "-12V"
>> Can't be. in7 and in8 are internally routed and scaled (just as in2 and
>> in3). In fact the default configuration for this chip reads:
>>
>>      label in2 "AVCC"
>>      label in3 "+3.3V"
>>      label in7 "3VSB"
>>      label in8 "Vbat"
>>
>>      set in2_min  3.3 * 0.90
>>      set in2_max  3.3 * 1.10
>>      set in3_min  3.3 * 0.90
>>      set in3_max  3.3 * 1.10
>>      set in7_min  3.3 * 0.90
>>      set in7_max  3.3 * 1.10
>>      set in8_min  3.0 * 0.90
>>      set in8_max  3.0 * 1.10
>>
>> So your configuration should start from there.
>>
>>> # +12V -12V and +5V use dividers
>>>       compute in6 @*3,  @/3
>>>       compute in7 @*3.5,  @/3.5
>>>       compute in8 @*-3.5,  @/-3.5
>>>
>>>       set in0_min   0.9
>>>       set in0_max   1.5
>>>       set in1_min   0.9
>>>       set in1_max   1.5
>>>       set in2_min   3.3*0.95
>>>       set in2_max   3.3*1.05
>>>       set in3_min   3.3*0.95
>>>       set in3_max   3.3*1.05
>>>       set in4_min   1.3
>>>       set in4_max   2.0
>>>       set in5_min   1.8
>>>       set in5_max   2.1
>>>       set in6_min   5.0*0.95
>>>       set in6_max   5.0*1.05
>>>       set in7_min   12*0.95
>>>       set in7_max   12*1.05
>>>       set in8_min   -12*0.95
>>>       set in8_max   -12*1.05
>>>
>>> # Fans
>>>      label fan1      "Chassis Fan1"
>>>      label fan2      "CPU Fan"
>>>      label fan3      "Chassis Fan2"
>>>      ignore fan4
>>>
>>>      set fan2_min    700
>>>
>>> # Temperatures
>>>      label temp1     "Sys Temp"
>>>      label temp2     "CPU Temp"
>>>      label temp3     "Temp?"
>> Most probably unused so you can use an "ignore" statement.
>>
>>>      set temp1_max       80
>>>      set temp1_max_hyst  75
>>>
>>>
>>> chip "k10temp-*"
>>>
>>>     label temp1 "Cpu Core Temp"
>>>
>>> ######################################################## end config part
>>> ############
>>> $ sensors
>>> ######################### begin of sensor output #######################
>>> nct6775-isa-0290
>>> Adapter: ISA adapter
>>> VCore1:       +0.96 V  (min =3D  +0.90 V, max =3D  +1.50 V)
>>> VCore2:       +0.98 V  (min =3D  +0.90 V, max =3D  +1.50 V)
>>> VCC1:         +3.30 V  (min =3D  +3.14 V, max =3D  +3.47 V)
>>> VCC2:         +3.30 V  (min =3D  +3.14 V, max =3D  +3.47 V)
>>> DRAM:         +1.38 V  (min =3D  +1.30 V, max =3D  +2.00 V)
>> This is pretty low for DDR3, nominal is 1.5V.
>>
>>> +1.8:         +1.84 V  (min =3D  +1.80 V, max =3D  +2.04 V)
>>> 5V:           +4.94 V  (min =3D  +4.75 V, max =3D  +5.26 V)
>> One of these is probably +12V. What does the BIOS show exactly? If some
>> values oscillate, write them all down, it's very useful to guess
>> scaling factors.
>>
>>> 12V:         +12.10 V  (min =3D +11.42 V, max =3D +12.60 V)
>>> -12V:        -11.98 V  (min =3D -11.42 V, max =3D -12.60 V)
>>> Chassis Fan1:   0 RPM  (min =3D    0 RPM, div =3D 128)
>>> CPU Fan:     3245 RPM  (min =3D  703 RPM, div =3D 16)
>>> Chassis Fan2:   0 RPM  (min =3D    0 RPM, div =3D 128)
>>> Sys Temp:     +50.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sens=
or >>> thermistor
>>> CPU Temp:     +55.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sens=
or >>> thermistor
>>> Temp?:         -8.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sens=
or >>> thermistor
>>> cpu0_vid:    +0.000 V
>>>
>>> k10temp-pci-00c3
>>> Adapter: PCI adapter
>>> Cpu Core Temp: +70.0=B0C  (high =3D +70.0=B0C, crit =3D +75.0=B0C)
>>>
>>> ######################### end of sensor output #######################
>>
>> --=20
>> Jean Delvare
>> http://khali.linux-fr.org/wishlist.html
>>
>> _______________________________________________
>> lm-sensors mailing list
>> lm-sensors@lm-sensors.org
>> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
