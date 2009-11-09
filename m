From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 09 Nov 2009 12:26:21 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (adt7475) Fix temperature fault
Message-Id: <20091109132621.234441db@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20091109113746.337b8062@hyperion.delvare>
In-Reply-To: <20091109113746.337b8062@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Hans,

On Mon, 09 Nov 2009 11:51:54 +0100, Hans de Goede wrote:
> I've a adt7475 on my home development machine in the Netherlands
> (I'm currently in Brno).
>=20
> I can (and would like to) verify this fix when I'm back home (friday).
> The adt7475 on my machine is used to control an additional fan, and has
> no external temperature sensors connected (AFAIK).
>=20
> I've tested the original adt7475 driver on this machine, but I may
> have simply out "temp1 ignore" (and temp3) in my sensors.conf missing
> this.

Thanks for the feedback. I have tested on 3 dumps I have here, one
ADT7475 and two ADT7473. The ADT7475 reports -64=B0C for temp1 and temp3
and has both fault bits set to 1. The two ADT7473 reports reasonable
values for both temp1 and temp3 and have the fault bits set to 0.
Assuming that the ADT7473 and ADT7475 are almost the same chip and
should thus behave the same, my change would be correct.

I have also noticed that Jordan's original code did not have the
inversion:

http://lists.lm-sensors.org/pipermail/lm-sensors/2008-January/022338.html

	case FAULT:
		/* Note - only for remote1 and remote2 */

		ret =3D sprintf(buf, "%d\n",
			(data->alarms & (sattr->index ? 0x4000 : 0x8000)));
		break;

but it lacked normalization (output value 0x4000 or 0x8000 instead of
1.) Maybe when normalizing the logic was inverted by accident?

The few ADT7475 data points I have found on the web suggest that on
many boards temp1 and temp3 are not connected. This could explain why
the bug went unnoticed so far. Why vendors use these chips, which are
specifically designed for automatic temperature-based fan speed
control, in designs where they don't bother wiring the thermal sensors,
is beyond me.

Anyway, I will wait for you to return home and test on your system,
before sending the patch to Linus.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
