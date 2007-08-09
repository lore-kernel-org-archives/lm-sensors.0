From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Thu, 09 Aug 2007 12:26:19 +0000
Subject: [lm-sensors] [PATCH] bad temperature values from w83781d in 2.6.22
Message-Id: <20070809122619.GF3584@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070805183219.0d54802b.akpm@linux-foundation.org> <20070808010316.GB3584@jupiter.solarsys.private> <20070808151716.GA6053@sommrey.de> <20070809035642.GE3584@jupiter.solarsys.private> <20070809070915.GA24252@sommrey.de>
In-Reply-To: <20070809070915.GA24252@sommrey.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Joerg Sommrey <jo@sommrey.de>, LKML <linux-kernel@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>

Hi Joerg:

> On Wed, Aug 08, 2007 at 11:56:42PM -0400, Mark M. Hoffman wrote:
> > Thanks for sending all that.  I see one bug clearly, and I'm pretty clo=
se to
> > seeing the other one.  But for tonight, I need sleep.

There's just one bug after all.  The second was a figment of my sleep-depri=
ved
imagination.

> > In the meantime, please try this command as root, against the newer ker=
nel,
> > *after* you've done 'sensors -s':
> >=20
> > 	# i2cset -f 0 0x2d 0x5d 0x0e b
> >=20
> > Wait > 2 seconds for the hardware to update itself, then run 'sensors' =
again.
> > I'm pretty sure you'll see the correct temps.

* Joerg Sommrey <jo@sommrey.de> [2007-08-09 09:09:15 +0200]:
> The displayed temperatures changed to 67.5=B0C / 66.0=B0C.  Still, this s=
eems to
> be too high.  The power supply's fan runs too slow for such CPU
> temperatures. In older kernels it becomes noisy above 50=B0C.
>=20
> Under load the temperatures shown are around 95=B0C, way too high.

My bad, there's a second i2cset command that would have done it.  Please try
this patch against v2.6.22.

* * * * *

commit a3333f720da3a173153b00cebc129c48cd3a40af
Author: Mark M. Hoffman <mhoffman@lightlink.com>
Date:   Thu Aug 9 08:12:46 2007 -0400

    hwmon: fix w83781d temp sensor type setting
   =20
    Commit 348753379a7704087603dad403603e825422fd9a introduced a regression=
 that
    caused temp2 and temp3 sensor type settings to be written to temp1 inst=
ead.
    The result is that temp sensor readings could be way off.
   =20
    Signed-off-by: Mark M. Hoffman <mhoffman@lightlink.com>

diff --git a/drivers/hwmon/w83781d.c b/drivers/hwmon/w83781d.c
index f85b48f..c95909c 100644
--- a/drivers/hwmon/w83781d.c
+++ b/drivers/hwmon/w83781d.c
@@ -740,9 +740,9 @@ store_sensor(struct device *dev, struct device_attribut=
e *da,
 static SENSOR_DEVICE_ATTR(temp1_type, S_IRUGO | S_IWUSR,
 	show_sensor, store_sensor, 0);
 static SENSOR_DEVICE_ATTR(temp2_type, S_IRUGO | S_IWUSR,
-	show_sensor, store_sensor, 0);
+	show_sensor, store_sensor, 1);
 static SENSOR_DEVICE_ATTR(temp3_type, S_IRUGO | S_IWUSR,
-	show_sensor, store_sensor, 0);
+	show_sensor, store_sensor, 2);
=20
 /* I2C devices get this name attribute automatically, but for ISA devices
    we must create it by ourselves. */


--=20
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
