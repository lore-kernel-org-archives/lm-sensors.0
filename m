From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 13 Jul 2007 12:29:41 +0000
Subject: [lm-sensors] [PATCH] hwmon/adm1031: Fix broken links in
Message-Id: <20070713142941.160b839a@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

The Analog Devices chip information pages moved to a different location.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 Documentation/hwmon/adm1031 |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.23-pre.orig/Documentation/hwmon/adm1031	2007-02-04 19:44:54.0=
00000000 +0100
+++ linux-2.6.23-pre/Documentation/hwmon/adm1031	2007-07-13 14:27:26.000000=
000 +0200
@@ -6,13 +6,13 @@ Supported chips:
     Prefix: 'adm1030'
     Addresses scanned: I2C 0x2c to 0x2e
     Datasheet: Publicly available at the Analog Devices website
-               http://products.analog.com/products/info.asp?product=ADM1030
+               http://www.analog.com/en/prod/0%2C2877%2CADM1030%2C00.html
=20
   * Analog Devices ADM1031
     Prefix: 'adm1031'
     Addresses scanned: I2C 0x2c to 0x2e
     Datasheet: Publicly available at the Analog Devices website
-               http://products.analog.com/products/info.asp?product=ADM1031
+               http://www.analog.com/en/prod/0%2C2877%2CADM1031%2C00.html
=20
 Authors:
         Alexandre d'Alton <alex@alexdalton.org>


--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
