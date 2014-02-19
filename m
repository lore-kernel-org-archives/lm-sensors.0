From: ianp <braveheart_leo@yahoo.com>
Date: Wed, 19 Feb 2014 03:18:40 +0000
Subject: Re: [lm-sensors] W83627DHG-P sensor shows a single voltage monitor for +5V and +12V on in4?
Message-Id: <1392779920.30720.YahooMailNeo@web160503.mail.bf1.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1392773023.4498.YahooMailNeo@web160503.mail.bf1.yahoo.com>
In-Reply-To: <1392773023.4498.YahooMailNeo@web160503.mail.bf1.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

> On Wednesday, February 19, 2014 10:55 AM, Guenter Roeck <linux@roeck-us.n=
et> wrote:

>=20
> Please don't drop the mailing liost from your replies.
>

Sorry about that.

> They don't. hwmonitor in Windows gives you the correct mapping for your=20
> board.
>=20
> =A0 =A0  Voltage 0=A0 =A0 1.11 Volts [0x8B] (CPU VCORE)
> =A0 =A0  Voltage 1=A0 =A0 0.69 Volts [0x56] (VIN1)
> =A0 =A0  Voltage 2=A0 =A0 3.30 Volts [0xCE] (+3.3V)
> =A0 =A0  Voltage 3=A0 =A0 4.97 Volts [0xCF] (+5V)
> =A0 =A0  Voltage 4=A0 =A0 11.54 Volts [0xCF] (+12V)
> =A0 =A0  Voltage 5=A0 =A0 1.69 Volts [0xD3] (VIN5)
> =A0 =A0  Voltage 6=A0 =A0 1.90 Volts [0xED] (VIN6)
>=20
> where Voltage X maps to inX.
>=20
>=20
> Guenter
>

I though about it too at first, that Voltage X corresponds to inX in lm-sen=
sors. The problem is, if you look at the default configuration lm-sensors p=
rovide at /etc/sensors3.conf:

chip "w83627ehf-*" "w83627dhg-*" "w83667hg-*" "nct6775-*" "nct6776-*"

=A0=A0=A0 label in0 "Vcore"
=A0=A0=A0 label in2 "AVCC"
=A0=A0=A0 label in3 "+3.3V"
=A0=A0=A0 label in7 "3VSB"
=A0=A0=A0 label in8 "Vbat"

=A0=A0=A0 set in2_min=A0 3.3 * 0.90
=A0=A0=A0 set in2_max=A0 3.3 * 1.10
=A0=A0=A0 set in3_min=A0 3.3 * 0.90
=A0=A0=A0 set in3_max=A0 3.3 * 1.10
=A0=A0=A0 set in7_min=A0 3.3 * 0.90
=A0=A0=A0 set in7_max=A0 3.3 * 1.10
=A0=A0=A0 set in8_min=A0 3.0 * 0.90
=A0=A0=A0 set in8_max=A0 3.0 * 1.10

You can see that in3 is "+3.3V". Of course I tried modifying in3 in my conf=
iguration as follows:

label in3 "+5V"
set in3_min 5 * 0.95
set in3_max 5 * 1.05
compute=A0 in4=A0 @*((20/10)+1), @/((20/10)+1)

And here's the result:

# sensors -s
# sensors
w83627dhg-isa-0290
Adapter: ISA adapter
Vcore:=A0=A0=A0=A0=A0=A0=A0 +1.11 V=A0 (min =3D=A0 +1.07 V, max =3D=A0 +1.1=
8 V)
AVcc:=A0=A0=A0=A0=A0=A0=A0=A0 +3.30 V=A0 (min =3D=A0 +2.98 V, max =3D=A0 +3=
.63 V)
+5V:=A0=A0=A0=A0=A0=A0=A0=A0=A0 +9.89 V=A0 (min =3D=A0 +2.98 V, max =3D=A0 =
+3.65 V)=A0 ALARM
+12V:=A0=A0=A0=A0=A0=A0=A0 +11.59 V=A0 (min =3D +11.42 V, max =3D +12.60 V)
Vram:=A0=A0=A0=A0=A0=A0=A0=A0 +1.90 V=A0 (min =3D=A0 +1.80 V, max =3D=A0 +1=
.90 V)
3Vsb:=A0=A0=A0=A0=A0=A0=A0=A0 +3.50 V=A0 (min =3D=A0 +2.98 V, max =3D=A0 +3=
.63 V)
Vbat:=A0=A0=A0=A0=A0=A0=A0=A0 +3.34 V=A0 (min =3D=A0 +2.70 V, max =3D=A0 +3=
.30 V)=A0 ALARM
CHA Fan:=A0=A0=A0=A0=A0=A0=A0 0 RPM=A0 (min =3D=A0=A0=A0 0 RPM, div =3D 128)
CPU Fan:=A0=A0=A0=A0 1854 RPM=A0 (min =3D=A0 902 RPM, div =3D 8)
PSU Fan:=A0=A0=A0=A0=A0=A0=A0 0 RPM=A0 (min =3D=A0=A0=A0 0 RPM, div =3D 128)
N/B Temp:=A0=A0=A0=A0 +42.0=B0C=A0 (high =3D +60.0=B0C, hyst =3D +55.0=B0C)=
=A0 sensor =3D thermistor
CPU Temp:=A0=A0=A0=A0 +38.5=B0C=A0 (high =3D +60.0=B0C, hyst =3D +55.0=B0C)=
=A0 sensor =3D thermistor

As you can see:

