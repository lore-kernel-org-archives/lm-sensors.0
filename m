From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 18 Sep 2011 17:24:29 +0000
Subject: Re: [lm-sensors] [PATCHv4 1/1] Hwmon: Add core/pkg Threshold
Message-Id: <20110918192429.106506a9@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1310468836-5517-1-git-send-email-durgadoss.r@intel.com>
In-Reply-To: <1310468836-5517-1-git-send-email-durgadoss.r@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Sat, 17 Sep 2011 11:09:43 -0700, Guenter Roeck wrote:
> Hi Durga,
>=20
> On Sat, Sep 17, 2011 at 01:40:41PM -0400, R, Durgadoss wrote:
> > Hi Guenter,
> >=20
> [ ... ]
>=20
> > > > For me, it looks like, we need not know whether the threshold is up=
per or
> > > lower.
> > > > Anyway, for every threshold, we will get two interrupts (for either
> > > direction)
> > > > So, the user space can assume either a lower threshold and look for=
 0 in the
> > > > Corresponding alarm interface Or a higher threshold and look for 1 =
in the
> > > > alarm interface. Will this not work ?
> > > >
> > > For a lower threshold, "alarm" implies "temperature is at or below th=
reshold",
> > > In other words, "alarm" can mean that a value is above or below a giv=
en
> > > threshold -
> > > it has a semantics that depends on its context.
> > >=20
> > > This context is not known in the case of a generic threshold. This is=
 why I
> > > suggested
> > > to use a more neutral term, such as "triggered", which would imply "a=
t or above
> > > threshold" (or possibly just "threshold triggered" if the direction i=
s not
> > > known)
> > > without attaching a semantics to it.
> > >=20
> >=20
> > Ok. I agree. We can use tempX_thresholdY_triggered.
> >=20
> I'd like to hear Jean's opinion first.

I'm fine with your proposal, yes.

> Also, if we introduce new attributes, we should probably reinstate the ol=
d "max".

Definitely. And preferably the 2.6.39 variant rather than the 3.0
variant, i.e. no magical -20=B0C offset, unless someone can explain where
it comes from.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
