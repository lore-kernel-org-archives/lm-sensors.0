From: Robert Kaiser <kairo@kairo.at>
Date: Thu, 10 Mar 2011 23:17:55 +0000
Subject: Re: [lm-sensors] RFC: nct6776f support in the w83627ehf and fan
Message-Id: <ilbm78$rp2$1@dough.gmane.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <BE6F61DB46364D4B839ED3F50CDFDFAB@portable2>
In-Reply-To: <BE6F61DB46364D4B839ED3F50CDFDFAB@portable2>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Guenter Roeck schrieb:
> this is what I configured for my board (Intel DH57JG). Some of it is gues=
sing,
> some of it is common practice with Winbond/Nuvoton chips.

I'll look into applying your settings and see how well they work, but=20
I'll first get the BIOS reading tomorrow as Ian suggested.


> Regarding the temperature sensor labels - those are straight from the chi=
p manual.

OK, so I have those:

SYSTIN:                +40.0=B0C  (high =3D  +0.0=B0C, hyst =3D  +0.0=B0C) =
 ALARM=20
  sensor =3D diode

I guess this means "System temperature", whatever that means in practice=20
as to where the sensor sits (I've never fully understood that one, even=20
on older systems where it often was called "MB temp" or so).

CPUTIN:                +39.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C) =
 sensor=20
=3D diode

That one is probably "CPU temperature" from a CPU sensor in the style as=20
it's existed for ages, even before the cores had their own additional=20
sensors.

SMBUSMASTER 1:         +55.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C) =
 sensor=20
=3D diode

Hmm, that seems to be an "SMBUS MASTER", wherever that one really sits=20
in practice (fun that it's hotter than the other two).

PCH_CHIP_CPU_MAX_TEMP: +65.0=B0C

Is that some allowed max temp of the CPU (i.e. where it shuts down) or=20
the highest seen temp of the CPU?

SMBUSMASTER 2:          +0.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)

Not sure what that is, given that it seems to be zero (and I'm sure=20
nothing in my system is at freezing temperature, even if we had that=20
outside a few times in the last week).

> PCH_MCH_TEMP
> PCH_DIMM0_TEMP
> PCH_DIMM1_TEMP
> PCH_DIMM2_TEMP
> PCH_DIMM3_TEMP

Now those would sound cool, but I guess it's not reporting them.

Robert Kaiser



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
