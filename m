From: singumal <qdmd-pu1o@dea.spamcon.org>
Date: Tue, 17 Sep 2013 02:50:32 +0000
Subject: Re: [lm-sensors] ASRock IMB-170 configuration help
Message-Id: <cigf39111bleumsov8fg2nk4ej7jrdn3ma@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <jaf739to4p5c3erfh5rc33qk1mg2iopfoo@4ax.com>
In-Reply-To: <jaf739to4p5c3erfh5rc33qk1mg2iopfoo@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Guenter Roeck <linux@roeck-us.net> wrote:

>On Fri, Sep 13, 2013 at 06:42:26PM -0700, singumal wrote:
>> Now that I can read sensors for this ASRock IMB-170 board (see list thre=
ad "Re: Cannot
>> compile w83627ehf standalone driver"), I need to configure it.  I don't =
see any info
>> poking around the lm-sensors.org site or in a web search.  Here is the "=
sensors" output
>
>ASRock has a tuning utility which includes xml files for their various boa=
rds.
>The file for your board includes
>
>    <Voltage Enable=3D"1">
>            <Item Index=3D"0" Name=3D"CPU_VCORE_V" Enable=3D"1">Vcore Volt=
age</Item>
>            <Item Index=3D"1" Name=3D"P3P3_V" Enable=3D"1">+3.3V Voltage</=
Item>
>            <Item Index=3D"2" Name=3D"P5P0_V" Enable=3D"1">+5.0V Voltage</=
Item>
>            <Item Index=3D"3" Name=3D"P12_V" Enable=3D"1">+12V Voltage</It=
em>
>            <Item Index=3D"4" Name=3D"DRAM_V" Enable=3D"1" VoltageControl=
=3D"DRAM_V">DRAM Voltage</Item>
>            <Item Index=3D"5" Name=3D"CPU_NB_V" Enable=3D"0" VoltageContro=
l=3D"CPU_NB_V">CPU NB Voltage</Item>
>            <Item Index=3D"6" Name=3D"NB_V" Enable=3D"0" VoltageControl=3D=
"NB_V">NB Voltage</Item>
>            <Item Index=3D"7" Name=3D"HT_V" Enable=3D"0" VoltageControl=3D=
"HT_V">HT Voltage</Item>           =20
>        </Voltage>
>
>Based on that, you can assign voltages from in0..in7. You'll have to figur=
e out
>the scale used for in1 (3.3V) and in3(12V); best might be to record voltag=
es
>in the BIOS and compare with the actual readings. The other voltages look =
ok as
>far as I can see.
>
>> (less the coretemp info) with the 3.3.4 sensors.conf.default as /etc/sen=
sors3.conf:
>>=20
>> w83627uhg-isa-0290
>> Adapter: ISA adapter
>> in0:           +0.86 V  (min =3D  +0.00 V, max =3D  +1.74 V)
>> in1:           +1.83 V  (min =3D  +0.61 V, max =3D  +1.02 V)  ALARM
>> AVCC:          +5.12 V  (min =3D  +4.49 V, max =3D  +5.49 V)
>> +5V:           +5.14 V  (min =3D  +4.49 V, max =3D  +5.51 V)
>> in4:           +1.71 V  (min =3D  +0.80 V, max =3D  +0.62 V)  ALARM
>> in5:           +1.70 V  (min =3D  +1.80 V, max =3D  +1.64 V)  ALARM
>> 5VSB:          +5.12 V  (min =3D  +4.49 V, max =3D  +5.49 V)
>> Vbat:          +3.37 V  (min =3D  +2.69 V, max =3D  +3.64 V)
>> fan1:            0 RPM  (min =3D    0 RPM, div =3D 32)  ALARM
>> fan2:         6026 RPM  (min =3D 21093 RPM, div =3D 16)  ALARM
>
>That is really on the high side. Wonder if the fan is configured correctly.
>
>Guenter
>
>> SYSTIN:        +42.0=B0C  (high =3D  +1.0=B0C, hyst =3D -76.0=B0C)  ALAR=
M  sensor =3D thermistor
>> PECI Agent 1:  +26.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sens=
or =3D Intel PECI
>> intrusion0:   ALARM
>>=20

Guenter,

Thank you.  Using that information, and experimenting, I am
closer now (see below).  Questions:

The default lm-sensors config also has in8 for this chip, which
does seem to be hooked up per voltage reading, and might well be
battery as labeled in default.  I wonder why it's not in their
XML?

Why are SYSTIN limits defaulting to such odd values?  What does
SYSTIN stand for?

I can't set SYSTIN to get rid of the alarm - neither SYSTIN_high
nor SYSTIN_max work, the driver complains.

What is PECI Agent 1?  How would I label/set/ignore it since the
name has spaces?  Is it measuring the same thing as coretemp, or
something different?

Why can't I set a fan divisor?  It causes complaint from driver.
doc/fan-divisors doesn't mention that this may happen.

Oddly, when I set fan2_min to 3000, it also changed the divisor
to 4; and when set to 1500, to 8.  This isn't mentioned in the
document either.  But it fixes my problem.


Output now:

w83627uhg-isa-0290
Adapter: ISA adapter
Vcore:         +0.85 V  (min =3D  +0.80 V, max =3D  +0.90 V)
+3.3V:         +3.36 V  (min =3D  +3.09 V, max =3D  +3.51 V)
+5.0V:         +5.16 V  (min =3D  +4.49 V, max =3D  +5.49 V)
+12V:         +12.08 V  (min =3D +10.55 V, max =3D +12.97 V)
DRAM-V:        +1.71 V  (min =3D  +1.50 V, max =3D  +1.90 V)
CPU-NB-V:      +1.70 V  (min =3D  +1.50 V, max =3D  +1.90 V)
HT-V:          +5.16 V  (min =3D  +4.49 V, max =3D  +5.49 V)
Vbat:          +3.40 V  (min =3D  +2.69 V, max =3D  +3.64 V)
CPU Fan:      5818 RPM  (min =3D 1506 RPM, div =3D 8)
SYSTIN:        +46.0=B0C  (high =3D  +1.0=B0C, hyst =3D -76.0=B0C)  ALARM  =
sensor =3D thermistor
PECI Agent 1:  +29.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sensor =
=3D Intel PECI


Using config:

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

    ignore fan1        # For this particular chassis, not hooked up
    ignore intrusion0

    compute in1 (@*3.3/1.8), (@*1.8/3.3)
    compute in3 (@*12/5.1), (@*5.1/12)

    set in0_min 0.80
    set in0_max 0.90
    set in1_min 3.1
    set in1_max 3.5
    set in4_min 1.5
    set in4_max 1.9
    set in5_min 1.5
    set in5_max 1.9

    #set fan2_div 1    # Doesn't work with this driver, causes complaint
    set fan2_min 1500

    #set SYSTIN_high 80  # Doesn't work
    #set SYSTIN_max 80   # Doesn't work




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
