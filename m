From: Samuel Ortiz <sameo@linux.intel.com>
Date: Mon, 31 Jan 2011 10:43:47 +0000
Subject: Re: [lm-sensors] [PATCH v3] hwmon: twl4030: Driver for twl4030 madc
Message-Id: <20110131104346.GA5954@sortiz-mobl>
List-Id: <lm-sensors.vger.kernel.org>
References: <1294287457-2438-1-git-send-email-j-keerthy@ti.com>
 <20110106053328.GA7489@ericsson.com>
 <20110106120713.GD17184@sirena.org.uk>
 <20110106150430.GA9053@ericsson.com>
 <20110106202142.GC8018@opensource.wolfsonmicro.com>
 <1294350903.9786.103.camel@groeck-laptop>
 <AANLkTinkNNhrq+b5eiE7XrYQUsR2-vVD08btqM81KJA1@mail.gmail.com>
 <AANLkTinDVZe0eefrPZsMoUyzqfQOxZsDOaD0VG3OqXyT@mail.gmail.com>
In-Reply-To: <AANLkTinDVZe0eefrPZsMoUyzqfQOxZsDOaD0VG3OqXyT@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: "J, KEERTHY" <j-keerthy@ti.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, "amit.kucheria@canonical.com" <amit.kucheria@canonical.com>, "mikko.k.ylinen@nokia.com" <mikko.k.ylinen@nokia.com>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "balajitk@ti.com" <balajitk@ti.com>, guenter.roeck@ericsson.com

Hi Keerthy,

On Sat, Jan 22, 2011 at 10:19:33PM +0530, J, KEERTHY wrote:
> On Fri, Jan 7, 2011 at 5:42 PM, J, KEERTHY <j-keerthy@ti.com> wrote:
> > On Fri, Jan 7, 2011 at 3:25 AM, Guenter Roeck
> > <guenter.roeck@ericsson.com> wrote:
> >> On Thu, 2011-01-06 at 15:21 -0500, Mark Brown wrote:
> >>> On Thu, Jan 06, 2011 at 07:04:30AM -0800, Guenter Roeck wrote:
> >>> > On Thu, Jan 06, 2011 at 07:07:13AM -0500, Mark Brown wrote:
> >>>
> >>> > > Why? =A0It's not like hwmon has an unreasonably large core or sim=
ilar.
> >>>
> >>> > Because it creates an unnecessary dependency, and because it is not=
 hwmon's
> >>> > responsibility to provide infrastructure for other subsystems or dr=
ivers.
> >>>
> >>> hwmon isn't really doing anything, though. =A0The *driver* is doing
> >>> something but it doesn't really impact the core that much. =A0Not tha=
t I'm
> >>> particularly sold on putting the ADC core in here, but total NACK bas=
ed
> >>> on that alone seems rather harsh.
> >>
> >> Possibly. However, I had suggested the following earlier (to the 1st
> >> version of the patch):
> >>
> >>> I commented on this a couple of times below - the driver mixes generic
> >>> ADC reading functions with hwmon functionality. Generic ADC reading
> >>> functionality should be moved into another driver, possibly to mfd.
> >>
> >> Obviously that was ignored. Maybe someone is willing to listen this ti=
me
> >> around.
> >>
> > I am sorry for not responding on the generic ADC handling part. Since m=
any
> > other ADC drivers are part of hwmon i thought hwmon was the appropriate
> > place. However I can surely split the generic ADC handling part in mfd =
and
> > only hardware monitoring part in hwmon as suggested.
> >
> >> I won't let people break modularity just for convenience in a subsystem
> >> I am responsible for. And forcing the hwmon subsystem, and with it a
> >> specific hwmon driver, to exist just because the adc functionality it
> >> provides is needed by some other (most likely unrelated) subsystem /
> >> driver _does_ break modularity. Worse, it is completely unnecessary to
> >> do so. Other twl4030 functionality was extracted into generic code.
> >> twl-core.c, twl4030-codec.c, twl4030-irq.c, twl4030-power.c are all in
> >> mfd. I fail to see the problem with mfd/twl4030-adc.c.
> >>
> >> Guenter
> >>
> >>
> >>
> >
> > Hello Samuel,
> >
> > Is it ok to have the generic ADC functionality in mfd as a separate fil=
e?
> >
> > Regards,
> > Keerthy
> >
>=20
> Hello Samuel,
>=20
> We need your valuable inputs. Can generic ADC functionality can be in
> mfd as a separate file?
If it's really generic and doesn't mix hwmon stuff in the middle, then yes.

Cheers,
Samuel.

--=20
Intel Open Source Technology Centre
http://oss.intel.com/

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
