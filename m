From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 15 Nov 2009 19:03:57 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (adt7475) Fix temperature fault
Message-Id: <20091115200357.417dbd91@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20091109113746.337b8062@hyperion.delvare>
In-Reply-To: <20091109113746.337b8062@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Sun, 15 Nov 2009 19:57:26 +0100, Hans de Goede wrote:
> On 11/15/2009 05:54 PM, Jean Delvare wrote:
> > On Mon, 9 Nov 2009 13:26:21 +0100, Jean Delvare wrote:
> >> Thanks for the feedback. I have tested on 3 dumps I have here, one
> >> ADT7475 and two ADT7473. The ADT7475 reports -64=B0C for temp1 and tem=
p3
> >> and has both fault bits set to 1. The two ADT7473 reports reasonable
> >> values for both temp1 and temp3 and have the fault bits set to 0.
> >> Assuming that the ADT7473 and ADT7475 are almost the same chip and
> >> should thus behave the same, my change would be correct.
> >>
> >> I have also noticed that Jordan's original code did not have the
> >> inversion:
> >>
> >> http://lists.lm-sensors.org/pipermail/lm-sensors/2008-January/022338.h=
tml
> >>
> >> 	case FAULT:
> >> 		/* Note - only for remote1 and remote2 */
> >>
> >> 		ret =3D sprintf(buf, "%d\n",
> >> 			(data->alarms&  (sattr->index ? 0x4000 : 0x8000)));
> >> 		break;
> >>
> >> but it lacked normalization (output value 0x4000 or 0x8000 instead of
> >> 1.) Maybe when normalizing the logic was inverted by accident?
> >>
> >> The few ADT7475 data points I have found on the web suggest that on
> >> many boards temp1 and temp3 are not connected. This could explain why
> >> the bug went unnoticed so far. Why vendors use these chips, which are
> >> specifically designed for automatic temperature-based fan speed
> >> control, in designs where they don't bother wiring the thermal sensors,
> >> is beyond me.
> >>
> >> Anyway, I will wait for you to return home and test on your system,
> >> before sending the patch to Linus.
> >
> > Hans, did you have the time to test this patch?
>=20
> I did not get around to it sofar, but I had already planned to do it this
> evening, so I just have. Your patch seems to be correct when run on real
> hardware (and the current code in the kernel is thus wrong).

OK, thanks. I'll send the fix to Linus shortly.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
