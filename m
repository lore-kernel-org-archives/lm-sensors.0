From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 06 Jun 2011 14:48:15 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (coretemp) Further relax
Message-Id: <20110606144815.GA26517@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <493994B35A117E4F832F97C4719C4C04011E3427A6@orsmsx505.amr.corp.intel.com>
In-Reply-To: <493994B35A117E4F832F97C4719C4C04011E3427A6@orsmsx505.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Jean,

On Mon, Jun 06, 2011 at 09:57:53AM -0400, Jean Delvare wrote:
> Hi Guenter, Fenghua,
>=20
> On Wed, 1 Jun 2011 11:08:43 -0700, Guenter Roeck wrote:
> > Further relax temperature range checks after reading the IA32_TEMPERATU=
RE_TARGET
> > register. If the register returns a value other than 0 in bits 16..32, =
assume
> > that the returned value is correct.
> >=20
> > This change applies to both packet and core temperature limits.
>=20
> Sorry for the later reply. Looks good to me, tested OK on my 3 systems.
>=20
> See comment below though.
>=20
> > Cc: Carsten Emde <C.Emde@osadl.org>
> > Cc: Fenghua Yu <fenghua.yu@intel.com>
> > Cc: Jean Delvare <khali@linux-fr.org>
> > Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> > ---
> >  drivers/hwmon/coretemp.c |    4 ++--
> >  1 files changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
> > index 1680977..85e9379 100644
> > --- a/drivers/hwmon/coretemp.c
> > +++ b/drivers/hwmon/coretemp.c
> > @@ -296,7 +296,7 @@ static int get_tjmax(struct cpuinfo_x86 *c, u32 id,=
 struct device *dev)
> >  		 * If the TjMax is not plausible, an assumption
> >  		 * will be used
> >  		 */
> > -		if (val >=3D 70 && val <=3D 125) {
> > +		if (val) {
> >  			dev_info(dev, "TjMax is %d C.\n", val);
> >  			return val * 1000;
> >  		}
> > @@ -326,7 +326,7 @@ static int get_pkg_tjmax(unsigned int cpu, struct d=
evice *dev)
> >  	err =3D rdmsr_safe_on_cpu(cpu, MSR_IA32_TEMPERATURE_TARGET, &eax, &ed=
x);
> >  	if (!err) {
> >  		val =3D (eax >> 16) & 0xff;
> > -		if (val > 80 && val < 120)
> > +		if (val)
> >  			return val * 1000;
> >  	}
> >  	dev_warn(dev, "Unable to read Pkg-TjMax from CPU:%u\n", cpu);
>=20
> While we're here, I don't quite get the rationale for having separate
> functions get_tjmax() and get_pkg_tjmax(). They do pretty much the
> same, don't they? Except that get_pkg_tjmax defaults to 100=B0C when
> get_tjmax calls adjust_tjmax(). This seems wrong, even though I guess
> it makes no difference in practice as adjust_tjmax() should only be
> needed for older CPU models without the package temperature sensor.
>=20
That was my assumption as well.

> Going one step further, if MSR_IA32_TEMPERATURE_TARGET is the right MSR
> for the package TjMax, then this pretty much means that this MSR (or at
> least bits 23:16 in it) is not per-core but per-package (it will return
> the same value on every core.) Then why are we calling get_tjmax (and
> then adjust_tjmax) on every core if the result will always be the same?
> This seems conceptually wrong and expensive.
>=20
I have not really thought about it myself, but that seems to be likely.

> So I would suggest that we move tjmax to struct pdev_entry, and only
> fetch it once from MSR_IA32_TEMPERATURE_TARGET. This would also solve a

Makes sense to me, though I'd like to get input from Fenghua if your analys=
is
is correct.

> minor annoyance I'm seeing in my kernel logs with the latest version of
> the driver:
>=20
> coretemp coretemp.0: TjMax is 97 C.
> coretemp coretemp.0: TjMax is 97 C.
> coretemp coretemp.0: TjMax is 97 C.
> coretemp coretemp.0: TjMax is 97 C.
>=20
> Imagine the result on a system with more CPUs and more core per CPUs...
> Not sure if the message itself is very valuable anyway, as tjmax will
> be visible in the output of "sensors" or any other monitoring
> application, but if we keep it, it should only be displayed once per
> physical CPU.
>=20
We should probably make the message a debug message or remove it entirely.
After all, we don't display this kind of stuff for other drivers either. An=
d,
yes, I do get it 16 times on one of the systems I tested it with ;).

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
