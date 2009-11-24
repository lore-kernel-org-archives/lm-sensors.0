From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 24 Nov 2009 13:26:54 +0000
Subject: Re: [lm-sensors] [PATCH v3] k10temp: temperature sensor for AMD
Message-Id: <20091124142654.76f4d166@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4AF91F70.10106@ladisch.de>
	<4B06501B.8080509@ladisch.de>
	<87ws1l5wcl.fsf@depni.sinp.msu.ru>
	<4B0673D7.5010006@ladisch.de>
	<20091120123016.19d98ab4@hyperion.delvare>
	<4B068402.7020606@ladisch.de>
	<20091120131855.7f8f8722@hyperion.delvare>
	<4B0A3DB6.9090703@ladisch.de>
	<20091123145154.5b2b5735@hyperion.delvare>
	<4B0AAA55.3040702@ladisch.de>
	<20091123200527.1114cbc2@hyperion.delvare>
	<4B0B9CB1.3090808@ladisch.de>
In-Reply-To: <4B0B9CB1.3090808@ladisch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Serge Belyshev <belyshev@depni.sinp.msu.ru>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

On Tue, 24 Nov 2009 09:43:29 +0100, Clemens Ladisch wrote:
> Jean Delvare wrote:
> > On Mon, 23 Nov 2009 16:29:25 +0100, Clemens Ladisch wrote:
> > > There still is the built-in diode to be read by the motherboard, but =
the
> > > internal sensor was never intended to be an absolute measurement but
> > > just as a means for controlling the cooling.
> >=20
> > Still we use it for that purpose at the moment. Maybe we simply should
> > not?
>=20
> Well, the absolute measurements have essentially the same purpose, and
> would not make much sense without comparing them to some absolute limit.

Of course. The problem is that users don't know that the temperature
isn't real, and then get puzzled when comparing with other temperature
sensors in their system, which _do_ report physical temperatures.

> In any case, it might make more sense to show such values as something
> like "20 =B0C below maximum".

I think so, yes. Now the difficulty is to come up with a suitable sysfs
interface. Dropping the current interface altogether doesn't sound
right as it will take time before a new version of libsensors is
written and spread out and all applications add support for the new
interface. In the meantime, I guess we want users to still see the
approximate value.

So ideally we would come up with an interface that adds up to the one
we have currently. Future libsensors/applications could read the extra
information to display the value in a different format so that the
users see the difference.

An idea I have about this is adding a sysfs file temp#_relative, which
would contain the fake temperature value that is used as a reference
for the thermal sensor in question. In the case of k10temp, the value
would be 70000. So for example we would have:

temp1_input: 46000
temp1_relative: 70000

Old applications would display this as 46=B0C while new ones would
display "24=B0C below the limit". For coretemp this could be 85000 or
100000 (at least in the case where we don't know the limit for sure.)

If there are limits exported (temp1_max, temp1_crit etc.) the same
offset could be applied to them too.

This approach has the advantage of backwards compatibility. It may not
be considered flexible enough though... For example it does not support
sensors with totally arbitrary scales (where 1000 !=3D 1=B0C.) I seem to
remember we've seen this in the past?

If others have ideas about how we can support this, I'm all ears.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
