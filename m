From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 08 Sep 2012 21:02:49 +0000
Subject: Re: [lm-sensors] Strange temperature of AMD FX4100 cpu and power consumption
Message-Id: <20120908230249.665c130c@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <504B7388.8020102@01019freenet.de>
In-Reply-To: <504B7388.8020102@01019freenet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Sat, 08 Sep 2012 21:15:21 +0200, Andreas Hartmann wrote:
> Clemens Ladisch wrote:
> > Guenter Roeck wrote:
> >> On Sat, Sep 08, 2012 at 06:34:16PM +0200, Andreas Hartmann wrote:
> >>> I'm getting this temperature after more than one hour of activity
> >>> (mostly idle, load of the machine is: 0,11, 0,17, 0,21):
> >>>
> >>> temp1:        +14.5=B0C  (high =3D +70.0=B0C)
> >>>
> >>> 14.5=B0C is completely impossible as the surrounding temperature is
> >>>> 20=B0C.
> >=20
> > Documentation/hwmon/k10temp says:
> > | There is one temperature measurement value, available as temp1_input =
in
> > | sysfs. It is measured in degrees Celsius with a resolution of 1/8th d=
egree.
> > | Please note that it is defined as a relative value; to quote the AMD =
manual:
> > |
> > |   Tctl is the processor temperature control value, used by the platfo=
rm to
> > |   control cooling systems. Tctl is a non-physical temperature on an
> > |   arbitrary scale measured in degrees. It does _not_ represent an act=
ual
> > |   physical temperature like die or case temperature. Instead, it spec=
ifies
> > |   the processor temperature relative to the point at which the system=
 must
> > |   supply the maximum cooling for the processor's specified maximum ca=
se
> > |   temperature and maximum thermal power dissipation.
>=20
> I already read this, too.
>=20
> My point of view is: If sensors says: "temp1: +14.5=B0C (high: +70=B0C)"
> then it is a temperature of +14.5=B0C and nothing else. If this value
> isn't a physical temperature (like the room temperature e.g.), why is it
> called temperature if it isn't one?

Because the maintainers of that code (and I mean the driver, the whole
subsystem, the user-space library and many user-space applications)
have a limited time to devote to ill-designed hardware. You think you
can do better? Join the development team, design the interface, write
the code.

> However, if it is an instrument to manage a fan (or maybe a complete
> cooling system), I most probably would use a percentaged value, which
> reveals something about the actual required cooling capacity for the
> individual system.
> At least it would avoid misunderstanding IMHO.

The text Clemens quoted and you claim you have read, is supposed to
avoid misunderstanding. Sure, the current situation is not perfect, but
the alternative currently is between that and nothing. Most users have
told us they prefer that to nothing. If you don't agree, just don't
user the driver. If anyone wants to add support for relative, arbitrary
unit temperature sensors to the whole monitoring stack, they are
welcome to contribute the code.

Good night,
--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
