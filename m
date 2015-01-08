From: Pavel Machek <pavel@ucw.cz>
Date: Thu, 08 Jan 2015 22:58:25 +0000
Subject: Re: [lm-sensors] hwmon strangeness, no fan control on w83627dhg
Message-Id: <20150108225825.GA5700@amd>
List-Id: <lm-sensors.vger.kernel.org>
References: <20150108202919.GA25118@amd>
In-Reply-To: <20150108202919.GA25118@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi!

> Le Thursday 08 January 2015 =E0 21:29 +0100, Pavel Machek a =E9crit :
> > hwmon is quite incosistent on my machine: in hwmon0 case, temperature
> > files are in directly in hwmon0 subdirectory, but in hwmon1 case, they
> > are in hwmon1/device/ . Is that expected? Why is it so?
>=20
> This is for historical reasons. We are in the process of cleaning it all
> up (attributes should always be in the hwmon class device) but there are
> many drivers left to convert.

So my "hwmon0" is correct and "hwmon1" needs conversion, right?

> Anyway, both libsensors and pwmconfig/fancontrol support both, so if
> your version of lm-sensors is recent enough, this shouldn't be an
> issue.

Ok, good to know.

> > I tried playing with other files, too, but no luck. Documentation
> > mentions:
> >=20
> > Note: last six functions are influenced by other control bits, not yet
> > exported
> >       by the driver, so a change might not have any effect.
> >=20
> >=20
> > Any ideas what bits those are, and what needs to be implemented? (I'm
> > currently reading through the documentation).
>=20
> Check the value of pwm2_enable. If automatic mode is set (pwm2_enable >=3D
> 2), you can't control the output value directly. Same if control is
> disabled altogether (pwm2_enable =3D 0) but I'm not sure if the w83627ehf
> driver supports that. You can only control if in manual mode
> (pwm2_enable =3D 1.)

It is in manual mode after boot... (but I think there's some fan
control going on, weird; I may be imagining it, was not able to
trigger it on purpose).

root@amd:/sys/class/hwmon/hwmon1/device# cat pwm2_enable
1
root@amd:/sys/class/hwmon/hwmon1/device# cat pwm2
80
root@amd:/sys/class/hwmon/hwmon1/device# echo 0 > pwm2
root@amd:/sys/class/hwmon/hwmon1/device# cat pwm2
80
root@amd:/sys/class/hwmon/hwmon1/device#

I even tried to set it to 1, but no luck:

root@amd:/sys/class/hwmon/hwmon1/device# echo 1 > pwm2_enable
root@amd:/sys/class/hwmon/hwmon1/device# echo 0 > pwm2
root@amd:/sys/class/hwmon/hwmon1/device# cat pwm2
80
root@amd:/sys/class/hwmon/hwmon1/device# echo 2 > pwm2
root@amd:/sys/class/hwmon/hwmon1/device# cat pwm2
80
root@amd:/sys/class/hwmon/hwmon1/device#

...and set it there and back:

root@amd:/sys/class/hwmon/hwmon1/device# echo 2 > pwm2_enable
root@amd:/sys/class/hwmon/hwmon1/device# echo 1 > pwm2_enable
root@amd:/sys/class/hwmon/hwmon1/device# cat pwm2
80
root@amd:/sys/class/hwmon/hwmon1/device# echo 40 > pwm2
root@amd:/sys/class/hwmon/hwmon1/device# cat pwm2
80
root@amd:/sys/class/hwmon/hwmon1/device#

Any other ideas?

Thanks,
								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
