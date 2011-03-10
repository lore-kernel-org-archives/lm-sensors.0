From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 10 Mar 2011 23:38:06 +0000
Subject: Re: [lm-sensors] RFC: nct6776f support in the w83627ehf and fan
Message-Id: <20110310233806.GD29827@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <BE6F61DB46364D4B839ED3F50CDFDFAB@portable2>
In-Reply-To: <BE6F61DB46364D4B839ED3F50CDFDFAB@portable2>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Thu, Mar 10, 2011 at 06:17:55PM -0500, Robert Kaiser wrote:
> Guenter Roeck schrieb:
> > this is what I configured for my board (Intel DH57JG). Some of it is gu=
essing,
> > some of it is common practice with Winbond/Nuvoton chips.
>=20
> I'll look into applying your settings and see how well they work, but=20
> I'll first get the BIOS reading tomorrow as Ian suggested.
>=20
>=20
> > Regarding the temperature sensor labels - those are straight from the c=
hip manual.
>=20
> OK, so I have those:
>=20
> SYSTIN:                +40.0=B0C  (high =3D  +0.0=B0C, hyst =3D  +0.0=B0C=
)  ALARM=20
>   sensor =3D diode
>=20
> I guess this means "System temperature", whatever that means in practice =

> as to where the sensor sits (I've never fully understood that one, even=20
> on older systems where it often was called "MB temp" or so).
>=20
> CPUTIN:                +39.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C=
)  sensor=20
> =3D diode
>=20
> That one is probably "CPU temperature" from a CPU sensor in the style as =

> it's existed for ages, even before the cores had their own additional=20
> sensors.
>=20
That really depends on the board, but, yes, pretty likely.

> SMBUSMASTER 1:         +55.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C=
)  sensor=20
> =3D diode
>=20
> Hmm, that seems to be an "SMBUS MASTER", wherever that one really sits=20
> in practice (fun that it's hotter than the other two).
>=20
> PCH_CHIP_CPU_MAX_TEMP: +65.0=B0C
>=20
> Is that some allowed max temp of the CPU (i.e. where it shuts down) or=20
> the highest seen temp of the CPU?
>=20
> SMBUSMASTER 2:          +0.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)
>=20
> Not sure what that is, given that it seems to be zero (and I'm sure=20
> nothing in my system is at freezing temperature, even if we had that=20
> outside a few times in the last week).
>=20
> > PCH_MCH_TEMP
> > PCH_DIMM0_TEMP
> > PCH_DIMM1_TEMP
> > PCH_DIMM2_TEMP
> > PCH_DIMM3_TEMP
>=20
> Now those would sound cool, but I guess it's not reporting them.
>=20
Agreed. But you might be able to see the DIMM temperatures (if you have DDR=
3)
by loading the "jc42" module.

Actually, I just had a look at the code again. Turns out there is a bug; yo=
u see
the labels associated with NCT6776F, not NCT6775F. Real values should be "P=
ECI Agent 0"
instead of "SMBUSMASTER 1", "PECI Agent 1" instead of "SMBUSMASTER 2",
and "PCH_CHIP_TEMP" instead of "PCH_CHIP_CPU_MAX_TEMP". I'll fix that immed=
iately.
So the temperatures you see as "SMBUSxxx" are really temperatures reported =
by the CPU.
Just don't ask me why the CPU would report 0 degrees C ;).

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