=A0=A0 +5V:=A0=A0=A0=A0=A0=A0=A0=A0=A0 +9.89 V=A0 (min =3D=A0 +2.98 V, max =
=3D=A0 +3.65 V)=A0 ALARM

doesn't look right, and even the min and max values does not reflect the on=
es I set. Moreover, it looks as though in3 is really "+3.3V" in lm-sensors.

But if I modify in4 in my configuration as follows:

##### in4 as +5V monitor

label in4 "+5V"
set in4_min 5 * 0.95
set in4_max 5 * 1.05
compute=A0 in4=A0 @*((20/10)+1), @/((20/10)+1)

# sensors -s
# sensors
w83627dhg-isa-0290
Adapter: ISA adapter
Vcore:=A0=A0=A0=A0=A0=A0=A0 +1.11 V=A0 (min =3D=A0 +1.07 V, max =3D=A0 +1.1=
8 V)
AVcc:=A0=A0=A0=A0=A0=A0=A0=A0 +3.30 V=A0 (min =3D=A0 +2.98 V, max =3D=A0 +3=
.63 V)
+3.3V:=A0=A0=A0=A0=A0=A0=A0 +3.30 V=A0 (min =3D=A0 +2.98 V, max =3D=A0 +3.6=
3 V)
+5V:=A0=A0=A0=A0=A0=A0=A0=A0=A0 +4.97 V=A0 (min =3D=A0 +4.75 V, max =3D=A0 =
+5.26 V)
Vram:=A0=A0=A0=A0=A0=A0=A0=A0 +1.90 V=A0 (min =3D=A0 +1.80 V, max =3D=A0 +1=
.90 V)
3Vsb:=A0=A0=A0=A0=A0=A0=A0=A0 +3.50 V=A0 (min =3D=A0 +2.98 V, max =3D=A0 +3=
.63 V)
Vbat:=A0=A0=A0=A0=A0=A0=A0=A0 +3.33 V=A0 (min =3D=A0 +2.70 V, max =3D=A0 +3=
.30 V)=A0 ALARM
CHA Fan:=A0=A0=A0=A0=A0=A0=A0 0 RPM=A0 (min =3D=A0=A0=A0 0 RPM, div =3D 128)
CPU Fan:=A0=A0=A0=A0 1654 RPM=A0 (min =3D=A0 902 RPM, div =3D 8)
PSU Fan:=A0=A0=A0=A0=A0=A0=A0 0 RPM=A0 (min =3D=A0=A0=A0 0 RPM, div =3D 128)
N/B Temp:=A0=A0=A0=A0 +41.0=B0C=A0 (high =3D +60.0=B0C, hyst =3D +55.0=B0C)=
=A0 sensor =3D thermistor
CPU Temp:=A0=A0=A0=A0 +37.5=B0C=A0 (high =3D +60.0=B0C, hyst =3D +55.0=B0C)=
=A0 sensor =3D thermistor
intrusion0:=A0 ALARM

##### in4 as +12V monitor

label in4 "+12V"
set in4_min 12 * 0.95
set in4_max 12 * 1.05
compute=A0 in4=A0 @*((60/10)+1), @/((60/10)+1)

# sensors -s
# sensors
w83627dhg-isa-0290
Adapter: ISA adapter
Vcore:=A0=A0=A0=A0=A0=A0=A0 +1.11 V=A0 (min =3D=A0 +1.07 V, max =3D=A0 +1.1=
8 V)
AVcc:=A0=A0=A0=A0=A0=A0=A0=A0 +3.30 V=A0 (min =3D=A0 +2.98 V, max =3D=A0 +3=
.63 V)
+3.3V:=A0=A0=A0=A0=A0=A0=A0 +3.30 V=A0 (min =3D=A0 +2.98 V, max =3D=A0 +3.6=
3 V)
+12V:=A0=A0=A0=A0=A0=A0=A0 +11.59 V=A0 (min =3D +11.42 V, max =3D +12.60 V)
Vram:=A0=A0=A0=A0=A0=A0=A0=A0 +1.90 V=A0 (min =3D=A0 +1.80 V, max =3D=A0 +1=
.90 V)
3Vsb:=A0=A0=A0=A0=A0=A0=A0=A0 +3.50 V=A0 (min =3D=A0 +2.98 V, max =3D=A0 +3=
.63 V)
Vbat:=A0=A0=A0=A0=A0=A0=A0=A0 +3.34 V=A0 (min =3D=A0 +2.70 V, max =3D=A0 +3=
.30 V)=A0 ALARM
CHA Fan:=A0=A0=A0=A0=A0=A0=A0 0 RPM=A0 (min =3D=A0=A0=A0 0 RPM, div =3D 128)
CPU Fan:=A0=A0=A0=A0 1854 RPM=A0 (min =3D=A0 902 RPM, div =3D 8)
PSU Fan:=A0=A0=A0=A0=A0=A0=A0 0 RPM=A0 (min =3D=A0=A0=A0 0 RPM, div =3D 128)
N/B Temp:=A0=A0=A0=A0 +42.0=B0C=A0 (high =3D +60.0=B0C, hyst =3D +55.0=B0C)=
=A0 sensor =3D thermistor
CPU Temp:=A0=A0=A0=A0 +38.5=B0C=A0 (high =3D +60.0=B0C, hyst =3D +55.0=B0C)=
=A0 sensor =3D thermistor
intrusion0:=A0 ALARM

As you can see from above, I was able to successfully modify in4, and set m=
in and max values for both +5V and +12V and showing the values as expected.

So what is the reason for this behavior?


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
