From: Guenter Roeck <groeck-dsl@sbcglobal.net>
Date: Wed, 12 Dec 2012 16:51:53 +0000
Subject: Re: [lm-sensors] [PATCH 0/2] fixes for adt7410
Message-Id: <20121212165153.GA7181@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <50032AD8.9040103@gmx.de>
 <50033218.7030602@metafoo.de>
 <20120716083428.GD30009@pengutronix.de>
 <5003D404.4040005@kernel.org>
 <50C7902C.2060804@gmx.de>
 <50C7932A.2030104@metafoo.de>
 <50C8478A.1070306@jic23.retrosnub.co.uk>
 <50C85797.5030501@metafoo.de>
 <20121212144728.GA4909@roeck-us.net>
 <50C89FAB.1060607@metafoo.de>
In-Reply-To: <50C89FAB.1060607@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>, Hartmut Knaack <knaack.h@gmx.de>, Jonathan Cameron <jic23@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, linux-iio@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, lm-sensors@lm-sensors.org

On Wed, Dec 12, 2012 at 04:15:55PM +0100, Lars-Peter Clausen wrote:
> On 12/12/2012 03:47 PM, Guenter Roeck wrote:
> > On Wed, Dec 12, 2012 at 11:08:23AM +0100, Lars-Peter Clausen wrote:
> >> Added Guenter Roeck to Cc, since he merged the hwmon patch.
> >>
> >> On 12/12/2012 09:59 AM, Jonathan Cameron wrote:
> >>> On 11/12/12 20:10, Lars-Peter Clausen wrote:
> >>>> On 12/11/2012 08:57 PM, Hartmut Knaack wrote:
> >>>>> Jonathan Cameron schrieb:
> >>>>>> On 7/16/2012 9:34 AM, Sascha Hauer wrote:
> >>>>>>> On Sun, Jul 15, 2012 at 11:11:52PM +0200, Lars-Peter Clausen wrot=
e:
> >>>>>>>> On 07/15/2012 10:40 PM, Hartmut Knaack wrote:
> >>>>>>>>> This patchset makes the ADT7410 usable. Main reason was the fol=
lowing
> >>>>>>>>> error when trying to register one of these devices:
> >>>>>>>>> [  180.945561] BUG: unable to handle kernel NULL pointer derefe=
rence
> >>>>>>>>> at   (null)
> >>>>>>>>> [  180.945592] IP: [<f84b1e80>]
> >>>>>>>>> iio_device_register_eventset+0x380/0x3a0 [industrialio]
> >>>>>>>>> This happens, since in industrialio-events.c
> >>>>>>>>> __iio_add_event_config_attrs (which does a INIT_LIST_HEAD) is n=
ot
> >>>>>>>>> called, if the channels attribute of the device is not set. As a
> >>>>>>>>> result, list_for_each_entry causes those NULL pointer dereferen=
ce
> >>>>>>>>> problems. So, before trying to access those list elements, we c=
heck
> >>>>>>>>> for their existence (also in unregister functions).
> >>>>>>>>> Now the adt7410.c ended in some complex changes - my apologies =
for this:
> >>>>>>>>>
> >>>>>>>>>     * check for exact values provided through sysfs, otherwise =
output
> >>>>>>>>> a verbose error/usage message for: sample mode, resolution, eve=
nt mode
> >>>>>>>>>     * adt7410_show_id: I don't see a point in masking out some =
LSBs,
> >>>>>>>>> if they get shifted to oblivion, anyway -> no more need for
> >>>>>>>>> ADT7410_MANUFACTORY_ID_MASK
> >>>>>>>>>     * adt7410_convert_temperature: in 13 bit mode, the driver a=
ssumed
> >>>>>>>>> the data to be stored in bits 0-12, but according to the data s=
heet,
> >>>>>>>>> it is stored in bits 3-15. Temperature readings were always aro=
und
> >>>>>>>>> 200(=B0C), while real temperature was something around 20(=B0C)=
. Simple
> >>>>>>>>> fix: mask out bits 0-2 in 13 bit mode and use the 16 bit routin=
es
> >>>>>>>>> from that point on.
> >>>>>>>>>     * adt7410_set_t_bound: handle float values provided through=
 sysfs
