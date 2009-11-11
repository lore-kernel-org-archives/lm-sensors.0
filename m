From: Onkalo Samu <samu.p.onkalo@nokia.com>
Date: Wed, 11 Nov 2009 07:32:35 +0000
Subject: Re: [lm-sensors] [RFC PATCH 09/10] lis3: Scale output values to mg
Message-Id: <1257924755.3507.19.camel@4fid08082>
List-Id: <lm-sensors.vger.kernel.org>
References: <1257250185-7929-10-git-send-email-samu.p.onkalo@nokia.com>
In-Reply-To: <1257250185-7929-10-git-send-email-samu.p.onkalo@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Tue, 2009-11-10 at 14:42 +0100, ext =C3=89ric Piel wrote:
> Op 10-11-09 14:31, Daniel Mack schreef:
> > Does the change to the min/max parameters to input_set_abs_params()
> > also reflect the factor in which the multiplication factor alters?
> >=20
> > In other words: If I scale the read value to the full range reported by
> > the input device - will I still get the same value before and after the
> > change? If that's the case, I guess the 'breakage' would be acceptable.
> So your question is whether this changes the values of the joystick
> interface, right? I haven't tested the patch, so Samu could probably
> better answer, but looking at the code and with what I know about the
> joystick subsystem, it shouldn't as the values are always scaled between
> -32000 and 32000 (approximately).
>=20

I test this on hw. When the values are read via /dev/input/jsx it
doesn't matter if the scaling is on or off.=20
If the js_corr.type is set to JS_CORR_NONE, raw values are passed via
jstick interface and then the scaling naturally changes the scale.

This can be invisible change depending on the joystick interface
configuration.=20

> [thinking further....]
>=20
> So not only this means it's not going to break applications using only
> the joystick interface, it also means that the whole business of scaling
> the raw values for the joystick subsystem in the patch is completely
> useless. Scaling to mG should be done only for the sysfs interface.
>=20
> Samu, could you confirm my understanding, and fix the patch if necessary?

Well, raw input values can be read also from /dev/input/eventx. In that
interface, scaling matter similarly as in sysfs. By scaling the values,=20
sysfs and "raw" values from eventx would mean same thing for all the
different variants of the chip. Also if there will be a need to use full
scale is some cases (+- 8G for 8 bit and and +-6G for 12bit), meaning of
the output values are not changed if the scaling is in use.

From that point of view, scaling is not breaking joystick interface and
other users would get similar values regardless of the chip.

Br,
Samu



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
