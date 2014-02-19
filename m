From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 19 Feb 2014 04:11:40 +0000
Subject: Re: [lm-sensors] W83627DHG-P sensor shows a single voltage monitor for +5V and +12V on in4?
Message-Id: <53042EFC.6090602@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1392773023.4498.YahooMailNeo@web160503.mail.bf1.yahoo.com>
In-Reply-To: <1392773023.4498.YahooMailNeo@web160503.mail.bf1.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On 02/18/2014 07:18 PM, ianp wrote:
>> On Wednesday, February 19, 2014 10:55 AM, Guenter Roeck <linux@roeck-us.=
net> wrote:
>
>>
>> Please don't drop the mailing liost from your replies.
>>
>
> Sorry about that.
>
>> They don't. hwmonitor in Windows gives you the correct mapping for your
>> board.
>>
>>       Voltage 0    1.11 Volts [0x8B] (CPU VCORE)
>>       Voltage 1    0.69 Volts [0x56] (VIN1)
>>       Voltage 2    3.30 Volts [0xCE] (+3.3V)
>>       Voltage 3    4.97 Volts [0xCF] (+5V)
>>       Voltage 4    11.54 Volts [0xCF] (+12V)
>>       Voltage 5    1.69 Volts [0xD3] (VIN5)
>>       Voltage 6    1.90 Volts [0xED] (VIN6)
>>
>> where Voltage X maps to inX.
>>
>>
>> Guenter
>>
>
> I though about it too at first, that Voltage X corresponds to inX in lm-s=
ensors. The problem is, if you look at the default configuration lm-sensors=
 provide at /etc/sensors3.conf:
>
> chip "w83627ehf-*" "w83627dhg-*" "w83667hg-*" "nct6775-*" "nct6776-*"
>
>      label in0 "Vcore"
>      label in2 "AVCC"
>      label in3 "+3.3V"
>      label in7 "3VSB"
>      label in8 "Vbat"
>
>      set in2_min  3.3 * 0.90
>      set in2_max  3.3 * 1.10
>      set in3_min  3.3 * 0.90
>      set in3_max  3.3 * 1.10
>      set in7_min  3.3 * 0.90
>      set in7_max  3.3 * 1.10
>      set in8_min  3.0 * 0.90
>      set in8_max  3.0 * 1.10
>
> You can see that in3 is "+3.3V". Of course I tried modifying in3 in my co=
nfiguration as follows:
>
That is just a generic description for settings which are
often seen for those SuperIO chips. That doesn't mean they
apply in any way to your board.

> label in3 "+5V"
> set in3_min 5 * 0.95
> set in3_max 5 * 1.05
> compute  in4  @*((20/10)+1), @/((20/10)+1)
>

You'll need the correct compute statement for in3.
You are labeling in3 as 5V and then provide a compute
statement for in4.

Where is the compute statement for in3 ?

> And here's the result:
>
> # sensors -s
> # sensors
> w83627dhg-isa-0290
> Adapter: ISA adapter
> Vcore:        +1.11 V  (min =3D  +1.07 V, max =3D  +1.18 V)
> AVcc:         +3.30 V  (min =3D  +2.98 V, max =3D  +3.63 V)
> +5V:          +9.89 V  (min =3D  +2.98 V, max =3D  +3.65 V)  ALARM
> +12V:        +11.59 V  (min =3D +11.42 V, max =3D +12.60 V)
> Vram:         +1.90 V  (min =3D  +1.80 V, max =3D  +1.90 V)
> 3Vsb:         +3.50 V  (min =3D  +2.98 V, max =3D  +3.63 V)
> Vbat:         +3.34 V  (min =3D  +2.70 V, max =3D  +3.30 V)  ALARM
> CHA Fan:        0 RPM  (min =3D    0 RPM, div =3D 128)
> CPU Fan:     1854 RPM  (min =3D  902 RPM, div =3D 8)
> PSU Fan:        0 RPM  (min =3D    0 RPM, div =3D 128)
> N/B Temp:     +42.0=B0C  (high =3D +60.0=B0C, hyst =3D +55.0=B0C)  sensor=
 =3D thermistor