> >>>>>>>>> properly. Also, simplify treatment of 13 bit values by masking =
out
> >>>>>>>>> bits 0-2.
> >>>>>>>>>     * adt7410_probe, adt7410_remove: fix another possible NULL
> >>>>>>>>> pointer dereference issue, in case no platform data is provided=
. Sync
> >>>>>>>>> chip->config with the config register
> >>>>>>>> Hi,
> >>>>>>>>
> >>>>>>>> Sascha Hauer posted a couple of patches a while ago which seem t=
o fix a
> >>>>>>>> similar set of issues.
> >>>>>>>>
> >>>>>>>> See: http://www.spinics.net/lists/linux-iio/msg05947.html and
> >>>>>>>> http://www.spinics.net/lists/linux-iio/msg05955.html
> >>>>>>> Indeed, most if not all of the mentioned issues should be fixed a=
lready
> >>>>>>> with these patches.
> >>>>>>>
> >>>>>> Just to reiterate what I said to Sascha at the time...  This drive=
r does
> >>>>>> not belong in IIO. It is very much a hardware monitoring part and =
so
> >>>>>> wants to move to hwmon. We aren't going to take it out of staging =
into
> >>>>>> drivers/iio and I'm rather unwilling to take any 'new' features in=
to the
> >>>>>> staging version. Someone with hardware who is interesting needs to=
 bite
> >>>>>> the bullet and convert / rewrite this driver as a hwmon device.
> >>>>>>
> >>>>> FYI, I created a basic hwmon driver for ADT7410, which now made it =
into
> >>>>> linux 3.7.
> >>>>> Take care
> >>>>
> >>>> Ah, great, now we have two drivers which bind to the same device...
> >>>>
> >>> Yup, can one of you take a look at the two drivers and see where they
> >>> differ in functionality. We obviously don't want this messy situation
> >>> to go on for long!  Then again, we don't want to end up with missing
> >>> functionality in one of them either...
> >>
> >> The IIO driver supports more. It has support for the similar adt7310 a=
nd it
> >> also has support for reporting over- or undertemperature, something wh=
ich
> >> can't really be implemented that nicely in the hwmon framework. We did=
 think
> >=20
> > hwmon supports configuring over- and undertemperature and supports attr=
ibutes
> > for reporting it.
> >=20
> >> about moving this driver to hwmon, but since it does not really support
> >> threshold events and also is more meant for PC-style hardware monitori=
ng and
> >=20
> > There is nothing preventing you from creating such events. See gpio-fan=
 for an
> > example. That it isn't implemented for most drivers doesn't mean it is =
not
> > possible or supported.
> >=20
>=20
> Ah ok, via kobject_uevent. Hadn't seen this before. This definitely lowers
> the barrier for moving the driver to hwmon.
>=20
> >> the adt7410 has primarily other applications I did decide against it.
> >> Another reason was that we do have the IIO-to-hwmon bridge which would=
 allow
> >> to instantiate a hwmon userspace interface for the driver if necessary.
> >>
> >> Hartmut you knew of the existence of the IIO driver it would have real=
ly
> >> been nice if you had included us on Cc when you submitted the hwmon dr=
iver
> >> that would have allowed us to avoid this messy situation.
> >>
> >> One solution could be to just sent a patch to revert the hwmon driver =
patch,
> >> but I guess that would be kind of counterproductive.
> >>
> >=20
> > I see two contradicting comments above: "very much a hardware monitoring
> > part" and "needs to ... rewrite the driver as hwmon device" vs. "the ad=
t7410
> > has primarily other applications". Which one is it ?
>=20
> My understanding is (or at least was) that the hwmon framework is primari=
ly
> intended to be used for PC-like hardware monitoring. E.g. your CPU
> temperature or core voltage. The ADT7410 is a temperature sensor and while
> it also could be used as a CPU temperature monitor it not necessarily is.
> The datasheet list a wide variety of applications for example industrial
> process control.
>=20
No idea where the "PC-like" comes from. It is supposed to be used for hardw=
are
monitoring on any hardware, and for anything that needs to be monitored
(voltage, current, power, energy, temperature, humidity, fans).

Now, of course one can use all the associated sensors for other purposes,
such as for ambient or remote temperature measurements, external voltage/cu=
rrent
measurements, or remote humidity measurements, but that isn't really the po=
int.

> >=20
> >> Hartmut any suggestions from your side how to solve this?
> >>
> > Sorry, I had assumed the discussion was closed and the decision was mad=
e to move
> > the driver to hwmon.
> >=20
> > Let me know if you want me to revert the hwmon driver; no problem.
> >=20
>=20
> Since hwmon has support for alarms we may as well add the missing
> functionality to the hwmon driver and than remove the IIO driver.
>=20
Ok with me as well. Just let me know if there is anything you want me to do.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
