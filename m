From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 26 Oct 2005 22:19:48 +0000
Subject: [lm-sensors] [PATCH 15/16] hwmon: lm90 documentation update
Message-Id: <20051026222021.39cc28bd.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Content-Disposition: inline; filename=3Dhwmon-lm90-03-new-addresses.patch

Update the I2C addresses for the ADM1032 and ADT7461 chips.
Also update the links to the Analog Devices web site.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

---
 Documentation/hwmon/lm90 |    8 ++++----
 drivers/hwmon/lm90.c     |   16 +++++++---------
 2 files changed, 11 insertions(+), 13 deletions(-)

--- linux-2.6.14-rc5.orig/Documentation/hwmon/lm90	2005-10-23 17:04:55.0000=
00000 +0200
+++ linux-2.6.14-rc5/Documentation/hwmon/lm90	2005-10-23 17:16:45.000000000=
 +0200
@@ -24,14 +24,14 @@
                http://www.national.com/pf/LM/LM86.html
   * Analog Devices ADM1032
     Prefix: 'adm1032'
-    Addresses scanned: I2C 0x4c
+    Addresses scanned: I2C 0x4c and 0x4d
     Datasheet: Publicly available at the Analog Devices website
-               http://products.analog.com/products/info.asp?product=ADM1032
+               http://www.analog.com/en/prod/0,2877,ADM1032,00.html
   * Analog Devices ADT7461
     Prefix: 'adt7461'
-    Addresses scanned: I2C 0x4c
+    Addresses scanned: I2C 0x4c and 0x4d
     Datasheet: Publicly available at the Analog Devices website
-               http://products.analog.com/products/info.asp?product=ADT7461
+               http://www.analog.com/en/prod/0,2877,ADT7461,00.html
     Note: Only if in ADM1032 compatibility mode
   * Maxim MAX6657
     Prefix: 'max6657'
--- linux-2.6.14-rc5.orig/drivers/hwmon/lm90.c	2005-10-23 17:04:55.00000000=
0 +0200
+++ linux-2.6.14-rc5/drivers/hwmon/lm90.c	2005-10-23 17:17:37.000000000 +02=
00
@@ -31,7 +31,7 @@
  * Devices. That chip is similar to the LM90, with a few differences
  * that are not handled by this driver. Complete datasheet can be
  * obtained from Analog's website at:
- *   http://products.analog.com/products/info.asp?product=ADM1032
+ *   http://www.analog.com/en/prod/0,2877,ADM1032,00.html
  * Among others, it has a higher accuracy than the LM90, much like the
  * LM86 does.
  *
@@ -49,7 +49,7 @@
  * register values are decoded differently) it is ignored by this
  * driver. Complete datasheet can be obtained from Analog's website
  * at:
- *   http://products.analog.com/products/info.asp?product=ADT7461
+ *   http://www.analog.com/en/prod/0,2877,ADT7461,00.html
  *
  * Since the LM90 was the first chipset supported by this driver, most
  * comments will refer to this chipset, but are actually general and
@@ -83,10 +83,10 @@
  * Addresses to scan
  * Address is fully defined internally and cannot be changed except for
  * MAX6659.
- * LM86, LM89, LM90, LM99, ADM1032, MAX6657 and MAX6658 have address 0x4c.
- * LM89-1, and LM99-1 have address 0x4d.
+ * LM86, LM89, LM90, LM99, ADM1032, ADM1032-1, ADT7461, MAX6657 and MAX6658
+ * have address 0x4c.
+ * ADM1032-2, ADT7461-2, LM89-1, and LM99-1 have address 0x4d.
  * MAX6659 can have address 0x4c, 0x4d or 0x4e (unsupported).
- * ADT7461 always has address 0x4c.
  */
=20
 static unsigned short normal_i2c[] =3D { 0x4c, 0x4d, I2C_CLIENT_END };
@@ -500,14 +500,12 @@
 			}
 		} else
 		if (man_id =3D 0x41) { /* Analog Devices */
-			if (address =3D 0x4C
-			 && (chip_id & 0xF0) =3D 0x40 /* ADM1032 */
+			if ((chip_id & 0xF0) =3D 0x40 /* ADM1032 */
 			 && (reg_config1 & 0x3F) =3D 0x00
 			 && reg_convrate <=3D 0x0A) {
 				kind =3D adm1032;
 			} else
-			if (address =3D 0x4c
-			 && chip_id =3D 0x51 /* ADT7461 */
+			if (chip_id =3D 0x51 /* ADT7461 */
 			 && (reg_config1 & 0x1F) =3D 0x00 /* check compat mode */
 			 && reg_convrate <=3D 0x0A) {
 				kind =3D adt7461;

--=20
Jean Delvare