> CPU Temp:     +38.5=B0C  (high =3D +60.0=B0C, hyst =3D +55.0=B0C)  sensor=
 =3D thermistor
>
> As you can see:
>
>     +5V:          +9.89 V  (min =3D  +2.98 V, max =3D  +3.65 V)  ALARM
>
> doesn't look right, and even the min and max values does not reflect the =
ones I set. Moreover, it looks as though in3 is really "+3.3V" in lm-sensor=
s.
>
> But if I modify in4 in my configuration as follows:
>
> ##### in4 as +5V monitor
>
> label in4 "+5V"
> set in4_min 5 * 0.95
> set in4_max 5 * 1.05
> compute  in4  @*((20/10)+1), @/((20/10)+1)
>
> # sensors -s
> # sensors
> w83627dhg-isa-0290
> Adapter: ISA adapter
> Vcore:        +1.11 V  (min =3D  +1.07 V, max =3D  +1.18 V)
> AVcc:         +3.30 V  (min =3D  +2.98 V, max =3D  +3.63 V)
> +3.3V:        +3.30 V  (min =3D  +2.98 V, max =3D  +3.63 V)
> +5V:          +4.97 V  (min =3D  +4.75 V, max =3D  +5.26 V)
> Vram:         +1.90 V  (min =3D  +1.80 V, max =3D  +1.90 V)
> 3Vsb:         +3.50 V  (min =3D  +2.98 V, max =3D  +3.63 V)
> Vbat:         +3.33 V  (min =3D  +2.70 V, max =3D  +3.30 V)  ALARM
> CHA Fan:        0 RPM  (min =3D    0 RPM, div =3D 128)
> CPU Fan:     1654 RPM  (min =3D  902 RPM, div =3D 8)
> PSU Fan:        0 RPM  (min =3D    0 RPM, div =3D 128)
> N/B Temp:     +41.0=B0C  (high =3D +60.0=B0C, hyst =3D +55.0=B0C)  sensor=
 =3D thermistor
> CPU Temp:     +37.5=B0C  (high =3D +60.0=B0C, hyst =3D +55.0=B0C)  sensor=
 =3D thermistor
> intrusion0:  ALARM
>
> ##### in4 as +12V monitor
>
> label in4 "+12V"
> set in4_min 12 * 0.95
> set in4_max 12 * 1.05
> compute  in4  @*((60/10)+1), @/((60/10)+1)
>
> # sensors -s
> # sensors
> w83627dhg-isa-0290
> Adapter: ISA adapter
> Vcore:        +1.11 V  (min =3D  +1.07 V, max =3D  +1.18 V)
> AVcc:         +3.30 V  (min =3D  +2.98 V, max =3D  +3.63 V)
> +3.3V:        +3.30 V  (min =3D  +2.98 V, max =3D  +3.63 V)
> +12V:        +11.59 V  (min =3D +11.42 V, max =3D +12.60 V)
> Vram:         +1.90 V  (min =3D  +1.80 V, max =3D  +1.90 V)
> 3Vsb:         +3.50 V  (min =3D  +2.98 V, max =3D  +3.63 V)
> Vbat:         +3.34 V  (min =3D  +2.70 V, max =3D  +3.30 V)  ALARM
> CHA Fan:        0 RPM  (min =3D    0 RPM, div =3D 128)
> CPU Fan:     1854 RPM  (min =3D  902 RPM, div =3D 8)
> PSU Fan:        0 RPM  (min =3D    0 RPM, div =3D 128)
> N/B Temp:     +42.0=B0C  (high =3D +60.0=B0C, hyst =3D +55.0=B0C)  sensor=
 =3D thermistor
> CPU Temp:     +38.5=B0C  (high =3D +60.0=B0C, hyst =3D +55.0=B0C)  sensor=
 =3D thermistor
> intrusion0:  ALARM
>
> As you can see from above, I was able to successfully modify in4, and set=
 min and max values for both +5V and +12V and showing the values as expecte=
d.
>
> So what is the reason for this behavior?
>
PDL, or Pure Damned Luck. You are using the fact that both in3 and in4
happen to report the same physical value to your favor. That doesn't
make it correct.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
