From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 24 Dec 2010 02:08:18 +0000
Subject: Re: [lm-sensors] [PATCH v3] drivers/hwmon NTC Thermistor Initial
Message-Id: <20101224020818.GA30014@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1292842122-3992-1-git-send-email-myungjoo.ham@samsung.com>
In-Reply-To: <1292842122-3992-1-git-send-email-myungjoo.ham@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Thu, Dec 23, 2010 at 08:36:04PM -0500, MyungJoo Ham wrote:
[ ... ]
> >> +int ntc_thermistor_read(struct device *dev)
> >> +{
> >> + =A0 =A0 =A0 return _ntc_thermistor_read(dev_get_drvdata(dev));
> >> +}
> >
> > Function should be removed since it is no longer exported.
> >
>=20
> I have been considering to use this function at the board file in the
> kernel space.

That means you would have to export the function, and we are back to square=
 one,
ie you really use a hwmon driver to provide functions to a non-hwmon driver.

> However, if it is removed, the driver may have a weird callback (a) or
> the board file
> may need to access sysfs filesystem and depends on sysfs (b).
>=20
> (a): add "int (*read_thermistor)(struct platform_device *pdev)" at
> struct ntc_thermistor_platform_data (in include/linux/ntc.h) and let
> ntc_thermistor_probe provide callback thru pdata back to the caller of
> platform_device_register().
>=20
> (b): read "/sysfs/devices/platform/blahblah/temp1_input"
> and keep /sysfs mounted always.
>=20
> Are these approaches fine?
>=20
Again, problem is that in order to have this functionality, you force=20
hwmon to be active for the board you are talking about. This is,
no matter how you do it, not the correct approach. Maybe someone wants to
build a kernel with no hwmon support. Then what ? This won't work.

If the adc values need to be used by non-hwmon driver(s), there should be=20
an independent driver providing adc values, a hwmon driver to convert the=20
adc values as appropriate via the hwmon sysfs ABI, and other drivers as nee=
ded,
such as your board driver, doing whatever they want to do with the adc valu=
es.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
