From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 11 Apr 2007 11:59:04 +0000
Subject: Re: [lm-sensors] dynamic chip support in libsensors + generic chip
Message-Id: <20070411140020.1ca2734d@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <461A59D4.2050409@hhs.nl>
In-Reply-To: <461A59D4.2050409@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Bob

On Mon, 9 Apr 2007 20:31:11 +0200, Bob Schl=E4rmann wrote:
> On Mon, 09 Apr 2007 17:20:52 +0200
> Hans de Goede <j.w.r.degoede@hhs.nl> wrote:
>=20
> > So please test this:
> > 1) checkout the 3.0.0 branch:
> >     svn checkout
> > http://lm-sensors.org/svn/lm-sensors/branches/lm-sensors-3.0.0
> > 2) comment the entries for your chips int he table at the end of
> > lib/chips.c and in the table near the end of progs/sensors/main.c
>
> Note that this isn't needed if you give sensors the -g argument. This
> forces sensors to use the generic printing routines.

How does "sensors -g" differ from "sensors -u"? I thought we would be
reusing -u for the generic printing.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
