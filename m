From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 02 Feb 2011 07:47:16 +0000
Subject: Re: [lm-sensors] How to distinguish sensors on Xeon multi-socket
Message-Id: <20110202084716.7ea8ec2e@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <201102012323.13215.4ernov@gmail.com>
In-Reply-To: <201102012323.13215.4ernov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Tue, 1 Feb 2011 17:23:04 -0800, Guenter Roeck wrote:
> On Tue, Feb 01, 2011 at 03:23:13PM -0500, Alexey Chernov wrote:
> > Hello,
> >=20
> > I have two socket motherboard with two Xeon's 5345 installed on them, s=
o=20
> > overall it's 8 cores. Using lm_sensors all of them are detected correct=
ly out=20
> > of the box, but the problem is that after certain Linux kernel upgrade =
(I=20
> > believe it's somewhere around 2.6.32) matching kernel on both processor=
s=20
> > started to be called identically. I have two 'Core 0', two 'Core 1' etc=
. and=20
> > it drives mad many applications which use lm_sensors. Here's the output=
 of=20

These are badly written applications, which need to be fixed
regardless of what the coretemp did, does, or will do. Label uniqueness
across multiple sensor devices isn't and has never been guaranteed. We
only guarantee uniqueness of symbols within each given chip.
Application which needs unique keys must use the combination of the
chip name + the symbol name; definitely not the label.

> > 'sensors' command:
> > sensors
> > radeon-pci-0700
> > Adapter: PCI adapter
> > temp1:       +77.0=B0C                             =20
> >=20
> > coretemp-isa-0000
> > Adapter: ISA adapter
> > Core 0:      +70.0=B0C  (high =3D +86.0=B0C, crit =3D +100.0=B0C) =20
> >=20
> > coretemp-isa-0001
> > Adapter: ISA adapter
> > Core 2:      +63.0=B0C  (high =3D +86.0=B0C, crit =3D +100.0=B0C) =20
> >=20
> > coretemp-isa-0002
> > Adapter: ISA adapter
> > Core 0:      +69.0=B0C  (high =3D +86.0=B0C, crit =3D +100.0=B0C) =20
> >=20
> > coretemp-isa-0003
> > Adapter: ISA adapter
> > Core 2:      +69.0=B0C  (high =3D +86.0=B0C, crit =3D +100.0=B0C) =20
> >=20
> > coretemp-isa-0004
> > Adapter: ISA adapter
> > Core 1:      +68.0=B0C  (high =3D +86.0=B0C, crit =3D +100.0=B0C) =20
> >=20
> > coretemp-isa-0005
> > Adapter: ISA adapter
> > Core 3:      +65.0=B0C  (high =3D +86.0=B0C, crit =3D +100.0=B0C) =20
> >=20
> > coretemp-isa-0006
> > Adapter: ISA adapter
> > Core 1:      +68.0=B0C  (high =3D +86.0=B0C, crit =3D +100.0=B0C) =20
> >=20
> > coretemp-isa-0007
> > Adapter: ISA adapter
> > Core 3:      +67.0=B0C  (high =3D +86.0=B0C, crit =3D +100.0=B0C)
> >=20
> > I try to fix the KDE sensors applet as it shows only 4 cores and ignore=
s=20
> > remaining ones due to name collision. But I really don't know how to=20
> > distinguish the certain cores of the processors. Could you please give =
me a=20
> > reference how can I tell, for instance one 'Core 0' from another? The i=
deal=20
> > case is if they can be addressed as 'Processor 1/Core 0' but I can't fi=
nd the=20
> > right way.
>
> No idea.

Currently, you can't.

> I added the driver maintainer to this e-mail; maybe your problem helps to=
 explain=20
> why Jean and I believe that the driver should instantiate itself per CPU,=
 not per core.

Yes, definitely. The above output should really look like:

coretemp-isa-0000
Adapter: ISA adapter
Core 0:      +70.0=B0C  (high =3D +86.0=B0C, crit =3D +100.0=B0C) =20
Core 1:      +68.0=B0C  (high =3D +86.0=B0C, crit =3D +100.0=B0C) =20
Core 2:      +63.0=B0C  (high =3D +86.0=B0C, crit =3D +100.0=B0C) =20
Core 3:      +65.0=B0C  (high =3D +86.0=B0C, crit =3D +100.0=B0C) =20

coretemp-isa-0001
Adapter: ISA adapter
Core 0:      +69.0=B0C  (high =3D +86.0=B0C, crit =3D +100.0=B0C) =20
Core 1:      +68.0=B0C  (high =3D +86.0=B0C, crit =3D +100.0=B0C) =20
Core 2:      +69.0=B0C  (high =3D +86.0=B0C, crit =3D +100.0=B0C) =20
Core 3:      +67.0=B0C  (high =3D +86.0=B0C, crit =3D +100.0=B0C)

where 0000 and 0001 would be the CPU numbers. This would be much easier
for users to figure out what they're seeing. We're waiting for the
coretemp driver maintainer to implement this.

In the meantime, a workaround would be to align the hwmon device
numbers with the CPU number, so that the user can at least look-up
in /proc/cpuinfo to find out who is who. But there is no guarantee for
the CPU enumeration order to stay the same across reboots, so the
interest would be limited in practice.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
