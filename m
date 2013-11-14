From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 14 Nov 2013 18:07:29 +0000
Subject: Re: [lm-sensors] NCT6106D: strange VIN max behaviour (nct6775)
Message-Id: <20131114180729.GA5858@roeck-us.net>
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
Hi Bjoern,

thanks a lot for the feedback.

> I'm about to test the new NCT6106D part of the Nuvoton nct6775 driver.
> However, I experience a strange behaviour concerning the maximum
> thresholds of in1 (wiring: +5V at chip's VIN0, 15/10 resistor ratio) and
> in4 (wiring: +12V at chip's VIN1, 110/22 ratio). The behaviour is as
> follows:
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
The register addresses encode both bank and address.
If you look into nct6775_read_value(), you'll see how the address
is split into <bank, offset>.

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

Weird. Unfortunately, I don't immediately see what may be wrong in the code.

Please provide the output of

sudo isadump 0x295 0x296 0
sudo isadump 0x295 0x296 1

after programming the limits.

This way we can see what is actually programmed into the chip.
It would also be helpful if you can also provide the output of "sensors"
as well as the output from above commands after booting, prior to
running "sensors -s". This way we'll be able to see the initial
chip programming by the BIOS.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
