From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 08 May 2013 17:54:17 +0000
Subject: Re: [lm-sensors] i2c multimaster and the device driver detect function
Message-Id: <20130508175417.GB29689@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20130212164811.GV8668@pengutronix.de>
 <3D8D1B67-2846-4B78-B402-6B9FD1CB10E6@gmail.com>
In-Reply-To: <3D8D1B67-2846-4B78-B402-6B9FD1CB10E6-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?iso-8859-1?Q?Jean-Fran=E7ois?= Dagenais <jeff.dagenais-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org

On Wed, May 08, 2013 at 11:57:59AM -0400, Jean-Fran=E7ois Dagenais wrote:
> Hi all,
>=20
> I've read the discussion on multimaster and I have to agree with Uwe abou=
t masters doing the arbitration (and retry). However, there's another issue=
 which one quickly discovers when adding a second master on a physical i2c =
bus.
>=20
> Here's the scenario: Using driver jc42 which adds a "detect" function, an=
d using two masters which end-up creating "i2c-0" and "i2c-1", the temp sen=
sors get instanciated twice, i.e. once on each bus master. This is obviousl=
y very problematic as there are two driver instances controlling the exact =
same chip.
>=20
> Before I dive a bit too much into this, is there something I am missing?
>=20
Isn't it the point of having multiple masters on the same bus, that each of
them can manage the same devices ?

Question for me is why you would want two masters in the same system context
point to the same I2C bus. Usually the second master would be something lik=
e an
IPMI controller or a second CPU/controller board in a redundant system.

Even then the multi-master scenario is problematic, as you still end up with
multiple masters controlling the same device. That is a problem inherent to=
 I2C,
and especially problematic with multi-page devices (typical problem: master=
 1
sets page, master 2 sets page, master 1 accesses wrong data). I don't think=
 there
is a clean solution to solve that, other than to block i2c access for one o=
f the
masters entirely.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
