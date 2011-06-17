From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 17 Jun 2011 08:09:22 +0000
Subject: Re: [lm-sensors] Possible to set low temperature limit?
Message-Id: <20110617100922.4b5e8caa@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <e1klv65nq0br7o0p7eic89047t49qjtedr@4ax.com>
In-Reply-To: <e1klv65nq0br7o0p7eic89047t49qjtedr@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Thu, 16 Jun 2011 20:56:39 -0700, singumal wrote:
> My sensors output is like this:
>=20
> f81865f-isa-0a00
> ...
> System Temperature:  +35.0=B0C  (high =3D +85.0=B0C, hyst =3D +81.0=B0C)
>                               (crit =3D +100.0=B0C, hyst =3D +96.0=B0C)  =
sensor =3D transistor
>=20
> Is there any way to be able to get an ALARM if a sensor
> transistor isn't installed?  With no transistor it tends to show
> low or negative temperatures.  (Actually on a different
> motherboard/sensor).  I suspect the answer is "no, there's no
> hardware limit for low temperature to cause an ALARM", just want
> to confirm that I'd have to do this check myself.

Some chips implement low temperature limits, some do not. Some chips
implement fault reporting on missing/broken thermal sensor, some don't.
The F81865F for example has the latter but not the former. So the
behavior is completely chip-specific.

Also note that not all low or negative temperature values hint at a
broken or unused sensor. In general each chip has its own negative
temperature value to indicate a missing measurement. -55, -127 and -128
are frequent values for this case, but some chips don't return a
constant value, so you can't rely on it in the general case.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
