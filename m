From: Lucas Stach <dev@lynxeye.de>
Date: Thu, 03 Mar 2011 21:56:56 +0000
Subject: Re: [lm-sensors] [Nouveau]  hwmon API update
Message-Id: <1299189416.2255.22.camel@workstation>
List-Id: <lm-sensors.vger.kernel.org>
References: <4D57CC24.1040306@free.fr> <20110213171640.GB13323@ericsson.com>
	<20110213230833.0ee2ff16@endymion.delvare>
	<AANLkTindG=m4FhNS202MH8YVBUCoDEADTQLxo-Bf_8qx@mail.gmail.com>
	<20110303152216.GA21667@ericsson.com>  <4D6FCFF2.7040604@free.fr>
	<1299185295.2255.13.camel@workstation>
	<1299187158.18605.28.camel@groeck-laptop>
In-Reply-To: <1299187158.18605.28.camel@groeck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, nouveau <Nouveau-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org" <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>

Am Donnerstag, den 03.03.2011, 13:19 -0800 schrieb Guenter Roeck:
> On Thu, 2011-03-03 at 15:48 -0500, Lucas Stach wrote:
> > Am Donnerstag, den 03.03.2011, 18:29 +0100 schrieb Martin Peres:
> > > Le 03/03/2011 16:22, Guenter Roeck a =C3=A9crit :
> > > > On Thu, Mar 03, 2011 at 04:36:09AM -0500, Dave Airlie wrote:
> > > >> On Mon, Feb 14, 2011 at 8:08 AM, Jean Delvare<khali@linux-fr.org> =
 wrote:
> > > >>> On Sun, 13 Feb 2011 09:16:40 -0800, Guenter Roeck wrote:
> > > >>>> On Sun, Feb 13, 2011 at 07:18:44AM -0500, Martin Peres wrote:
> > > >>>>> Hi,
> > > >>>>>
> > > >>>>> I am working on power management on the nouveau driver and I ne=
ed a way
> > > >>>>> to get data out of and send commands to the i2c drivers from th=
e kernel
> > > >>>>> space.
> > > >> Martin,
> > > >>
> > > >> you probably should have cc'ed Matthew since it was his patch you =
based this on,
> > > >> and I think he can provide a good explaination.
> > > >>
> > > >> to clarify some points,
> > > >>
> > > >> radeon does probably want something exactly like this, we just hav=
en't gotten to
> > > >> it completely yet, I'd rather not have two drivers in the kernel f=
or
> > > >> exact same hardware,
> > > >> and I believe sharing the hwmon code to do what we want is a good =
plan since you
> > > >> don't go around reinventing wheels, but if hwmon/i2c maintainers h=
ave
> > > >> no interest
> > > >> it leaves with little choice but to implement about 5-10 i2c drive=
rs
> > > >> again in drm codebase.
> > > >>
> > > >> Maybe hwmon/i2c maintainers could suggest a cleaner way to impleme=
nt
> > > >> what we want,
> > > >> which I think I can summarize as
> > > >>
> > > >> a) access to monitored values in-kernel
> > > >> b) no userspace access to the same values except via sanitised via=
 the driver.
> > > >>
> > > > This is not a matter of "no interest". Interest is there, but if on=
e demands
> > > > too much one may get nothing.
> > > >
> > > > Request for b) so far was "no userspace access", period. This is un=
acceptable
> > > > since providing userspace access to monitored values is the whole p=
oint of hwmon.
> >=20
> > And that is what we want to do. But it would be nice if the graphics
> > drivers could provide a _single_ interface to userspace. Not all boards
> > have i2c hardware monitoring chips and with a single interface we could
> > fall back to the internal gpu sensor, transparently for the user.
> >=20
> > > >
> > > > I could imagine an API that covers both a) and b), as long as b) fo=
cuses
> > > > on the "sanitize" aspect and doesn't try to limit userspace access =
to attributes.
> > > >
> > > > Guenter
> > > b) was introduced by Dave, I never asked for it because I don't mind =

> > > duplicating sensor data (one hwmon device named nouveau and one for t=
he=20
> > > raw access to the i2c chip).
> >=20
> > Sorry for the confusion Martin, I brought up the point of limiting
> > userspace access and did not cc the nouveau mailing list. I think it is
> > bad behaviour to expose values to userspace which are totally off the
> > real values. This confuses users and should be avoided, especially since
> > we can provide sanitized values.
> >=20
> > Why should we push the logic and api for sanitizing the values to many
> > hwmon drivers if we could easily do this at a single point in the
> > graphics driver, if we provide the userspace interface ourself and use
> > the hwmon driver only to instrument the monitoring chip?
>=20
> I don't think the functionality (nor the internal API) should have to be
> implemented in individual drivers. Instead, there should be a new API
> between hwmon drivers and the hwmon core. Using this API, the hwmon core
> would read/write raw values from/to hwmon drivers and make those values
> available to userland and to other drivers (such as the nouveau driver).
> The hwmon core would then also perform sanitizing if necessary, ie call
> registered sanitizing functions.
>=20
> With this approach, hwmon would report sanitized values, graphics
> drivers would not have to support/generate hwmon sysfs ABI attributes,
> and hwmon driver structure would be much simpler, since drivers could
> concentrate on getting data from and to chips instead of having to deal
> with sysfs attributes. That would be a win for everyone.
>=20
> Guenter

This is a bigger change than we initially aimed for and I didn't dare to
ask for such a heavy modification, but I'm very happy with this solution
if you prefer and support it this way.

If you have no objections I will try to hack something together by this
weekend so we could further discuss the issue with some real code at
hand.

-- Lucas


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
