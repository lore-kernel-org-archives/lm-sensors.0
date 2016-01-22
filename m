From: =?iso-8859-1?Q?St=E9phan?= Kochen <stephan@kochen.nl>
Date: Fri, 22 Jan 2016 22:32:39 +0000
Subject: Re: [lm-sensors] [PATCH 2/3] lm90: initialize parameters from devicetree
Message-Id: <20160122223238.GB21534@Stephans-iMac.lan>
List-Id: <lm-sensors.vger.kernel.org>
References: <1453404877-17897-1-git-send-email-stephan@kochen.nl>
 <1453404877-17897-3-git-send-email-stephan@kochen.nl>
 <56A24278.8050909@roeck-us.net>
In-Reply-To: <56A24278.8050909-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Cc: Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Fri, Jan 22, 2016 at 06:53:44AM -0800, Guenter Roeck wrote:
> On 01/21/2016 11:34 AM, St=E9phan Kochen wrote:
> >Allow a device tree to set initial temperature sensor parameters.
>=20
> This very much smells like configuration, not hardware description.
>=20
> Having said that, the thermal subsystem does something similar. This rais=
es even more
> questions, though. Since patch 3 of the series introduces registration wi=
th the thermal
> subsystem, it seems to me that the thermal subsystem should provide any l=
imits used
> to program the chips, and that there should be a mechanism for the therma=
l subsystem
> to interact with the driver to both set the limits and to be informed if =
a limit
> is exceeded.
>=20
> Also, _if_ such a set of properties is introduced and accepted by the dev=
icetree
> reviewers, it should probably be a set of properties which applies to _al=
l_ hardware
> monitoring drivers, not just to one. Even if support is not implemented i=
mmediately
> in the hwmon core, the properties should be usable in a generic way, and =
not
> reflect sysfs attribute names used by the hwmon subsystem.

The original kernel for Ouya is a 3.1 kernel from nVidia's old
Linux4Tegra branches. This kernel had its own Tegra-specific thermal
zone support which seems to do more or less that: the thermal zone
system actually uses the sensor alert interrupts to detect when it needs
to act, and reconfigures alert bounds as the temperature slides to
another range it wants to monitor.

Thermal zones in current master only have the ability to check sensor
values at an interval.

I'd agree that update-interval and the low/high bounds could be
controlled by the thermal zone system. I'm less certain what to do with
the critical/emergency bounds, and the remote-offset.

Thing about Ouya is that, even with the thermal zone currently working,
the alert bounds set when the system comes up seem to be crippling the
system with interrupts shortly after the sensor is activated. So they
have to be set to something sane. Hence why I added both.

I'm not sure if you're expecting me to do the work of extending thermal
zones. I guess I'd need to figure out how a sensor would notify a
thermal zone of an alert, and implement that functionality while staying
backwards compatible.

Thanks again,

--=20
St=E9phan Kochen

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
