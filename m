From: Bob =?ISO-8859-1?Q?Schl=E4rmann?= <bob2@dsv.nl>
Date: Wed, 11 Apr 2007 19:02:44 +0000
Subject: Re: [lm-sensors] dynamic chip support in libsensors + generic chip
Message-Id: <20070411210244.13d00b45@ws01.atreidis.nl.eu.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <461A59D4.2050409@hhs.nl>
In-Reply-To: <461A59D4.2050409@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Wed, 11 Apr 2007 14:00:20 +0200
Jean Delvare <khali@linux-fr.org> wrote:

> Hi Bob
>=20
> On Mon, 9 Apr 2007 20:31:11 +0200, Bob Schl=E4rmann wrote:
> > On Mon, 09 Apr 2007 17:20:52 +0200
> > Hans de Goede <j.w.r.degoede@hhs.nl> wrote:
> >=20
> > > So please test this:
> > > 1) checkout the 3.0.0 branch:
> > >     svn checkout
> > > http://lm-sensors.org/svn/lm-sensors/branches/lm-sensors-3.0.0
> > > 2) comment the entries for your chips int he table at the end of
> > > lib/chips.c and in the table near the end of progs/sensors/main.c
> >
> > Note that this isn't needed if you give sensors the -g argument.
> > This forces sensors to use the generic printing routines.
>=20
> How does "sensors -g" differ from "sensors -u"? I thought we would be
> reusing -u for the generic printing.
>=20
The difference is that -u prints every feature, -g only prints feature
types it knows about. So when adding some new special feature type, the
generic printing routines won't show them (yet) but -u will.=20

Don't know whether it's worth it to support this extra switch, but I=20
wanted to change the behaviour of sensors as little as possible.

--
Bob Schl=E4rmann

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
