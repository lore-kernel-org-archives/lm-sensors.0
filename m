From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 23 Jun 2007 12:58:22 +0000
Subject: [lm-sensors] [PATCH] hwmon/smsc47b397: Don't report missing fans as
Message-Id: <20070623145822.3ea1bc2b@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Mon, 18 Jun 2007 16:23:53 +0100, Simon Farnsworth wrote:
> Simon Farnsworth wrote:
> > sensors output:
> >=20
> > # sensors
> > smsc47b397-isa-0480
> > Adapter: ISA adapter
> > temp1:       +44=B0C
> > temp2:       +53=B0C
> > temp3:       +26=B0C
> > temp4:      -128=B0C
> > fan1:     2011 RPM
> > fan2:       82 RPM
> > fan3:     1262 RPM
> > fan4:     1095 RPM
> (...)
>=20
> I've now experimented with cpuburn and stopping fans. It looks like 82
> RPM is the lowest speed this chip reports, as stopping a fan briefly
> caused it to report 82 RPM.

Correct, and I consider it a bug in the driver. A stopped or missing
fan should really be reported as 0 RPM, not 82. Here's a patch fixing
it.

* * * * *

Also protects ourselves against a possible division by zero.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/smsc47b397.c |    2 ++
 1 file changed, 2 insertions(+)

--- linux-2.6.22-rc5.orig/drivers/hwmon/smsc47b397.c	2007-05-13 10:01:15.00=
0000000 +0200
+++ linux-2.6.22-rc5/drivers/hwmon/smsc47b397.c	2007-06-23 14:53:09.0000000=
00 +0200
@@ -174,6 +174,8 @@ static SENSOR_DEVICE_ATTR(temp4_input, S
    REG: count of 90kHz pulses / revolution */
 static int fan_from_reg(u16 reg)
 {
+	if (reg =3D 0 || reg =3D 0xffff)
+		return 0;
 	return 90000 * 60 / reg;
 }
=20


--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
