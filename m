From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 24 Oct 2007 08:38:02 +0000
Subject: Re: [lm-sensors] [patch 1/1] applesmc for Mac Pro 2 x Quad-Core
Message-Id: <20071024103802.46267b07@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20071023120239.GD30546@jupiter.solarsys.private>
In-Reply-To: <20071023120239.GD30546@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Tue, 23 Oct 2007 20:40:55 -0400, Mark M. Hoffman wrote:
> Hi Jean:
>=20
> * Jean Delvare <khali@linux-fr.org> [2007-10-23 23:01:36 +0200]:
> > On Tue, 23 Oct 2007 08:02:39 -0400, Mark M. Hoffman wrote:
> > > Ren=E9: there is a series of patches for the f75375s hwmon driver tha=
t allow fans
> > > to be initialized with platform data.  Although I haven't reviewed th=
e series
> > > in detail yet, IMO the concept looks OK and it may be appropriate for=
 the Macs
> > > also.
> > >=20
> > > http://lists.lm-sensors.org/pipermail/lm-sensors/2007-October/021597.=
html
> > > http://lists.lm-sensors.org/pipermail/lm-sensors/2007-October/021598.=
html
> > > http://lists.lm-sensors.org/pipermail/lm-sensors/2007-October/021599.=
html
> >=20
> > I still need to be convinced why this has to be hard-coded in the
> > kernel when the same can be done, and fine-tuned, in user-space just
> > fine.
>=20
> For the same reasons that it would be better still if it were done by the=
 BIOS.
>=20
> When the machine's safety is at stake, you initialize the hardware into a=
 sane,
> safe state as early as possible.  Fine tuning is not the issue here.  Whe=
n you
> *know* that the hardware does not come up into a safe state, you should c=
orrect
> that ASAP.
>=20
> Say fsck fails out to a shell during early inits... so the fans run full-=
on,
> big deal the machine needs attention anyway.  That sure beats having some
> unrelated early userspace problem cause your power supply to catch fire.
>=20
> Is that good hardware design?  No, but that's irrelevant.
>=20
> You are going to have to convince *me* why that patch series is a bad ide=
a.

OK, you're right.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
