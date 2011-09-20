From: "R, Durgadoss" <durgadoss.r@intel.com>
Date: Tue, 20 Sep 2011 03:39:56 +0000
Subject: Re: [lm-sensors] [PATCHv4 1/1] Hwmon: Add core/pkg Threshold
Message-Id: <D6D887BA8C9DFF48B5233887EF04654109ECD3AE2F@bgsmsx502.gar.corp.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1310468836-5517-1-git-send-email-durgadoss.r@intel.com>
In-Reply-To: <1310468836-5517-1-git-send-email-durgadoss.r@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Guenter,

> -----Original Message-----
> From: Guenter Roeck [mailto:guenter.roeck@ericsson.com]
> Sent: Monday, September 19, 2011 10:54 PM
> To: Jean Delvare
> Cc: R, Durgadoss; lm-sensors@lm-sensors.org
> Subject: Re: [lm-sensors] [PATCHv4 1/1] Hwmon: Add core/pkg Threshold Sup=
port
> to Coretemp
>=20
> On Sun, 2011-09-18 at 13:24 -0400, Jean Delvare wrote:
> > On Sat, 17 Sep 2011 11:09:43 -0700, Guenter Roeck wrote:
> > > Hi Durga,
> > >
> > > On Sat, Sep 17, 2011 at 01:40:41PM -0400, R, Durgadoss wrote:
> > > > Hi Guenter,
> > > >
> > > [ ... ]
> > >
> > > > > > For me, it looks like, we need not know whether the threshold is
> upper or
> > > > > lower.
> > > > > > Anyway, for every threshold, we will get two interrupts (for ei=
ther
> > > > > direction)
> > > > > > So, the user space can assume either a lower threshold and look=
 for 0
> in the
> > > > > > Corresponding alarm interface Or a higher threshold and look fo=
r 1 in
> the
> > > > > > alarm interface. Will this not work ?
> > > > > >
> > > > > For a lower threshold, "alarm" implies "temperature is at or below
> threshold",
> > > > > In other words, "alarm" can mean that a value is above or below a=
 given
> > > > > threshold -
> > > > > it has a semantics that depends on its context.
> > > > >
> > > > > This context is not known in the case of a generic threshold. Thi=
s is
> why I
> > > > > suggested
> > > > > to use a more neutral term, such as "triggered", which would impl=
y "at
> or above
> > > > > threshold" (or possibly just "threshold triggered" if the directi=
on is
> not
> > > > > known)
> > > > > without attaching a semantics to it.
> > > > >
> > > >
> > > > Ok. I agree. We can use tempX_thresholdY_triggered.
> > > >
> > > I'd like to hear Jean's opinion first.
> >
> > I'm fine with your proposal, yes.
> >
> > > Also, if we introduce new attributes, we should probably reinstate th=
e old
> "max".
> >
> > Definitely. And preferably the 2.6.39 variant rather than the 3.0
> > variant, i.e. no magical -20=C2=B0C offset, unless someone can explain =
where
> > it comes from.
> >
> Sounds good.
>=20
> Durga, do you have time to make those changes ?
>=20

I hope I can find some time in a couple of days.
So I Will submit a patch for this.

Thanks,
Durga=20

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
