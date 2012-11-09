From: =?ISO-8859-1?Q?Lars_P=F6tter?= <lars@ing-poetter.de>
Date: Fri, 09 Nov 2012 15:21:04 +0000
Subject: Re: [lm-sensors] Configuration File for ASRock B75 Pro3
Message-Id: <509D1F60.8060206@ing-poetter.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <509C1EBF.3000309@ing-poetter.de>
In-Reply-To: <509C1EBF.3000309@ing-poetter.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Am 09.11.2012 15:34, schrieb Guenter Roeck:
> On Thu, Nov 08, 2012 at 10:06:07PM +0100, Lars P=F6tter wrote:
>> I use the following configuration file:
>>
>> chip "nct6776-isa-0290"
>>     label in1 "+1.9V"
>>     ignore in4
>>     label in5 "+1.66V"
>>     ignore fan1
>>     label fan2 "CPU Fan"
>>     ignore fan3
>>     ignore fan4
>>     ignore fan5
>>     label SYSTIN "SystemTemperature"
>>
>>     set in1_min  1.9 * 0.90
>>     set in1_max  1.9 * 1.10
>>     set in5_min  1.66 * 0.90
>>     set in5_max  1.66 * 1.10
>>
>>     set fan2_min  900 * 0.90
>>     set fan2_max  3000 * 1.10
>>
>>     set SYSTIN_min  15
>>     set SYSTIN_max  50
>>
>>
>> But I still get these error reports in syslog:
>>
>>
>> Nov  8 21:54:36 sensord: sensord started
>> Nov  8 21:54:36 sensord: Sensor alarm: Chip nct6776-isa-0290: +1.9V:
>> +1.90 V (min =3D +0.00 V, max =3D +0.00 V) [ALARM]
>> Nov  8 21:54:36 sensord: Sensor alarm: Chip nct6776-isa-0290: +1.66V:
>> +1.66 V (min =3D +0.00 V, max =3D +0.00 V) [ALARM]
>> Nov  8 21:54:36 sensord: Sensor alarm: Chip nct6776-isa-0290: CPU Fan:
>> 1597 RPM (min =3D 0 RPM) [ALARM]
>> Nov  8 21:54:36 sensord: Sensor alarm: Chip nct6776-isa-0290: SYSTIN:
>> 27.0 C (limit =3D 0.0 C, hysteresis =3D 0.0 C) [ALARM]
>> Nov  8 21:54:36 sensord: Chip: coretemp-isa-0000
>> Nov  8 21:54:36 sensord: Adapter: ISA adapter
>> Nov  8 21:54:36 sensord:   Physical id 0: 33.0 C
>> Nov  8 21:54:36 sensord:   Core 0: 26.0 C
>> Nov  8 21:54:36 sensord:   Core 1: 26.0 C
>> Nov  8 21:54:36 sensord:   Core 2: 33.0 C
>> Nov  8 21:54:36 sensord:   Core 3: 25.0 C
>> Nov  8 21:54:36 sensord: Chip: nct6776-isa-0290
>> Nov  8 21:54:36 sensord: Adapter: ISA adapter
>> Nov  8 21:54:36 sensord:   Vcore: +0.99 V (min =3D +0.00 V, max =3D +1.7=
4 V)
>> Nov  8 21:54:36 sensord:   +1.9V: +1.90 V (min =3D +0.00 V, max =3D +0.0=
0 V)
>> [ALARM]
>> Nov  8 21:54:36 sensord:   AVCC: +3.42 V (min =3D +2.98 V, max =3D +3.63=
 V)
>> Nov  8 21:54:36 sensord:   +3.3V: +3.42 V (min =3D +2.98 V, max =3D +3.6=
3 V)
>> Nov  8 21:54:36 sensord:   +1.66V: +1.66 V (min =3D +0.00 V, max =3D +0.=
00
>> V) [ALARM]
>> Nov  8 21:54:36 sensord:   3VSB: +3.44 V (min =3D +2.98 V, max =3D +3.63=
 V)
>> Nov  8 21:54:36 sensord:   Vbat: +3.25 V (min =3D +2.70 V, max =3D +3.30=
 V)
