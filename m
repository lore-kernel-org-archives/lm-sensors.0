From: =?iso-8859-1?Q?St=E9phan?= Kochen <stephan@kochen.nl>
Date: Fri, 22 Jan 2016 22:00:57 +0000
Subject: Re: [lm-sensors] [PATCH 1/3] lm90: separate register accessors from sysfs
Message-Id: <20160122220056.GA21534@Stephans-iMac.lan>
List-Id: <lm-sensors.vger.kernel.org>
References: <1453404877-17897-1-git-send-email-stephan@kochen.nl>
 <1453404877-17897-2-git-send-email-stephan@kochen.nl>
 <56A23FD2.9040009@roeck-us.net>
In-Reply-To: <56A23FD2.9040009-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Cc: Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Guenter,

Thanks for the taking the time to review!

You are absolutely right. I will split this up, more carefully check
coding style and simply do away with unnecessary changes.

Regarding:

On Fri, Jan 22, 2016 at 06:42:26AM -0800, Guenter Roeck wrote:
> On 01/21/2016 11:34 AM, St=E9phan Kochen wrote:
> >+#define SELECT_REGS(_reg, _channel) { \
> >+	high =3D LM90_REG_W_##_reg##H; \
> >+	low =3D LM90_REG_W_##_reg##L; \
> >+	channel =3D _channel; \
> >+}
>=20
> We have been trying to get rid of function defines such as this one.
> Most of the time it increases code size, and reduces readability.
> Plus, it increases the amount of time we have to spend reviewing
> the code to ensure it is correct.
>=20
> >+	switch (index) {
> >+	case REMOTE_LOW:    SELECT_REGS(REMOTE_LOW,  0); break;
> >+	case REMOTE_HIGH:   SELECT_REGS(REMOTE_HIGH, 0); break;
> >+	case REMOTE_OFFSET: SELECT_REGS(REMOTE_OFFS, 0); break;
> >+	case REMOTE2_LOW:   SELECT_REGS(REMOTE_LOW,  1); break;
> >+	case REMOTE2_HIGH:  SELECT_REGS(REMOTE_HIGH, 1); break;
> >+	default: return;
>=20
> ... and, in this case, introduces checkpatch errors.

Should I simply unfold the macro here? Another option would be an array
of structs like in set_temp8, but it'd have some gaps here. Or is some
other construct preferred?

I guess this is where I snuck in another change (which I will separate),
to replace SENSOR_DEVICE_ATTR_2 with regular ATTR. The setter args of
_ATTR_2 were using literal numbers to point into an array defined in the
setter function. (Maybe to avoid exactly the kind of thing I built
here.)

Would it be an idea to combine temp8 and temp11 variants, and let the
getters and setters figure out what kind of register access to do based
on register index?

Thanks again,

--=20
St=E9phan Kochen

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
