From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 14 Nov 2013 18:58:37 +0000
Subject: Re: [lm-sensors] NCT6106D: strange VIN max behaviour (nct6775)
Message-Id: <20131114185837.GD13727@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <250339793.65111.1384443406161.open-xchange@app04.ox.hosteurope.de>
In-Reply-To: <250339793.65111.1384443406161.open-xchange@app04.ox.hosteurope.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Thu, Nov 14, 2013 at 04:36:46PM +0100, Bj=F6rn Gerhart wrote:
> Hi,
>=20
> I'm about to test the new NCT6106D part of the Nuvoton nct6775 driver.
> However, I experience a strange behaviour concerning the maximum
> thresholds of in1 (wiring: +5V at chip's VIN0, 15/10 resistor ratio) and
> in4 (wiring: +12V at chip's VIN1, 110/22 ratio). The behaviour is as
> follows:

Those scaling factors don't really work. VIN0 and VIN1 have a maximum
input range of 2.048V. With your scaling factors you don't really get
to the limits you are trying to set. Maximum for 5V is 2.048 * 2.5 =3D 5.12=
V,
and maximum for 12V is 2.048*6 =3D 12.228V. So, in practice, what you see
is that the ADCs for both inputs are maxed out, which also explains
why you can not set the maximum higher than the actual voltage.

If this is a third-party board, you may be out of luck. If this is your
own board, you might want to select different resistor ratios.
Something like 20/10 and 150/22 should work better, for example.

Hope this helps,
Guenter

> - the current value always looks good
> - the minimum threshold value always looks good
> - the maximum threshold value _only_ looks good, when it is configured
> _lower_ than the current value (which doesn't make any sense anyway, but
> I checked it just for error analysis)
> - but once the maximum threshold value is configured higher than the
> current value (which it normally is), then the read maximum value is
> exactly the same as the current value
>=20
> Please see at the end of this mail for the sensors command output and
> the related sensors.conf.
>=20
> When I analysed the nct6775.c source code, I noticed that the voltage
> registers are programmed as "u16" registers. In the NCT6102D/NCT6106D
> spec (see [1], page 111 and following), the tables say that the
> registers are 8bit only. May this be the reason for the strange
> behaviour? Or is it a bad typo Nuvoton made in the spec?
>=20
> However, the register _adresses_ in the source code for the current
> value and the min and max thresholds seem to apply with the ones
> specified in the spec.
>=20
> Bj=F6rn
>=20
> [1]
> https://download.nuvoton.com/NuvotonMOSS/DownloadService/Member/Documents=
Info.aspx?tp_GUID=3DDA00-NCT6106D
>=20
> My sensors output:
> [root@allinone-wnlpos ~]# LANG=3DC sensors
> nct6106-isa-0290
> Adapter: ISA adapter
> CPUVCORE:=A0 =A0 +1.74 V=A0 (min =3D=A0 +1.00 V, max =3D=A0 +2.00 V)
> +5V:=A0 =A0 =A0 =A0 =A0+5.10 V=A0 (min =3D=A0 +4.50 V, max =3D=A0 +5.10 V=
)=A0 =A0ALARM
> +12V:=A0 =A0 =A0 =A0+12.24 V=A0 (min =3D +10.70 V, max =3D +12.24 V)=A0 =
=A0ALARM
> VBat:=A0 =A0 =A0 =A0 +3.17 V=A0 (min =3D=A0 +3.01 V, max =3D=A0 +4.00 V)
> CPU:=A0 =A0 =A0 =A0 2830 RPM=A0 (min =3D=A0 300 RPM)
> SYSTEM:=A0 =A0 =A0 +32.0 C=A0 (high =3D +100.0 C, hyst =3D +75.0 C)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (crit =3D +127.0 C)=A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 sensor =3D
> thermal diode
> PCH:=A0 =A0 =A0 =A0 =A0+43.0 C=A0 (high =3D +80.0 C, hyst =3D +75.0 C)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (crit =3D +127.0 C)=A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 sensor =3D
> thermal diode
> CPU:=A0 =A0 =A0 =A0 =A0+37.0 C=A0 (high =3D +80.0 C, hyst =3D +75.0 C)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (crit =3D +127.0 C)
>=20
>=20
> My file /etc/sensors3.conf:
> --------%<-------- snip
> chip "nct6106-isa-0290"
>=20
> #=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> # Voltage inputs
> #=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>=20
> =A0 =A0 # CPUVCORE
> =A0 =A0 label in0 "CPUVCORE"
> =A0 =A0 compute in0=A0 @, @
> =A0 =A0 set in0_min=A0 1
> =A0 =A0 set in0_max=A0 2
>=20
> =A0 =A0 # +5V (ok) (chip: VIN0)
> =A0 =A0 label in1 "+5V"
> =A0 =A0 compute in1 ((15/10) +1)*@, @/((15/10) +1)
> =A0 =A0 set in1_min=A0 4.5
> =A0 =A0 set in1_max=A0 5.5
>=20
> =A0 =A0 # +12V (ok) (chip: VIN1)
> =A0 =A0 label in4 "+12V"
> =A0 =A0 compute in4 ((110/22) +1)*@, @/((110/22) +1)
> =A0 =A0 set in4_min=A0 10.7
> =A0 =A0 set in4_max=A0 13.7
>=20
> =A0 =A0 # VBat
> =A0 =A0 label in7 "VBat"
> =A0 =A0 set in7_min=A0 3.0
> =A0 =A0 set in7_max=A0 4.0
>=20
> =A0 =A0 ignore=A0 in2
> =A0 =A0 ignore=A0 in3
> =A0 =A0 ignore=A0 in5
> =A0 =A0 ignore=A0 in6
> =A0 =A0 ignore=A0 in8
> #=A0 =A0 ignore=A0 vid
>=20
>=20
>=20
> #=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> # Temperature inputs
> #=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> =A0 =A0 label temp1 "SYSTEM"
> =A0 =A0 set temp1_max 100
> =A0 =A0 set temp1_max_hyst 75
>=20
> =A0 =A0 label temp3 "PCH"
>=20
> =A0 =A0 label temp7 "CPU"
>=20
> =A0 =A0 ignore temp8
> =A0 =A0 ignore temp9
> =A0 =A0 ignore temp10
>=20
> =A0 =A0 ignore beep_enable
>=20
>=20
> #=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> # Fan inputs
> #=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> =A0 =A0 # CPU Fan
> =A0 =A0 label fan2 "CPU"
> =A0 =A0 set fan2_min=A0 300
>=20
> =A0 =A0 ignore fan1
> =A0 =A0 ignore fan3
> -------->%-------- snap
>=20

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
