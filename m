From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 14 Sep 2010 12:01:28 +0000
Subject: Re: [lm-sensors] [RFC PATCH] Allow the configuration register to be
Message-Id: <20100914120128.GB4586@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1284386867-21650-1-git-send-email-shubhrajyoti@ti.com>
In-Reply-To: <1284386867-21650-1-git-send-email-shubhrajyoti@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Jean,

On Tue, Sep 14, 2010 at 04:08:33AM -0400, Jean Delvare wrote:
> On Mon, 13 Sep 2010 11:09:06 -0700, Guenter Roeck wrote:
> > On Mon, Sep 13, 2010 at 01:41:21PM -0400, Jean Delvare wrote:
> > > On Mon, 13 Sep 2010 09:51:09 -0700, Guenter Roeck wrote:
> > > > I found the following attributes used for the update inverval.
> > > >=20
> > > > adt7470.c	auto_update_interval
> > > > lm95241.c	rate
> > > > adm1031.c	update_rate
> > > >=20
> > > > Not sure about adt7470.c, ince it reflects an automatic interval, b=
ut would it make sense
> > > > to update lm95241.c to use the standard attribute ?
> > >=20
> > > Yes it would.
> > >=20
> > > > On a side note, update_rate (or rate) doesn't really reflect its us=
e. A "rate"
> > > > would be measured in updates/time, not in absolute time. Or, in oth=
er words,
> > > > it reflects a frequency, not an interval. So we are really talking =
about intervals.
> > > > Not sure if that is worth bitching about, but since the attribute i=
s quite new
> > > > it might make sense to think about it.
> > >=20
> > > Jonathan Cameron (Cc'd) had a similar concern:
> > > http://lists.lm-sensors.org/pipermail/lm-sensors/2010-May/028596.html
> > >=20
> > > Nobody seemed to care back then. I can't disagree with both of you, b=
ut
> > > OTOH I don't feel too strongly about it either. So if someone submits=
 a
> > > patch making things better, that's fine with me, but I won't spend my
> > > own time on it.
> >
> > I'll submit a set of patches. update_interval ok ? It reflects the time=
 between
> > events, while period tends to reflect a duration.
>=20
> Yes, I would be fine with update_interval. Jonathan, OK with you too?
>=20
> > > > Resolution would have to be sensor dependent, since each sensor can=
 have its own resolution.
> > > > Would be nice to have an attribute for that.
> > >=20
> > > Not too sure about that. I had the same reaction at first, but do we
> > > actually know of devices where the resolution isn't global?
> >
> > Yes, in the lm90 driver. Only max6657/58/59 and max6646 have extended l=
ocal
> > temperatures, all other chips have only 8 bit resolution for the local =
temperature.
> > Remote temperatures are all extended, ie have higher resoution.
>=20
> But resolution can't be changed on these chips, can it? I think the

Correct.

> main purpose of these files is to let the user change the resolution
> for chips which support this (usually this is an update speed /
> resolution trade-off). Or do you believe that having read-only
> attributes exposing fixed resolutions would be valuable?
>=20
Good point. Probably not really. More like nice to have.

> I'm a little worried because resolution as a bit number isn't too
> informative and doesn't quite work as a device-independent value. If
> you really want the information to be exposed to user-space for all
> devices, then we'd rather use actual sensor units (mV, m=B0C, whatever)
> for resolution, and possibly add other attributes for the range. But

I assumed it would be in units. Not sure how to express resolution=20
as bit number in the first place.

> this means adding a whole lot of attribute files for some devices (if
> we do it on a per-channel basis), so we first have to determine whether
> it is really worth it. I don't think it is, but you can try and
> convince me.
>=20
Thinking about it, I'd rather keep it in mind in case someone else
sees the need to it and convinces both of us...

Another question if both attributes (rate and resolution) would make sense =

as module parameters instead. Are those attributes expected to vary across
multiple instances of the same driver ?

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
