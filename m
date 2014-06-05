From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 05 Jun 2014 18:42:28 +0000
Subject: Re: [lm-sensors] [RFT][PATCH] hwmon: (ltc4151) Convert to devm_hwmon_device_register_with_groups
Message-Id: <20140605184228.GA1842@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1401925632.5828.1.camel@phoenix>
In-Reply-To: <1401925632.5828.1.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Thu, Jun 05, 2014 at 03:21:08PM +0200, Per Dal=E9n wrote:
> Hi Axel,
>=20
> On 06/05/2014 01:47 AM, Axel Lin wrote:
> >Use ATTRIBUTE_GROUPS macro and devm_hwmon_device_register_with_groups to
> >simplify the code a bit.
> >
> >Signed-off-by: Axel Lin <axel.lin@ingics.com>
> >---
> >Hi,
> >I don't have the h/w to test, I'd appreciate if someone can review and t=
est this
> >patch.
> >Thanks,
> >Axel
>=20
> I have tested it on our board (PowerPC e500v2) and it works fine.
>=20
With Per's test, and comparing the patch with the one I had pending,
which was almost the same, we are good to go. Applied to -next.

Per, can I add your Tested-by: ?

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
