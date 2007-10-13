From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 13 Oct 2007 17:22:45 +0000
Subject: [lm-sensors] hwmon: (fschmd) Discard non-ASCII characters
Message-Id: <20071013192245.1054a497@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Somehow non-ASCII characters managed to sneak into the fschmd driver.
Kick them out.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Hans de Goede <j.w.r.degoede@hhs.nl>
---
 drivers/hwmon/fschmd.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.23-rc0.orig/drivers/hwmon/fschmd.c	2007-10-13 15:42:51.000000=
000 +0200
+++ linux-2.6.23-rc0/drivers/hwmon/fschmd.c	2007-10-13 19:18:13.000000000 +=
0200
@@ -133,7 +133,7 @@ static const u8 FSCHMD_REG_TEMP_STATE[5]
 	{ 0x71, 0x81, 0x91 },				/* her */
 	{ 0x71, 0xd1, 0x81, 0x91 },			/* scy */
 	{ 0x71, 0x81, 0x91 },				/* hrc */
-	{ 0x71, 0x81, 0x91, 0xd1, 0xe1 },		/*=A0hmd */
+	{ 0x71, 0x81, 0x91, 0xd1, 0xe1 },		/* hmd */
 };
=20
 /* temperature high limit registers, FSC does not document these. Proven t=
o be
@@ -146,7 +146,7 @@ static const u8 FSCHMD_REG_TEMP_LIMIT[5]
 	{ 0x76, 0x86, 0x96 },				/* her */
 	{ 0x76, 0xd6, 0x86, 0x96 },			/* scy */
 	{ 0x76, 0x86, 0x96 },				/* hrc */
-	{ 0x76, 0x86, 0x96, 0xd6, 0xe6 },		/*=A0hmd */
+	{ 0x76, 0x86, 0x96, 0xd6, 0xe6 },		/* hmd */
 };
=20
 /* These were found through experimenting with an fscher, currently they a=
re


--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
