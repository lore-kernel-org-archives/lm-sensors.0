From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 24 Jun 2007 09:23:41 +0000
Subject: [lm-sensors] [PATCH 10/10] hwmon/w83627ehf: Be quiet when no chip
Message-Id: <20070624112341.3294be8e@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

This fixes bug #8593:
http://bugzilla.kernel.org/show_bug.cgi?id=8593

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/w83627ehf.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- linux-2.6.22-rc5.orig/drivers/hwmon/w83627ehf.c	2007-06-24 10:46:24.000=
000000 +0200
+++ linux-2.6.22-rc5/drivers/hwmon/w83627ehf.c	2007-06-24 10:48:34.00000000=
0 +0200
@@ -1445,8 +1445,9 @@ static int __init w83627ehf_find(int sio
 		sio_name =3D sio_name_W83627DHG;
 		break;
 	default:
-		pr_info(DRVNAME ": unsupported chip ID: 0x%04x\n",
-			val);
+		if (val !=3D 0xffff)
+			pr_debug(DRVNAME ": unsupported chip ID: 0x%04x\n",
+				 val);
 		superio_exit(sioaddr);
 		return -ENODEV;
 	}

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
