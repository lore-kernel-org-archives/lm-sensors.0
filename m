From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 31 Jan 2014 18:36:50 +0000
Subject: Re: [lm-sensors] Bug(?) in PMBus core, Issue with UCD90120
Message-Id: <20140131183650.GA29348@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <2c6b4098-bf55-4b8a-a089-0a51f478fae9@VA3EHSMHS004.ehs.local>
In-Reply-To: <2c6b4098-bf55-4b8a-a089-0a51f478fae9@VA3EHSMHS004.ehs.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Fri, Jan 31, 2014 at 09:17:29AM -0800, S=F6ren Brinkmann wrote:
> Hi Guenter,
>=20
> On Thu, Jan 30, 2014 at 08:01:02PM -0800, Guenter Roeck wrote:
> > Hi S=F6ren,
> >=20
> > On Thu, Jan 30, 2014 at 05:13:42PM -0800, S=F6ren Brinkmann wrote:
> > > Hi Guenther,
> > >=20
> > > I recently became aware of some weird behavior when using the UCD9000
> > > driver for voltage monitoring. We use that device on our zc706 Zynq
> > > platform to generate 5 voltage rails. Observing the voltages in Linux
> > > showed a correct value for rail 1 but a 2x error in in rails 2-3 and a
> > > 4x error in rail 5. Digging through specs, docs and sources I could
> > > track this down to this:
> > >  - The PMBus core assumes one VOUT_MODE register per chip
> > >  - UCD90120 has VOUT_MODE registers per rail
> > >=20
> > > In our setup we have an exponent of -14 for rail 1, -13 for rails 2-4=
 and
> > > -14 for rail 5. The PMBus core only reads and uses the first one and
> > > applies it to all rails.
> > >=20
> > > I'm not sure whether the UCD devices don't comply to spec or whether
> > > this is a bug in the PMBus core, either way, the reported values from
> > > the driver are prone to be wrong/scaled by an unknown factor.
> > >=20
> > The PMBus specification is sufficiently vague to ensure that pretty much
> > any interpretation of it is PMBus compliant.
> >=20
> > > Is this somehow known behavior for which a workaround might be
> > > available? Otherwise, if you know how an acceptable solution might lo=
ok
> > > like, I might find some time and give it a shot.
> > >=20
> > I think we may have to expand the driver to detect and configure the ex=
ponent
> > per rail/page. At least I can not think of another solution right now.
> >=20
> > Can you test the patch below ? Completely untested, but it compiles.
> > It will likely need some refinement (for example, other chips may not e=
ven=20
> > have the VOUT_MODE command on non-zero pages), but should be useful for
> > testing.
>=20
> That was fast, thanks. The patch works. With it, the driver reports the
> correct voltages.
>=20
> I suspect that the UCD9200 were affected as well. Unfortunately, in our
> configs for those the exponents across all rails are the same, so I
> don't see things go wrong.
>=20
I have eval boards for several ucd92xx chips, so I should be able to
test that. I was not aware that the exponent is configurable and depends
on the rail, so I completely neglected that.

> You can add my
> Tested-by: S=F6ren Brinkmann <soren.brinkmann@xilinx.com>
>=20
Thanks a lot for testing!

> Let me know if you need a different patch to be tested.
>=20
I'll have to make sure that the new code doesn't break the driver for any o=
ther
chips using linear mode. I hope I can get that done over the weekend. I'll =
let
you know how it goes.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
