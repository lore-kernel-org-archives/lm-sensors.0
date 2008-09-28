From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 28 Sep 2008 21:40:51 +0000
Subject: Re: [lm-sensors] Does this makes any sense?
Message-Id: <20080928234051.66583cf7@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4p40uijp.fsf@telefonica.net>
In-Reply-To: <4p40uijp.fsf@telefonica.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Sun, 28 Sep 2008 22:22:50 +0200, =D3scar Fuentes wrote:
> This is not a problem with lm-sensors, but an attempt to understand
> what can cause the values it outputs.
>=20
> When I start four mprime processes in "torture test" mode on a Q6600
> system it shows a flat 100% CPU usage line and `sensors` report
> temperatures around or below 70 degrees Celsius for each core, which
> is consistent with Intel's specs for a fully loaded CPU:
>=20
> oscar@qcore:~/Archivo/prime$ sensors
> coretemp-isa-0000
> Adapter: ISA adapter
> Core 0:      +73.0=B0C  (crit =3D +100.0=B0C)
>=20
> coretemp-isa-0001
> Adapter: ISA adapter
> Core 1:      +71.0=B0C  (crit =3D +100.0=B0C)
>=20
> coretemp-isa-0002
> Adapter: ISA adapter
> Core 2:      +62.0=B0C  (crit =3D +100.0=B0C)
>=20
> coretemp-isa-0003
> Adapter: ISA adapter
> Core 3:      +58.0=B0C  (crit =3D +100.0=B0C)
>=20
> However, when compiling an application with "make -j 4" the CPU usage
> is around 95% (which is expected as there is quite a bit of I/O
> involved) but the temperature goes up to 88 degrees on some cores!
> This is a typical output of `sensors` on this scenario:
>=20
> coretemp-isa-0000                  =20
> Adapter: ISA adapter               =20
> Core 0:      +85.0=B0C  (crit =3D +100.0=B0C)
>=20
> coretemp-isa-0001
> Adapter: ISA adapter
> Core 1:      +82.0=B0C  (crit =3D +100.0=B0C)
>=20
> coretemp-isa-0002
> Adapter: ISA adapter
> Core 2:      +71.0=B0C  (crit =3D +100.0=B0C)
>=20
> coretemp-isa-0003
> Adapter: ISA adapter
> Core 3:      +65.0=B0C  (crit =3D +100.0=B0C)
>=20
> What can cause this difference on temperatures, when mprime stresses
> the CPU much more than the compiler?

FWIW: you shouldn't assume that "make -j4" on the kernel will spawn 4
jobs. Having used distcc to build the kernel for some time, I noticed
that make frequently spawns less jobs than I ask for. This only ever
happened to me for kernel builds, but I couldn't explain why it was
happening. Maybe that's why the last 2 cores have a lower temperature.
Try with -j 8 or higher and see if this is still the case.

On why mprime has a lower "mark" than gcc: I can only imagine that the
bottleneck in the mprime case is on something which is "far" from the
thermal sensor, while it is on something which is next the thermal
sensor in the gcc case. CPUs are pretty large and temperature
differences inside the CPU can be significant.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
