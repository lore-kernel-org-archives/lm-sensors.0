From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 28 Apr 2010 13:04:25 +0000
Subject: Re: [lm-sensors] Core i7 temperatures query (lm_sensors Vs. BIOS)
Message-Id: <20100428150425.2f052975@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Mohit,

On Wed, 17 Feb 2010 23:42:14 +0530, mohit chawla wrote:
> <http://a.collective-media.net/jump/idgt.phoronix/article_above;sec=3Dart=
icle;fold=ABove;tile=3D2;sz00x250;ord=123456789?>
> Hello folks, I have been running Mprime successfully for testing the
> stability of my i7 system when overclocked.
>=20
> But I am concerned about the correctness of the temperatures as shown by
> lm_sensors version 3.0.2.
>=20
> Here's what I have observed.
>=20
> When I power on the computer and check the CPU temperature in the BIOS, it
> is usually around 33-34 degrees. But as soon as I boot into my OS (Ubuntu
> 9.10 64 bit), lm_sensors show temperature around 23-24 degrees.
> I am using sensors_applet for Gnome panel to see the temperatures.
>=20
> Now the thing is that just when Gnome is loading(panels coming up,
> background loading etc.), I do see that the CPU temperature being around =
33
> degrees, coming down in a second or two to 23-24 degrees.
>=20
> So, my question is, are these temperatures correct ? In other words, is it
> normal that CPU temps are high in BIOS ?

It is possible, yes. It all depends on the BIOS implementation, but
some BIOS are in a tight busy loop all the time, which keeps one CPU
core busy all the time, in turn resulting in a relatively high
temperature, basically corresponding to Linux (or any other OS) under
moderate load.

> Or is it so that when the system is
> powered on, CPU temps are usually high & when the OS has loaded, they drop
> down ?

This is expected as well. The boot process can be pretty CPU-intensive,
so it is no surprise to see a high temperature during boot, dropping to
a lower value right after boot.

> Please help me resolving this scenario, as it could lead to potential
> damages to my machine due to inaccuracy of results.

Another possibility is that the temperature reported by lm-sensors is
inaccurate. If you are using the coretemp driver, it is possible that
the critical limit is not known for your CPU model and the driver
defaults to the wrong value. This has been an issue in the past, and
still is for recent CPU models.

The value read by Core CPUs is really a relative one, so it's not
really a problem if the current temperature reported by lm-sensors
isn't correct. What really matters is that it is significantly lower
than the critical limit (and high limit too, if your CPU has one.) As
long as this is true, your CPU is safe.

--=20
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
