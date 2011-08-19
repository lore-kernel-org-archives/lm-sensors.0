From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 19 Aug 2011 13:48:07 +0000
Subject: Re: [lm-sensors] [RFC PATCH 6/6 V2] hwmon: OMAP4: On die
Message-Id: <20110819134807.GA30736@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1313664735-8917-1-git-send-email-j-keerthy@ti.com>
 <1313664735-8917-7-git-send-email-j-keerthy@ti.com>
 <20110819021333.GA27544@ericsson.com>
 <CAJ6a13b6EQNhkQ+i5vf0kxKJ3RadY7iSCSJwZ5_sd3Y0BydUow@mail.gmail.com>
 <20110819061745.GA28832@ericsson.com>
 <CAJ6a13b17aAyQeumdqjAVR9Fs7mP6J-b9f+bJe+B6Dk0SXw3qg@mail.gmail.com>
In-Reply-To: <CAJ6a13b17aAyQeumdqjAVR9Fs7mP6J-b9f+bJe+B6Dk0SXw3qg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: "J, KEERTHY" <j-keerthy@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Jean Delvare <khali@linux-fr.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

On Fri, Aug 19, 2011 at 09:01:53AM -0400, J, KEERTHY wrote:
> On Fri, Aug 19, 2011 at 11:47 AM, Guenter Roeck
> <guenter.roeck@ericsson.com> wrote:
> > On Fri, Aug 19, 2011 at 02:04:58AM -0400, J, KEERTHY wrote:
> >> On Fri, Aug 19, 2011 at 7:43 AM, Guenter Roeck
> >> <guenter.roeck@ericsson.com> wrote:
> >> > On Thu, Aug 18, 2011 at 06:52:15AM -0400, Keerthy wrote:
> >> >> On chip temperature sensor driver. The driver monitors the temperat=
ure of
> >> >> the MPU subsystem of the OMAP4. It sends notifications to the user =
space if
> >> >> the temperature crosses user defined thresholds via kobject_uevent =
interface.
> >> >> The user is allowed to configure the temperature thresholds vis sys=
fs nodes
> >> >> exposed using hwmon interface.
> >> >>
> >> >> Signed-off-by: Keerthy <j-keerthy@ti.com>
> >> >> Cc: Jean Delvare <khali@linux-fr.org>
> >> >> Cc: Guenter Roeck <guenter.roeck@ericsson.com>
> >> >> Cc: lm-sensors@lm-sensors.org
> >> >
> >> > High level review:
> >> >
> >> > - too much and too broad mutex locking. show functions should not ne=
ed locks at all,
> >> > =A0set functions only while data is written into registers and into =
platform data.
> >>
> >> Ok. I will clean this.
> >>
> >> > - driver is quite noisy. There should definitely not be any log mess=
ages
> >> > =A0if a set parameter is wrong. Show functions already return an err=
or value
> >> > =A0to the user; a log message indicating the error again just create=
s noise.
> >> > =A0For one boolean set during probe (is_efuse_valid), each subsequen=
t show results
> >> > =A0in a log message if it is false. Some errors result in multiple l=
og messages.
> >>
> >> A user tries to set an invalid temperature threshold. The user should
> >> be notified about this. The invalid temperature will not be set. The u=
ser
> >> should not be allowed to set an invalid temperature. It is to inform
> >> the user about precisely the problem with the parameter.
> >>
> > User is notified with -EINVAL. Unless on the console, which is unlikely,
> > the user will likely not notice a message in the kernel log.
>=20
> These messages on console are useful for debug purpose
> so can i place it under dev_dbg? Only on explicit enabling
> these messages can be seen.
>=20
Not really for user errors.
The user is already alerted with EINVAL that the parameter was invalid. _Wh=
y_
it was invalid should be well defined. Are you really sure you want to have=
=20
something like "user entered 'Hello' as temperature" even in a debug log ? =

The debug log should be to debug driver problems and behavior, not to debug
wrong parameters entered by users.

> >
> >> In some of the samples the bandgap is not trimmed and hence
> >> temperature reported will be wrong. So every time a user tries to read
> >> he is alerted that the temperatures are not accurate.
> >>
> > In the kernel log ? Sorry, that doesn't make sense. You alert the syste=
m administrator,
> > not the user.
>=20
> Ok. Can this be a dev_dbg message? Only for debug purpose
> this can be useful.
>=20
Yes, but even then you need the message only once.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
