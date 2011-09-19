From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 19 Sep 2011 17:23:37 +0000
Subject: Re: [lm-sensors] [PATCHv4 1/1] Hwmon: Add core/pkg Threshold
Message-Id: <1316453017.4630.21.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1310468836-5517-1-git-send-email-durgadoss.r@intel.com>
In-Reply-To: <1310468836-5517-1-git-send-email-durgadoss.r@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Sun, 2011-09-18 at 13:24 -0400, Jean Delvare wrote:
> On Sat, 17 Sep 2011 11:09:43 -0700, Guenter Roeck wrote:
> > Hi Durga,
> >=20
> > On Sat, Sep 17, 2011 at 01:40:41PM -0400, R, Durgadoss wrote:
> > > Hi Guenter,
> > >=20
> > [ ... ]
> >=20
> > > > > For me, it looks like, we need not know whether the threshold is =
upper or
> > > > lower.
> > > > > Anyway, for every threshold, we will get two interrupts (for eith=
er
> > > > direction)
> > > > > So, the user space can assume either a lower threshold and look f=
or 0 in the
> > > > > Corresponding alarm interface Or a higher threshold and look for =
1 in the
> > > > > alarm interface. Will this not work ?
> > > > >
> > > > For a lower threshold, "alarm" implies "temperature is at or below =
threshold",
> > > > In other words, "alarm" can mean that a value is above or below a g=
iven
> > > > threshold -
> > > > it has a semantics that depends on its context.
> > > >=20
> > > > This context is not known in the case of a generic threshold. This =
is why I
> > > > suggested
> > > > to use a more neutral term, such as "triggered", which would imply =
"at or above
> > > > threshold" (or possibly just "threshold triggered" if the direction=
 is not
> > > > known)
> > > > without attaching a semantics to it.
> > > >=20
> > >=20
> > > Ok. I agree. We can use tempX_thresholdY_triggered.
> > >=20
> > I'd like to hear Jean's opinion first.
>=20
> I'm fine with your proposal, yes.
>=20
> > Also, if we introduce new attributes, we should probably reinstate the =
old "max".
>=20
> Definitely. And preferably the 2.6.39 variant rather than the 3.0
> variant, i.e. no magical -20=C2=B0C offset, unless someone can explain wh=
ere
> it comes from.
>=20
Sounds good.

Durga, do you have time to make those changes ?

Thanks,
GUenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
