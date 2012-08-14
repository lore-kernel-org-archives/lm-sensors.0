From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 14 Aug 2012 19:37:50 +0000
Subject: Re: [lm-sensors] Coretemp ERROR: Can't get value of subfeature temp1_input
Message-Id: <20120814193750.GA16985@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <AANLkTil33EQzUCcwbJT_VHMZKj1FPCwrTCkH28i3FcC5@mail.gmail.com>
In-Reply-To: <AANLkTil33EQzUCcwbJT_VHMZKj1FPCwrTCkH28i3FcC5@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Tue, Aug 14, 2012 at 07:12:53PM +0000, vadugs wrote:
> Jean Delvare <khali <at> linux-fr.org> writes:
>=20
> >=20
> >=20
> > It makes no sense to run sensors or any _hardware_ monitoring
> > application on a _virtual_ machine. Hardware monitoring should be done
> > on the host system, not on the guests.
> >=20
> > > (...)
> > > *3. The output of sensors: *
> > > coretemp-isa-0000
> > > Adapter: ISA adapter
> > > ERROR: Can't get value of subfeature temp1_input: Can't read
> > > Core 0:       +0.0=B0C  (high =3D +100.0=B0C, crit =3D +100.0=B0C)
> >=20
> > I presume that VMware simply doesn't allow guest drivers to access CPU
> > MSR. Nothing we can do.
> >=20
>=20
> Hey I am facing the same error. I just wanted to ask if there any other w=
ay to=20
> obtain temperature by running any hardware monitoring application on a vi=
rtual=20
> machine?
>=20
Only if the VM lets you do it.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
