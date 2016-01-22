From: =?iso-8859-1?Q?St=E9phan?= Kochen <stephan@kochen.nl>
Date: Fri, 22 Jan 2016 23:02:40 +0000
Subject: Re: [lm-sensors] [PATCH 3/3] lm90: register with thermal zones
Message-Id: <20160122230239.GA22301@Stephans-iMac.lan>
List-Id: <lm-sensors.vger.kernel.org>
References: <1453404877-17897-1-git-send-email-stephan@kochen.nl>
 <1453404877-17897-4-git-send-email-stephan@kochen.nl>
 <20160122224542.GA26117@rob-hp-laptop>
In-Reply-To: <20160122224542.GA26117@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Fri, Jan 22, 2016 at 04:45:42PM -0600, Rob Herring wrote:
> On Thu, Jan 21, 2016 at 08:34:37PM +0100, St=E9phan Kochen wrote:
> > +- #thermal-sensor-cells: Should be 1. See ../../thermal/thermal.txt fo=
r a
> > +                         description of this property. Use the followi=
ng
> > +                         values to refer to a specific sensor:
> > +                         0: chip internal sensor
> > +                         1: external sensor
> > +                         2: second external sensor, if present
>=20
> From my read of an LM90 datasheet, there is only an onchip sensor and a=20
> single external one.

MAX6695 and MAX6696 have two external sensors, and also use the lm90
driver. (The LM90_HAVE_TEMP3 flag in the code.)

--=20
St=E9phan Kochen

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
