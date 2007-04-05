From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Thu, 05 Apr 2007 02:42:18 +0000
Subject: Re: [lm-sensors] What about i2c_smbus_read_block_data() ?
Message-Id: <20070405024218.GD5464@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <200704042149.21264.hjk@linutronix.de>
In-Reply-To: <200704042149.21264.hjk@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hello:

* Hans-J=FCrgen Koch <hjk@linutronix.de> [2007-04-04 23:32:34 +0200]:
> Am Mittwoch, 4. April 2007 21:49 schrieb Hans-J=FCrgen Koch:
> > I'm working on a driver for LM93. I've got some code by Mark Hoffman, (=
c)2004.=20
> > It doesn't compile on a recent kernel, because it heavily uses a functi=
on called
> > i2c_smbus_read_block_data(). Googling for that, I found this old mail i=
n the
> > archives (October 2005):
> >=20
> > http://lists.lm-sensors.org/pipermail/lm-sensors/2005-October/013971.ht=
ml
> >=20
> > Jean, what do you say to that today? Can we have that function back in
> > mainline, or do I have to find another solution?
> > If you agree to add it, I could prepare a patch for it, if you don't ha=
ve
> > a recent version handy.
>=20
> Answering my own question: After looking at i2c-core.c et al., I find it =
quite
> obvious that this function should be added, if a driver needs it.=20
>=20
> I attached a patch that does this. Would that be acceptable? I can resend=
 it
> when I have the LM93 patch ready.

I think if you put it in the same patchset with lm93.c, that will be fine.

Jean: I can do the initial review of this one for you when it's ready.

Regards,

--=20
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
