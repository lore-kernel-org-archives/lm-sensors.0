From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 10 Sep 2010 16:15:27 +0000
Subject: Re: [lm-sensors] Lack of fan sensor output after Ubuntu upgrade
Message-Id: <20100910161527.GA20992@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <201009101529.26294.larsivar@igesund.net>
In-Reply-To: <201009101529.26294.larsivar@igesund.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Fri, Sep 10, 2010 at 09:29:25AM -0400, Lars Ivar Igesund wrote:
> Hi all,
>=20
> I admit to using beta software, and to the possibility that the issue is =
not in lm-sensors, but since I'm very interested in getting my issue fixed,=
 I think this list is the right place to start at least.
>=20
> I upgraded to Ubuntu 10.10 beta today, and the almost immediate result is=
 that the fan has become noisy as hell.
>=20
> I have a Dell XPS Studio 17 laptop, bought earlier this year. It has (amo=
ng other things) an i7 Q820 processor.
>=20
> I never ran sensors before the upgrade (didn't have any fan issues there)=
, so I don't know if there's any actual differences in the output, but here=
 goes.
>=20
The kernel should leave fans running on auto-configuration if a specific ch=
ip is
unsupported.

It may simply be that your new kernel _is_ running hotter. There was a disc=
ussion=20
about such an issue on the kernel mailing list a few weeks ago. The fix sho=
uld be
in the latest kernel. Maybe it isn't included in the Ubuntu 10.10 release y=
et.

> Just running sensors give me:
>=20
> acpitz-virtual-0
>=20
> Adapter: Virtual device
>=20
> temp1: +26.8=B0C (crit =3D +127.0=B0C)
>=20
> temp2: +61.0=B0C (crit =3D +85.0=B0C)
>=20
> Since I've little or no load on the CPU, I find the latter value unlikely=
 high (but it seems to be dropping now so I'll guess I will see how it evol=
ves). Anyway, I ran sensors-detect, and it found next to nothing apparently=
. I then downloaded the svn version, ran it, and it came to a different con=
clusion (doesn't Ubuntu beta 10.10 have a recent lm-sensors?):
>=20
> I could/should install the coretemp module, and so I did. Now sensors giv=
es me:
>=20
> acpitz-virtual-0
>=20
> Adapter: Virtual device
>=20
> temp1: +26.8=B0C (crit =3D +127.0=B0C)
>=20
> temp2: +57.0=B0C (crit =3D +85.0=B0C)
>=20
> coretemp-isa-0000
>=20
> Adapter: ISA adapter
>=20
> Core 0: +57.0=B0C (high =3D +84.0=B0C, crit =3D +100.0=B0C)
>=20
> coretemp-isa-0001
>=20
> Adapter: ISA adapter
>=20
> Core 1: +57.0=B0C (high =3D +84.0=B0C, crit =3D +100.0=B0C)
>=20
> coretemp-isa-0002
>=20
> Adapter: ISA adapter
>=20
> Core 2: +58.0=B0C (high =3D +84.0=B0C, crit =3D +100.0=B0C)
>=20
> coretemp-isa-0003
>=20
> Adapter: ISA adapter
>=20
> Core 3: +57.0=B0C (high =3D +84.0=B0C, crit =3D +100.0=B0C)
>=20
> No fan speeds though, and I'd expected such info from a laptop this expen=
sive. Looking at sensors-detect again, I have this:
>=20
I don't think laptop price has any correlation to chip support in the kerne=
l.=20
I'd be happy to add that support for the chip in your laptop if someone pro=
vides
me with a chip datasheet and donates a laptop.

> Probing for Super-I/O at 0x4e/0x4f
>=20
> Trying family `National Semiconductor'... Yes
>=20
> Found unknown chip with ID 0x8512
>=20
> Is this something of interest?
>=20
Most likely this is a Nuvoton chip; they use chip id 0x85 for another chip.
Don't recall seeing this specific ID, though, or why it is identified
as National Semiconductor.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