>> Nov  8 21:54:36 sensord:   CPU Fan: 1597 RPM (min =3D 0 RPM) [ALARM]
>> Nov  8 21:54:36 sensord:   SYSTIN: 27.0 C (limit =3D 0.0 C, hysteresis =
=3D
>> 0.0 C) [ALARM]
>> Nov  8 21:54:36 sensord:   CPUTIN: 27.5 C (limit =3D 80.0 C, hysteresis =
=3D
>> 75.0 C)
>> Nov  8 21:54:36 sensord:   AUXTIN: 57.0 C (limit =3D 80.0 C, hysteresis =
=3D
>> 75.0 C)
>> Nov  8 21:54:36 sensord:   PECI Agent 0: 33.0 C
>> Nov  8 21:54:36 sensord:   cpu0_vid: +2.050 V
>> Nov  8 21:55:36 sensord: Sensor alarm: Chip nct6776-isa-0290: +1.9V:
>> +1.90 V (min =3D +0.00 V, max =3D +0.00 V) [ALARM]
>> Nov  8 21:55:36 sensord: Sensor alarm: Chip nct6776-isa-0290: +1.66V:
>> +1.66 V (min =3D +0.00 V, max =3D +0.00 V) [ALARM]
>> Nov  8 21:55:36 sensord: Sensor alarm: Chip nct6776-isa-0290: CPU Fan:
>> 1601 RPM (min =3D 0 RPM) [ALARM]
>> Nov  8 21:55:36 sensord: Sensor alarm: Chip nct6776-isa-0290: SYSTIN:
>> 27.0 C (limit =3D 0.0 C, hysteresis =3D 0.0 C) [ALARM]
>> Nov  8 21:56:36 sensord: Sensor alarm: Chip nct6776-isa-0290: +1.9V:
>> +1.91 V (min =3D +0.00 V, max =3D +0.00 V) [ALARM]
>> Nov  8 21:56:36 sensord: Sensor alarm: Chip nct6776-isa-0290: +1.66V:
>> +1.66 V (min =3D +0.00 V, max =3D +0.00 V) [ALARM]
>> Nov  8 21:56:36 sensord: Sensor alarm: Chip nct6776-isa-0290: CPU Fan:
>> 1610 RPM (min =3D 0 RPM) [ALARM]
>> Nov  8 21:56:36 sensord: Sensor alarm: Chip nct6776-isa-0290: SYSTIN:
>> 27.0 C (limit =3D 0.0 C, hysteresis =3D 0.0 C) [ALARM]
>>
>>  /usr/sbin/sensord --version
>> sensord version 3.3.1
>>
>> So it reads the config file as the labels are used, but the limits are
>> not recognized.
>>
>> I tried to ignore all the conflicting signals but ignoring SYSTIN does
>> not work.
>>
>> What am I doing wrong here?
>>
> Did you execute sensors -s ?

No I did not. Thank you for pointing that out.

It helped a bit. As I saw that the fan2_max was not needed.

But I can not do any settings for SYSTIN. With such settings I get

sensors -s
Error: File /etc/sensors.d/B75Pro3, line 20: Unknown feature name
nct6776-isa-0290: No such subfeature known

an "ignore SYSTIN" is just ignored.

I checked https://github.com/groeck/w83627ehf/blob/master/w83627ehf.c
but could not detect how I can set the limit and Hysteresis.

With this config file:

chip "nct6776-isa-0290"
    label in1 "+1.9V"
    ignore in4
    label in5 "+1.66V"
    ignore fan1
    label fan2 "CPU Fan"
    ignore fan3
    ignore fan4
    ignore fan5
    ignore SYSTIN

    set in1_min  1.9 * 0.90
    set in1_max  1.9 * 1.10
    set in5_min  1.66 * 0.90
    set in5_max  1.66 * 1.10

    set fan2_min  900 * 0.90

"sensors -s" has nothing to complain but I still get
sensord: Sensor alarm: Chip nct6776-isa-0290: SYSTIN: 25.0 C (limit =3D
0.0 C, hysteresis =3D 0.0 C) [ALARM]

I found this:
CPUTIN: 24.5 C (limit =3D 80.0 C, hysteresis =3D 75.0 C)
AUXTIN: 58.0 C (limit =3D 80.0 C, hysteresis =3D 75.0 C)

but could not find the configuration for CPUTIN AUXTIN !

Are Signals in UPPERCASE special ?


Best Regards

Lars

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
