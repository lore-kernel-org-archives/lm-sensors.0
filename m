From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Wed, 24 Oct 2007 00:40:55 +0000
Subject: Re: [lm-sensors] [patch 1/1] applesmc for Mac Pro 2 x Quad-Core
Message-Id: <20071024004055.GC30539@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20071023120239.GD30546@jupiter.solarsys.private>
In-Reply-To: <20071023120239.GD30546@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Jean:

* Jean Delvare <khali@linux-fr.org> [2007-10-23 23:01:36 +0200]:
> On Tue, 23 Oct 2007 08:02:39 -0400, Mark M. Hoffman wrote:
> > > At least the 2x Quad-Core Apple Mac Pro appears to have some over-heat
> > > protection which suddenly powers off the whole box under load.  This =
adds
> > > support for the fans and temerature sensors in the Mac Pro - later so=
me
> > > "windwarm" a-like code should probably monitor the values.  For now
> > > manually tweaking the fans prevents the sudden shutdown for me.
> > >=20
> > > cd /sys/devices/platform/applesmc.768
> > > for x in fan{1,2,3,4}; do
> > > 	echo 1 > ${x}_manual
> > > 	echo 1285 > ${x}_output
> > > done
> >=20
> > Ren=E9: there is a series of patches for the f75375s hwmon driver that =
allow fans
> > to be initialized with platform data.  Although I haven't reviewed the =
series
> > in detail yet, IMO the concept looks OK and it may be appropriate for t=
he Macs
> > also.
> >=20
> > http://lists.lm-sensors.org/pipermail/lm-sensors/2007-October/021597.ht=
ml
> > http://lists.lm-sensors.org/pipermail/lm-sensors/2007-October/021598.ht=
ml
> > http://lists.lm-sensors.org/pipermail/lm-sensors/2007-October/021599.ht=
ml
>=20
> I still need to be convinced why this has to be hard-coded in the
> kernel when the same can be done, and fine-tuned, in user-space just
> fine.

For the same reasons that it would be better still if it were done by the B=
IOS.

When the machine's safety is at stake, you initialize the hardware into a s=
ane,
safe state as early as possible.  Fine tuning is not the issue here.  When =
you
*know* that the hardware does not come up into a safe state, you should cor=
rect
that ASAP.

Say fsck fails out to a shell during early inits... so the fans run full-on,
big deal the machine needs attention anyway.  That sure beats having some
unrelated early userspace problem cause your power supply to catch fire.

Is that good hardware design?  No, but that's irrelevant.

You are going to have to convince *me* why that patch series is a bad idea.

Regards,

--=20
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
