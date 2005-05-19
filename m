From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:48 +0000
Subject: [PATCH 2.6] I2C: Kill address ranges in non-sensors i2c chip
Message-Id: <20050402184103.6048d243.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

Some months ago, you killed the address ranges mechanism from all
sensors i2c chip drivers (both the module parameters and the in-code
address lists). I think it was a very good move, as the ranges can
easily be replaced by individual addresses, and this allowed for
significant cleaups in the i2c core (let alone the impressive size
shrink for all these drivers).

Unfortunately you did not do the same for non-sensors i2c chip drivers.
These need the address ranges even less, so we could get rid of the
ranges here as well for another significant i2c core cleanup. Here comes
a patch which does just that. Since the process is exactly the same as
what you did for the other drivers set already, I did not split this one
in parts.

A documentation update is included.

The change saves 308 bytes in the i2c core, and an average 1382 bytes
for chip drivers which use I2C_CLIENT_INSMOD, 126 bytes for those which
do not.

This change is required if we want to merge the sensors and non-sensors
i2c code (and we want to do this).

Please apply,
thanks.

diff -ruN linux-2.6.12-rc1-bk5.orig/Documentation/i2c/writing-clients linux-2.6.12-rc1-bk5/Documentation/i2c/writing-clients
--- linux-2.6.12-rc1-bk5.orig/Documentation/i2c/writing-clients	Thu Mar 31 14:28:40 2005
+++ linux-2.6.12-rc1-bk5/Documentation/i2c/writing-clients	Thu Mar 31 14:42:46 2005
@@ -171,45 +171,31 @@
 
   normal_i2c: filled in by the module writer. 
      A list of I2C addresses which should normally be examined.
-   normal_i2c_range: filled in by the module writer.
-     A list of pairs of I2C addresses, each pair being an inclusive range of
-     addresses which should normally be examined.
    probe: insmod parameter. 
      A list of pairs. The first value is a bus number (-1 for any I2C bus), 
      the second is the address. These addresses are also probed, as if they 
      were in the 'normal' list.
-   probe_range: insmod parameter. 
-     A list of triples. The first value is a bus number (-1 for any I2C bus), 
-     the second and third are addresses.  These form an inclusive range of 
-     addresses that are also probed, as if they were in the 'normal' list.
    ignore: insmod parameter.
      A list of pairs. The first value is a bus number (-1 for any I2C bus), 
      the second is the I2C address. These addresses are never probed. 
      This parameter overrules 'normal' and 'probe', but not the 'force' lists.
-   ignore_range: insmod parameter. 
-     A list of triples. The first value is a bus number (-1 for any I2C bus), 
-     the second and third are addresses. These form an inclusive range of 
-     I2C addresses that are never probed.
-     This parameter overrules 'normal' and 'probe', but not the 'force' lists.
    force: insmod parameter. 
      A list of pairs. The first value is a bus number (-1 for any I2C bus),
      the second is the I2C address. A device is blindly assumed to be on
      the given address, no probing is done. 
 
-Fortunately, as a module writer, you just have to define the `normal' 
-and/or `normal_range' parameters. The complete declaration could look
-like this:
-
-  /* Scan 0x20 to 0x2f, 0x37, and 0x40 to 0x4f */
-  static unsigned short normal_i2c[] = { 0x37,I2C_CLIENT_END }; 
-  static unsigned short normal_i2c_range[] = { 0x20, 0x2f, 0x40, 0x4f, 
-                                               I2C_CLIENT_END };
+Fortunately, as a module writer, you just have to define the `normal_i2c' 
+parameter. The complete declaration could look like this:
+
+  /* Scan 0x37, and 0x48 to 0x4f */
+  static unsigned short normal_i2c[] = { 0x37, 0x48, 0x49, 0x4a, 0x4b, 0x4c,
+                                         0x4d, 0x4e, 0x4f, I2C_CLIENT_END };
 
   /* Magic definition of all other variables and things */
   I2C_CLIENT_INSMOD;
 
-Note that you *have* to call the two defined variables `normal_i2c' and
-`normal_i2c_range', without any prefix!
+Note that you *have* to call the defined variable `normal_i2c',
+without any prefix!
 
 
 Probing classes (sensors)
@@ -223,39 +209,17 @@
 
    normal_i2c: filled in by the module writer. Terminated by SENSORS_I2C_END.
      A list of I2C addresses which should normally be examined.
-   normal_i2c_range: filled in by the module writer. Terminated by 
-     SENSORS_I2C_END
-     A list of pairs of I2C addresses, each pair being an inclusive range of
-     addresses which should normally be examined.
    normal_isa: filled in by the module writer. Terminated by SENSORS_ISA_END.
      A list of ISA addresses which should normally be examined.
-   normal_isa_range: filled in by the module writer. Terminated by 
-     SENSORS_ISA_END
-     A list of triples. The first two elements are ISA addresses, being an
-     range of addresses which should normally be examined. The third is the
-     modulo parameter: only addresses which are 0 module this value relative
-     to the first address of the range are actually considered.
    probe: insmod parameter. Initialize this list with SENSORS_I2C_END values.
      A list of pairs. The first value is a bus number (SENSORS_ISA_BUS for
      the ISA bus, -1 for any I2C bus), the second is the address. These
      addresses are also probed, as if they were in the 'normal' list.
-   probe_range: insmod parameter. Initialize this list with SENSORS_I2C_END 
-     values.
-     A list of triples. The first value is a bus number (SENSORS_ISA_BUS for
-     the ISA bus, -1 for any I2C bus), the second and third are addresses. 
-     These form an inclusive range of addresses that are also probed, as
-     if they were in the 'normal' list.
    ignore: insmod parameter. Initialize this list with SENSORS_I2C_END values.
      A list of pairs. The first value is a bus number (SENSORS_ISA_BUS for
      the ISA bus, -1 for any I2C bus), the second is the I2C address. These
      addresses are never probed. This parameter overrules 'normal' and 
      'probe', but not the 'force' lists.
-   ignore_range: insmod parameter. Initialize this list with SENSORS_I2C_END 
-      values.
-     A list of triples. The first value is a bus number (SENSORS_ISA_BUS for
-     the ISA bus, -1 for any I2C bus), the second and third are addresses. 
-     These form an inclusive range of I2C addresses that are never probed.
-     This parameter overrules 'normal' and 'probe', but not the 'force' lists.
 
 Also used is a list of pointers to sensors_force_data structures:
    force_data: insmod parameters. A list, ending with an element of which
@@ -269,16 +233,14 @@
 So we have a generic insmod variabled `force', and chip-specific variables
 `force_CHIPNAME'.
 
-Fortunately, as a module writer, you just have to define the `normal' 
-and/or `normal_range' parameters, and define what chip names are used. 
+Fortunately, as a module writer, you just have to define the `normal_i2c' 
+and `normal_isa' parameters, and define what chip names are used. 
 The complete declaration could look like this:
-  /* Scan i2c addresses 0x20 to 0x2f, 0x37, and 0x40 to 0x4f
-  static unsigned short normal_i2c[] = {0x37,SENSORS_I2C_END};
-  static unsigned short normal_i2c_range[] = {0x20,0x2f,0x40,0x4f,
-                                              SENSORS_I2C_END};
+  /* Scan i2c addresses 0x37, and 0x48 to 0x4f */
+  static unsigned short normal_i2c[] = { 0x37, 0x48, 0x49, 0x4a, 0x4b, 0x4c,
+                                         0x4d, 0x4e, 0x4f, I2C_CLIENT_END };
   /* Scan ISA address 0x290 */
   static unsigned int normal_isa[] = {0x0290,SENSORS_ISA_END};
-  static unsigned int normal_isa_range[] = {SENSORS_ISA_END};
 
   /* Define chips foo and bar, as well as all module parameters and things */
   SENSORS_INSMOD_2(foo,bar);
diff -ruN linux-2.6.12-rc1-bk5.orig/drivers/acorn/char/pcf8583.c linux-2.6.12-rc1-bk5/drivers/acorn/char/pcf8583.c
--- linux-2.6.12-rc1-bk5.orig/drivers/acorn/char/pcf8583.c	Thu Mar 31 14:28:40 2005
+++ linux-2.6.12-rc1-bk5/drivers/acorn/char/pcf8583.c	Thu Mar 31 14:42:46 2005
@@ -26,11 +26,8 @@
 
 static struct i2c_client_address_data addr_data = {
 	.normal_i2c		= normal_addr,
-	.normal_i2c_range	= ignore,
 	.probe			= ignore,
-	.probe_range		= ignore,
 	.ignore			= ignore,
-	.ignore_range		= ignore,
 	.force			= ignore,
 };
 
diff -ruN linux-2.6.12-rc1-bk5.orig/drivers/i2c/chips/isp1301_omap.c linux-2.6.12-rc1-bk5/drivers/i2c/chips/isp1301_omap.c
--- linux-2.6.12-rc1-bk5.orig/drivers/i2c/chips/isp1301_omap.c	Thu Mar 31 14:28:41 2005
+++ linux-2.6.12-rc1-bk5/drivers/i2c/chips/isp1301_omap.c	Thu Mar 31 14:42:46 2005
@@ -145,7 +145,6 @@
 static unsigned short normal_i2c[] = {
 	ISP_BASE, ISP_BASE + 1,
 	I2C_CLIENT_END };
-static unsigned short normal_i2c_range[] = { I2C_CLIENT_END };
 
 I2C_CLIENT_INSMOD;
 
diff -ruN linux-2.6.12-rc1-bk5.orig/drivers/i2c/chips/m41t00.c linux-2.6.12-rc1-bk5/drivers/i2c/chips/m41t00.c
--- linux-2.6.12-rc1-bk5.orig/drivers/i2c/chips/m41t00.c	Thu Mar 31 14:29:46 2005
+++ linux-2.6.12-rc1-bk5/drivers/i2c/chips/m41t00.c	Thu Mar 31 14:49:21 2005
@@ -40,11 +40,8 @@
 
 static struct i2c_client_address_data addr_data = {
 	.normal_i2c		= normal_addr,
-	.normal_i2c_range	= ignore,
 	.probe			= ignore,
-	.probe_range		= ignore,
 	.ignore			= ignore,
-	.ignore_range		= ignore,
 	.force			= ignore,
 };
 
diff -ruN linux-2.6.12-rc1-bk5.orig/drivers/i2c/chips/rtc8564.c linux-2.6.12-rc1-bk5/drivers/i2c/chips/rtc8564.c
--- linux-2.6.12-rc1-bk5.orig/drivers/i2c/chips/rtc8564.c	Thu Mar 31 14:28:41 2005
+++ linux-2.6.12-rc1-bk5/drivers/i2c/chips/rtc8564.c	Thu Mar 31 14:42:46 2005
@@ -66,11 +66,8 @@
 
 static struct i2c_client_address_data addr_data = {
 	.normal_i2c		= normal_addr,
-	.normal_i2c_range	= ignore,
 	.probe			= ignore,
-	.probe_range		= ignore,
 	.ignore			= ignore,
-	.ignore_range		= ignore,
 	.force			= ignore,
 };
 
diff -ruN linux-2.6.12-rc1-bk5.orig/drivers/i2c/i2c-core.c linux-2.6.12-rc1-bk5/drivers/i2c/i2c-core.c
--- linux-2.6.12-rc1-bk5.orig/drivers/i2c/i2c-core.c	Thu Mar 31 14:29:46 2005
+++ linux-2.6.12-rc1-bk5/drivers/i2c/i2c-core.c	Thu Mar 31 14:42:46 2005
@@ -720,18 +720,6 @@
 				found = 1;
 			}
 		}
-		for (i = 0;
-		     !found && (address_data->ignore_range[i] != I2C_CLIENT_END);
-		     i += 3) {
-			if (((adap_id = address_data->ignore_range[i]) ||
-			    ((address_data->ignore_range[i]=ANY_I2C_BUS))) &&
-			    (addr >= address_data->ignore_range[i+1]) &&
-			    (addr <= address_data->ignore_range[i+2])) {
-				dev_dbg(&adapter->dev, "found ignore_range parameter for adapter %d, "
-					"addr %04x\n", adap_id,addr);
-				found = 1;
-			}
-		}
 		if (found) 
 			continue;
 
@@ -748,17 +736,6 @@
 		}
 
 		for (i = 0;
-		     !found && (address_data->normal_i2c_range[i] != I2C_CLIENT_END);
-		     i += 2) {
-			if ((addr >= address_data->normal_i2c_range[i]) &&
-			    (addr <= address_data->normal_i2c_range[i+1])) {
-				found = 1;
-				dev_dbg(&adapter->dev, "found normal i2c_range entry for adapter %d, "
-					"addr %04x\n", adap_id,addr);
-			}
-		}
-
-		for (i = 0;
 		     !found && (address_data->probe[i] != I2C_CLIENT_END);
 		     i += 2) {
 			if (((adap_id = address_data->probe[i]) ||
@@ -766,18 +743,6 @@
 			    (addr = address_data->probe[i+1])) {
 				found = 1;
 				dev_dbg(&adapter->dev, "found probe parameter for adapter %d, "
-					"addr %04x\n", adap_id,addr);
-			}
-		}
-		for (i = 0;
-		     !found && (address_data->probe_range[i] != I2C_CLIENT_END);
-		     i += 3) {
-			if (((adap_id = address_data->probe_range[i]) ||
-			   (address_data->probe_range[i] = ANY_I2C_BUS)) &&
-			   (addr >= address_data->probe_range[i+1]) &&
-			   (addr <= address_data->probe_range[i+2])) {
-				found = 1;
-				dev_dbg(&adapter->dev, "found probe_range parameter for adapter %d, "
 					"addr %04x\n", adap_id,addr);
 			}
 		}
diff -ruN linux-2.6.12-rc1-bk5.orig/drivers/macintosh/therm_windtunnel.c linux-2.6.12-rc1-bk5/drivers/macintosh/therm_windtunnel.c
--- linux-2.6.12-rc1-bk5.orig/drivers/macintosh/therm_windtunnel.c	Thu Mar 31 14:28:41 2005
+++ linux-2.6.12-rc1-bk5/drivers/macintosh/therm_windtunnel.c	Thu Mar 31 14:42:46 2005
@@ -51,8 +51,10 @@
 static int 			do_probe( struct i2c_adapter *adapter, int addr, int kind);
 
 /* scan 0x48-0x4f (DS1775) and 0x2c-2x2f (ADM1030) */
-static unsigned short		normal_i2c[] = { 0x49, 0x2c, I2C_CLIENT_END };
-static unsigned short		normal_i2c_range[] = { 0x48, 0x4f, 0x2c, 0x2f, I2C_CLIENT_END };
+static unsigned short		normal_i2c[] = { 0x48, 0x49, 0x4a, 0x4b,
+						 0x4c, 0x4d, 0x4e, 0x4f,
+						 0x2c, 0x2d, 0x2e, 0x2f,
+						 I2C_CLIENT_END };
 
 I2C_CLIENT_INSMOD;
 
diff -ruN linux-2.6.12-rc1-bk5.orig/drivers/media/video/adv7170.c linux-2.6.12-rc1-bk5/drivers/media/video/adv7170.c
--- linux-2.6.12-rc1-bk5.orig/drivers/media/video/adv7170.c	Thu Mar 31 14:28:41 2005
+++ linux-2.6.12-rc1-bk5/drivers/media/video/adv7170.c	Thu Mar 31 14:42:46 2005
@@ -384,21 +384,15 @@
 	I2C_ADV7171 >> 1, (I2C_ADV7171 >> 1) + 1,
 	I2C_CLIENT_END
 };
-static unsigned short normal_i2c_range[] = { I2C_CLIENT_END };
 
 static unsigned short probe[2] = { I2C_CLIENT_END, I2C_CLIENT_END };
-static unsigned short probe_range[2] = { I2C_CLIENT_END, I2C_CLIENT_END };
 static unsigned short ignore[2] = { I2C_CLIENT_END, I2C_CLIENT_END };
-static unsigned short ignore_range[2] = { I2C_CLIENT_END, I2C_CLIENT_END };
 static unsigned short force[2] = { I2C_CLIENT_END , I2C_CLIENT_END };
                                                                                 
 static struct i2c_client_address_data addr_data = {
 	.normal_i2c		= normal_i2c,
-	.normal_i2c_range	= normal_i2c_range,
 	.probe			= probe,
-	.probe_range		= probe_range,
 	.ignore			= ignore,
-	.ignore_range		= ignore_range,
 	.force			= force
 };
 
diff -ruN linux-2.6.12-rc1-bk5.orig/drivers/media/video/adv7175.c linux-2.6.12-rc1-bk5/drivers/media/video/adv7175.c
--- linux-2.6.12-rc1-bk5.orig/drivers/media/video/adv7175.c	Thu Mar 31 14:28:41 2005
+++ linux-2.6.12-rc1-bk5/drivers/media/video/adv7175.c	Thu Mar 31 14:42:46 2005
@@ -434,21 +434,15 @@
 	I2C_ADV7176 >> 1, (I2C_ADV7176 >> 1) + 1,
 	I2C_CLIENT_END
 };
-static unsigned short normal_i2c_range[] = { I2C_CLIENT_END };
 
 static unsigned short probe[2] = { I2C_CLIENT_END, I2C_CLIENT_END };
-static unsigned short probe_range[2] = { I2C_CLIENT_END, I2C_CLIENT_END };
 static unsigned short ignore[2] = { I2C_CLIENT_END, I2C_CLIENT_END };
-static unsigned short ignore_range[2] = { I2C_CLIENT_END, I2C_CLIENT_END };
 static unsigned short force[2] = { I2C_CLIENT_END , I2C_CLIENT_END };
                                                                                 
 static struct i2c_client_address_data addr_data = {
 	.normal_i2c		= normal_i2c,
-	.normal_i2c_range	= normal_i2c_range,
 	.probe			= probe,
-	.probe_range		= probe_range,
 	.ignore			= ignore,
-	.ignore_range		= ignore_range,
 	.force			= force
 };
 
diff -ruN linux-2.6.12-rc1-bk5.orig/drivers/media/video/bt819.c linux-2.6.12-rc1-bk5/drivers/media/video/bt819.c
--- linux-2.6.12-rc1-bk5.orig/drivers/media/video/bt819.c	Thu Mar 31 14:29:47 2005
+++ linux-2.6.12-rc1-bk5/drivers/media/video/bt819.c	Thu Mar 31 14:42:46 2005
@@ -500,21 +500,15 @@
 	I2C_BT819 >> 1,
 	I2C_CLIENT_END,
 };
-static unsigned short normal_i2c_range[] = { I2C_CLIENT_END };
 
 static unsigned short probe[2] = { I2C_CLIENT_END, I2C_CLIENT_END };
-static unsigned short probe_range[2] = { I2C_CLIENT_END, I2C_CLIENT_END };
 static unsigned short ignore[2] = { I2C_CLIENT_END, I2C_CLIENT_END };
-static unsigned short ignore_range[2] = { I2C_CLIENT_END, I2C_CLIENT_END };
 static unsigned short force[2] = { I2C_CLIENT_END , I2C_CLIENT_END };
                                                                                 
 static struct i2c_client_address_data addr_data = {
 	.normal_i2c		= normal_i2c,
-	.normal_i2c_range	= normal_i2c_range,
 	.probe			= probe,
-	.probe_range		= probe_range,
 	.ignore			= ignore,
-	.ignore_range		= ignore_range,
 	.force			= force
 };
 
diff -ruN linux-2.6.12-rc1-bk5.orig/drivers/media/video/bt832.c linux-2.6.12-rc1-bk5/drivers/media/video/bt832.c
--- linux-2.6.12-rc1-bk5.orig/drivers/media/video/bt832.c	Fri Dec 24 22:35:23 2004
+++ linux-2.6.12-rc1-bk5/drivers/media/video/bt832.c	Thu Mar 31 14:42:46 2005
@@ -39,8 +39,8 @@
 MODULE_LICENSE("GPL");
 
 /* Addresses to scan */
-static unsigned short normal_i2c[] = {I2C_CLIENT_END};
-static unsigned short normal_i2c_range[] = {I2C_BT832_ALT1>>1,I2C_BT832_ALT2>>1,I2C_CLIENT_END};
+static unsigned short normal_i2c[] = { I2C_BT832_ALT1>>1, I2C_BT832_ALT2>>1,
+				       I2C_CLIENT_END };
 I2C_CLIENT_INSMOD;
 
 /* ---------------------------------------------------------------------- */
diff -ruN linux-2.6.12-rc1-bk5.orig/drivers/media/video/bt856.c linux-2.6.12-rc1-bk5/drivers/media/video/bt856.c
--- linux-2.6.12-rc1-bk5.orig/drivers/media/video/bt856.c	Thu Mar 31 14:28:41 2005
+++ linux-2.6.12-rc1-bk5/drivers/media/video/bt856.c	Thu Mar 31 14:42:46 2005
@@ -288,21 +288,15 @@
  * concerning the addresses: i2c wants 7 bit (without the r/w bit), so '>>1'
  */
 static unsigned short normal_i2c[] = { I2C_BT856 >> 1, I2C_CLIENT_END };
-static unsigned short normal_i2c_range[] = { I2C_CLIENT_END };
 
 static unsigned short probe[2] = { I2C_CLIENT_END, I2C_CLIENT_END };
-static unsigned short probe_range[2] = { I2C_CLIENT_END, I2C_CLIENT_END };
 static unsigned short ignore[2] = { I2C_CLIENT_END, I2C_CLIENT_END };
-static unsigned short ignore_range[2] = { I2C_CLIENT_END, I2C_CLIENT_END };
 static unsigned short force[2] = { I2C_CLIENT_END , I2C_CLIENT_END };
                                                                                 
 static struct i2c_client_address_data addr_data = {
 	.normal_i2c		= normal_i2c,
-	.normal_i2c_range	= normal_i2c_range,
 	.probe			= probe,
-	.probe_range		= probe_range,
 	.ignore			= ignore,
-	.ignore_range		= ignore_range,
 	.force			= force
 };
 
diff -ruN linux-2.6.12-rc1-bk5.orig/drivers/media/video/msp3400.c linux-2.6.12-rc1-bk5/drivers/media/video/msp3400.c
--- linux-2.6.12-rc1-bk5.orig/drivers/media/video/msp3400.c	Thu Mar 31 14:29:47 2005
+++ linux-2.6.12-rc1-bk5/drivers/media/video/msp3400.c	Thu Mar 31 14:42:46 2005
@@ -147,7 +147,6 @@
 	I2C_MSP3400C_ALT  >> 1,
 	I2C_CLIENT_END
 };
-static unsigned short normal_i2c_range[] = {I2C_CLIENT_END,I2C_CLIENT_END};
 I2C_CLIENT_INSMOD;
 
 /* ----------------------------------------------------------------------- */
diff -ruN linux-2.6.12-rc1-bk5.orig/drivers/media/video/saa5246a.c linux-2.6.12-rc1-bk5/drivers/media/video/saa5246a.c
--- linux-2.6.12-rc1-bk5.orig/drivers/media/video/saa5246a.c	Thu Mar 31 14:28:41 2005
+++ linux-2.6.12-rc1-bk5/drivers/media/video/saa5246a.c	Thu Mar 31 14:43:37 2005
@@ -64,7 +64,6 @@
 
 /* Addresses to scan */
 static unsigned short normal_i2c[]	 = { I2C_ADDRESS, I2C_CLIENT_END };
-static unsigned short normal_i2c_range[] = { I2C_CLIENT_END };
 I2C_CLIENT_INSMOD;
 
 static struct i2c_client client_template;
diff -ruN linux-2.6.12-rc1-bk5.orig/drivers/media/video/saa5249.c linux-2.6.12-rc1-bk5/drivers/media/video/saa5249.c
--- linux-2.6.12-rc1-bk5.orig/drivers/media/video/saa5249.c	Thu Mar 31 14:28:41 2005
+++ linux-2.6.12-rc1-bk5/drivers/media/video/saa5249.c	Thu Mar 31 14:43:30 2005
@@ -132,7 +132,6 @@
 
 /* Addresses to scan */
 static unsigned short normal_i2c[] = {34>>1,I2C_CLIENT_END};
-static unsigned short normal_i2c_range[] = {I2C_CLIENT_END};
 I2C_CLIENT_INSMOD;
 
 static struct i2c_client client_template;
diff -ruN linux-2.6.12-rc1-bk5.orig/drivers/media/video/saa7110.c linux-2.6.12-rc1-bk5/drivers/media/video/saa7110.c
--- linux-2.6.12-rc1-bk5.orig/drivers/media/video/saa7110.c	Thu Mar 31 14:28:41 2005
+++ linux-2.6.12-rc1-bk5/drivers/media/video/saa7110.c	Thu Mar 31 14:42:46 2005
@@ -463,21 +463,15 @@
 	(I2C_SAA7110 >> 1) + 1,
 	I2C_CLIENT_END
 };
-static unsigned short normal_i2c_range[] = { I2C_CLIENT_END };
 
 static unsigned short probe[2] = { I2C_CLIENT_END, I2C_CLIENT_END };
-static unsigned short probe_range[2] = { I2C_CLIENT_END, I2C_CLIENT_END };
 static unsigned short ignore[2] = { I2C_CLIENT_END, I2C_CLIENT_END };
-static unsigned short ignore_range[2] = { I2C_CLIENT_END, I2C_CLIENT_END };
 static unsigned short force[2] = { I2C_CLIENT_END , I2C_CLIENT_END };
                                                                                 
 static struct i2c_client_address_data addr_data = {
 	.normal_i2c		= normal_i2c,
-	.normal_i2c_range	= normal_i2c_range,
 	.probe			= probe,
-	.probe_range		= probe_range,
 	.ignore			= ignore,
-	.ignore_range		= ignore_range,
 	.force			= force
 };
 
diff -ruN linux-2.6.12-rc1-bk5.orig/drivers/media/video/saa7111.c linux-2.6.12-rc1-bk5/drivers/media/video/saa7111.c
--- linux-2.6.12-rc1-bk5.orig/drivers/media/video/saa7111.c	Thu Mar 31 14:28:41 2005
+++ linux-2.6.12-rc1-bk5/drivers/media/video/saa7111.c	Thu Mar 31 14:42:46 2005
@@ -482,21 +482,15 @@
  * concerning the addresses: i2c wants 7 bit (without the r/w bit), so '>>1'
  */
 static unsigned short normal_i2c[] = { I2C_SAA7111 >> 1, I2C_CLIENT_END };
-static unsigned short normal_i2c_range[] = { I2C_CLIENT_END };
 
 static unsigned short probe[2] = { I2C_CLIENT_END, I2C_CLIENT_END };
-static unsigned short probe_range[2] = { I2C_CLIENT_END, I2C_CLIENT_END };
 static unsigned short ignore[2] = { I2C_CLIENT_END, I2C_CLIENT_END };
-static unsigned short ignore_range[2] = { I2C_CLIENT_END, I2C_CLIENT_END };
 static unsigned short force[2] = { I2C_CLIENT_END , I2C_CLIENT_END };
                                                                                 
 static struct i2c_client_address_data addr_data = {
 	.normal_i2c		= normal_i2c,
-	.normal_i2c_range	= normal_i2c_range,
 	.probe			= probe,
-	.probe_range		= probe_range,
 	.ignore			= ignore,
-	.ignore_range		= ignore_range,
 	.force			= force
 };
 
diff -ruN linux-2.6.12-rc1-bk5.orig/drivers/media/video/saa7114.c linux-2.6.12-rc1-bk5/drivers/media/video/saa7114.c
--- linux-2.6.12-rc1-bk5.orig/drivers/media/video/saa7114.c	Thu Mar 31 14:28:41 2005
+++ linux-2.6.12-rc1-bk5/drivers/media/video/saa7114.c	Thu Mar 31 14:42:46 2005
@@ -820,21 +820,15 @@
  */
 static unsigned short normal_i2c[]      { I2C_SAA7114 >> 1, I2C_SAA7114A >> 1, I2C_CLIENT_END };
-static unsigned short normal_i2c_range[] = { I2C_CLIENT_END };
 
 static unsigned short probe[2] = { I2C_CLIENT_END, I2C_CLIENT_END };
-static unsigned short probe_range[2] = { I2C_CLIENT_END, I2C_CLIENT_END };
 static unsigned short ignore[2] = { I2C_CLIENT_END, I2C_CLIENT_END };
-static unsigned short ignore_range[2] = { I2C_CLIENT_END, I2C_CLIENT_END };
 static unsigned short force[2] = { I2C_CLIENT_END , I2C_CLIENT_END };
                                                                                 
 static struct i2c_client_address_data addr_data = {
 	.normal_i2c		= normal_i2c,
-	.normal_i2c_range	= normal_i2c_range,
 	.probe			= probe,
-	.probe_range		= probe_range,
 	.ignore			= ignore,
-	.ignore_range		= ignore_range,
 	.force			= force
 };
 
diff -ruN linux-2.6.12-rc1-bk5.orig/drivers/media/video/saa7134/saa6752hs.c linux-2.6.12-rc1-bk5/drivers/media/video/saa7134/saa6752hs.c
--- linux-2.6.12-rc1-bk5.orig/drivers/media/video/saa7134/saa6752hs.c	Thu Mar 31 14:28:41 2005
+++ linux-2.6.12-rc1-bk5/drivers/media/video/saa7134/saa6752hs.c	Thu Mar 31 14:42:46 2005
@@ -22,7 +22,6 @@
 
 /* Addresses to scan */
 static unsigned short normal_i2c[] = {0x20, I2C_CLIENT_END};
-static unsigned short normal_i2c_range[] = {I2C_CLIENT_END};
 I2C_CLIENT_INSMOD;
 
 MODULE_DESCRIPTION("device driver for saa6752hs MPEG2 encoder");
diff -ruN linux-2.6.12-rc1-bk5.orig/drivers/media/video/saa7185.c linux-2.6.12-rc1-bk5/drivers/media/video/saa7185.c
--- linux-2.6.12-rc1-bk5.orig/drivers/media/video/saa7185.c	Thu Mar 31 14:28:41 2005
+++ linux-2.6.12-rc1-bk5/drivers/media/video/saa7185.c	Thu Mar 31 14:42:46 2005
@@ -380,21 +380,15 @@
  * concerning the addresses: i2c wants 7 bit (without the r/w bit), so '>>1'
  */
 static unsigned short normal_i2c[] = { I2C_SAA7185 >> 1, I2C_CLIENT_END };
-static unsigned short normal_i2c_range[] = { I2C_CLIENT_END };
 
 static unsigned short probe[2] = { I2C_CLIENT_END, I2C_CLIENT_END };
-static unsigned short probe_range[2] = { I2C_CLIENT_END, I2C_CLIENT_END };
 static unsigned short ignore[2] = { I2C_CLIENT_END, I2C_CLIENT_END };
-static unsigned short ignore_range[2] = { I2C_CLIENT_END, I2C_CLIENT_END };
 static unsigned short force[2] = { I2C_CLIENT_END , I2C_CLIENT_END };
                                                                                 
 static struct i2c_client_address_data addr_data = {
 	.normal_i2c		= normal_i2c,
-	.normal_i2c_range	= normal_i2c_range,
 	.probe			= probe,
-	.probe_range		= probe_range,
 	.ignore			= ignore,
-	.ignore_range		= ignore_range,
 	.force			= force
 };
 
diff -ruN linux-2.6.12-rc1-bk5.orig/drivers/media/video/tda7432.c linux-2.6.12-rc1-bk5/drivers/media/video/tda7432.c
--- linux-2.6.12-rc1-bk5.orig/drivers/media/video/tda7432.c	Thu Mar 31 14:28:41 2005
+++ linux-2.6.12-rc1-bk5/drivers/media/video/tda7432.c	Thu Mar 31 14:42:46 2005
@@ -74,7 +74,6 @@
 	I2C_TDA7432 >> 1,
 	I2C_CLIENT_END,
 };
-static unsigned short normal_i2c_range[] = { I2C_CLIENT_END, I2C_CLIENT_END };
 I2C_CLIENT_INSMOD;
 
 /* Structure of address and subaddresses for the tda7432 */
diff -ruN linux-2.6.12-rc1-bk5.orig/drivers/media/video/tda9840.c linux-2.6.12-rc1-bk5/drivers/media/video/tda9840.c
--- linux-2.6.12-rc1-bk5.orig/drivers/media/video/tda9840.c	Thu Mar 31 14:28:41 2005
+++ linux-2.6.12-rc1-bk5/drivers/media/video/tda9840.c	Thu Mar 31 14:42:46 2005
@@ -43,7 +43,6 @@
 
 /* addresses to scan, found only at 0x42 (7-Bit) */
 static unsigned short normal_i2c[] = { I2C_TDA9840, I2C_CLIENT_END };
-static unsigned short normal_i2c_range[] = { I2C_CLIENT_END };
 
 /* magic definition of all other variables and things */
 I2C_CLIENT_INSMOD;
diff -ruN linux-2.6.12-rc1-bk5.orig/drivers/media/video/tda9875.c linux-2.6.12-rc1-bk5/drivers/media/video/tda9875.c
--- linux-2.6.12-rc1-bk5.orig/drivers/media/video/tda9875.c	Thu Mar 31 14:28:41 2005
+++ linux-2.6.12-rc1-bk5/drivers/media/video/tda9875.c	Thu Mar 31 14:42:46 2005
@@ -44,7 +44,6 @@
     I2C_TDA9875 >> 1,
     I2C_CLIENT_END
 };
-static unsigned short normal_i2c_range[] = {I2C_CLIENT_END};
 I2C_CLIENT_INSMOD;
 
 /* This is a superset of the TDA9875 */
diff -ruN linux-2.6.12-rc1-bk5.orig/drivers/media/video/tda9887.c linux-2.6.12-rc1-bk5/drivers/media/video/tda9887.c
--- linux-2.6.12-rc1-bk5.orig/drivers/media/video/tda9887.c	Thu Mar 31 14:29:47 2005
+++ linux-2.6.12-rc1-bk5/drivers/media/video/tda9887.c	Thu Mar 31 14:42:46 2005
@@ -33,7 +33,6 @@
 	0x96 >>1,
 	I2C_CLIENT_END,
 };
-static unsigned short normal_i2c_range[] = {I2C_CLIENT_END,I2C_CLIENT_END};
 I2C_CLIENT_INSMOD;
 
 /* insmod options */
diff -ruN linux-2.6.12-rc1-bk5.orig/drivers/media/video/tea6415c.c linux-2.6.12-rc1-bk5/drivers/media/video/tea6415c.c
--- linux-2.6.12-rc1-bk5.orig/drivers/media/video/tea6415c.c	Thu Mar 31 14:28:41 2005
+++ linux-2.6.12-rc1-bk5/drivers/media/video/tea6415c.c	Thu Mar 31 14:42:46 2005
@@ -43,7 +43,6 @@
 
 /* addresses to scan, found only at 0x03 and/or 0x43 (7-bit) */
 static unsigned short normal_i2c[] = { I2C_TEA6415C_1, I2C_TEA6415C_2, I2C_CLIENT_END };
-static unsigned short normal_i2c_range[] = { I2C_CLIENT_END };
 
 /* magic definition of all other variables and things */
 I2C_CLIENT_INSMOD;
diff -ruN linux-2.6.12-rc1-bk5.orig/drivers/media/video/tea6420.c linux-2.6.12-rc1-bk5/drivers/media/video/tea6420.c
--- linux-2.6.12-rc1-bk5.orig/drivers/media/video/tea6420.c	Thu Mar 31 14:28:41 2005
+++ linux-2.6.12-rc1-bk5/drivers/media/video/tea6420.c	Thu Mar 31 14:42:46 2005
@@ -40,7 +40,6 @@
 
 /* addresses to scan, found only at 0x4c and/or 0x4d (7-Bit) */
 static unsigned short normal_i2c[] = { I2C_TEA6420_1, I2C_TEA6420_2, I2C_CLIENT_END };
-static unsigned short normal_i2c_range[] = { I2C_CLIENT_END };
 
 /* magic definition of all other variables and things */
 I2C_CLIENT_INSMOD;
diff -ruN linux-2.6.12-rc1-bk5.orig/drivers/media/video/tuner-3036.c linux-2.6.12-rc1-bk5/drivers/media/video/tuner-3036.c
--- linux-2.6.12-rc1-bk5.orig/drivers/media/video/tuner-3036.c	Thu Mar 31 14:28:41 2005
+++ linux-2.6.12-rc1-bk5/drivers/media/video/tuner-3036.c	Thu Mar 31 14:42:46 2005
@@ -34,19 +34,16 @@
 static struct i2c_client client_template;
 
 /* Addresses to scan */
-static unsigned short normal_i2c[] = {I2C_CLIENT_END};
-static unsigned short normal_i2c_range[] = {0x60, 0x61, I2C_CLIENT_END};
+static unsigned short normal_i2c[] = { 0x60, 0x61, I2C_CLIENT_END };
 static unsigned short probe[2]        = { I2C_CLIENT_END, I2C_CLIENT_END };
-static unsigned short probe_range[2]  = { I2C_CLIENT_END, I2C_CLIENT_END };
 static unsigned short ignore[2]       = { I2C_CLIENT_END, I2C_CLIENT_END };
-static unsigned short ignore_range[2] = { I2C_CLIENT_END, I2C_CLIENT_END };
 static unsigned short force[2]        = { I2C_CLIENT_END, I2C_CLIENT_END };
 
 static struct i2c_client_address_data addr_data = {
-	normal_i2c, normal_i2c_range, 
-	probe, probe_range, 
-	ignore, ignore_range, 
-	force
+	.normal_i2c	= normal_i2c,
+	.probe		= probe,
+	.ignore		= ignore,
+	.force		= force,
 };
 
 /* ---------------------------------------------------------------------- */
diff -ruN linux-2.6.12-rc1-bk5.orig/drivers/media/video/tuner-core.c linux-2.6.12-rc1-bk5/drivers/media/video/tuner-core.c
--- linux-2.6.12-rc1-bk5.orig/drivers/media/video/tuner-core.c	Thu Mar 31 14:29:47 2005
+++ linux-2.6.12-rc1-bk5/drivers/media/video/tuner-core.c	Thu Mar 31 14:55:17 2005
@@ -28,10 +28,8 @@
 /* standard i2c insmod options */
 static unsigned short normal_i2c[] = {
 	0x4b, /* tda8290 */
-	I2C_CLIENT_END
-};
-static unsigned short normal_i2c_range[] = {
-	0x60, 0x6f,
+	0x60, 0x61, 0x62, 0x63, 0x64, 0x65, 0x66, 0x67,
+	0x68, 0x69, 0x6a, 0x6b, 0x6c, 0x6d, 0x6e, 0x6f,
 	I2C_CLIENT_END
 };
 I2C_CLIENT_INSMOD;
@@ -225,9 +223,8 @@
 static int tuner_probe(struct i2c_adapter *adap)
 {
 	if (0 != addr) {
-		normal_i2c[0]       = addr;
-		normal_i2c_range[0] = addr;
-		normal_i2c_range[1] = addr;
+		normal_i2c[0] = addr;
+		normal_i2c[1] = I2C_CLIENT_END;
 	}
 	this_adap = 0;
 
diff -ruN linux-2.6.12-rc1-bk5.orig/drivers/media/video/tvaudio.c linux-2.6.12-rc1-bk5/drivers/media/video/tvaudio.c
--- linux-2.6.12-rc1-bk5.orig/drivers/media/video/tvaudio.c	Thu Mar 31 14:29:47 2005
+++ linux-2.6.12-rc1-bk5/drivers/media/video/tvaudio.c	Thu Mar 31 14:42:49 2005
@@ -148,7 +148,6 @@
 	I2C_TDA9874   >> 1,
 	I2C_PIC16C54  >> 1,
 	I2C_CLIENT_END };
-static unsigned short normal_i2c_range[2] = { I2C_CLIENT_END, I2C_CLIENT_END };
 I2C_CLIENT_INSMOD;
 
 static struct i2c_driver driver;
diff -ruN linux-2.6.12-rc1-bk5.orig/drivers/media/video/tveeprom.c linux-2.6.12-rc1-bk5/drivers/media/video/tveeprom.c
--- linux-2.6.12-rc1-bk5.orig/drivers/media/video/tveeprom.c	Thu Mar 31 14:28:41 2005
+++ linux-2.6.12-rc1-bk5/drivers/media/video/tveeprom.c	Thu Mar 31 14:49:09 2005
@@ -482,7 +482,6 @@
 	0xa0 >> 1,
 	I2C_CLIENT_END,
 };
-static unsigned short normal_i2c_range[] = { I2C_CLIENT_END };
 I2C_CLIENT_INSMOD;
 
 struct i2c_driver i2c_driver_tveeprom;
diff -ruN linux-2.6.12-rc1-bk5.orig/drivers/media/video/vpx3220.c linux-2.6.12-rc1-bk5/drivers/media/video/vpx3220.c
--- linux-2.6.12-rc1-bk5.orig/drivers/media/video/vpx3220.c	Thu Mar 31 14:28:41 2005
+++ linux-2.6.12-rc1-bk5/drivers/media/video/vpx3220.c	Thu Mar 31 14:42:49 2005
@@ -569,21 +569,15 @@
     { I2C_VPX3220 >> 1, (I2C_VPX3220 >> 1) + 4,
 	I2C_CLIENT_END
 };
-static unsigned short normal_i2c_range[] = { I2C_CLIENT_END };
 
 static unsigned short probe[2] = { I2C_CLIENT_END, I2C_CLIENT_END };
-static unsigned short probe_range[2] = { I2C_CLIENT_END, I2C_CLIENT_END };
 static unsigned short ignore[2] = { I2C_CLIENT_END, I2C_CLIENT_END };
-static unsigned short ignore_range[2] = { I2C_CLIENT_END, I2C_CLIENT_END };
 static unsigned short force[2] = { I2C_CLIENT_END , I2C_CLIENT_END };
                                                                                 
 static struct i2c_client_address_data addr_data = {
 	.normal_i2c		= normal_i2c,
-	.normal_i2c_range	= normal_i2c_range,
 	.probe			= probe,
-	.probe_range		= probe_range,
 	.ignore			= ignore,
-	.ignore_range		= ignore_range,
 	.force			= force
 };
 
diff -ruN linux-2.6.12-rc1-bk5.orig/drivers/video/matrox/matroxfb_maven.c linux-2.6.12-rc1-bk5/drivers/video/matrox/matroxfb_maven.c
--- linux-2.6.12-rc1-bk5.orig/drivers/video/matrox/matroxfb_maven.c	Fri Dec 24 22:33:48 2004
+++ linux-2.6.12-rc1-bk5/drivers/video/matrox/matroxfb_maven.c	Thu Mar 31 14:42:49 2005
@@ -1230,7 +1230,6 @@
 }
 
 static unsigned short normal_i2c[] = { MAVEN_I2CID, I2C_CLIENT_END };
-static unsigned short normal_i2c_range[] = { MAVEN_I2CID, MAVEN_I2CID, I2C_CLIENT_END };
 I2C_CLIENT_INSMOD;
 
 static struct i2c_driver maven_driver;
diff -ruN linux-2.6.12-rc1-bk5.orig/include/linux/i2c.h linux-2.6.12-rc1-bk5/include/linux/i2c.h
--- linux-2.6.12-rc1-bk5.orig/include/linux/i2c.h	Thu Mar 31 14:29:48 2005
+++ linux-2.6.12-rc1-bk5/include/linux/i2c.h	Thu Mar 31 14:42:49 2005
@@ -290,11 +290,8 @@
  */
 struct i2c_client_address_data {
 	unsigned short *normal_i2c;
-	unsigned short *normal_i2c_range;
 	unsigned short *probe;
-	unsigned short *probe_range;
 	unsigned short *ignore;
-	unsigned short *ignore_range;
 	unsigned short *force;
 };
 
@@ -563,24 +560,15 @@
 #define I2C_CLIENT_INSMOD \
   I2C_CLIENT_MODULE_PARM(probe, \
                       "List of adapter,address pairs to scan additionally"); \
-  I2C_CLIENT_MODULE_PARM(probe_range, \
-                      "List of adapter,start-addr,end-addr triples to scan " \
-                      "additionally"); \
   I2C_CLIENT_MODULE_PARM(ignore, \
                       "List of adapter,address pairs not to scan"); \
-  I2C_CLIENT_MODULE_PARM(ignore_range, \
-                      "List of adapter,start-addr,end-addr triples not to " \
-                      "scan"); \
   I2C_CLIENT_MODULE_PARM(force, \
                       "List of adapter,address pairs to boldly assume " \
                       "to be present"); \
 	static struct i2c_client_address_data addr_data = {		\
 			.normal_i2c = 		normal_i2c,		\
-			.normal_i2c_range =	normal_i2c_range,	\
 			.probe =		probe,			\
-			.probe_range =		probe_range,		\
 			.ignore =		ignore,			\
-			.ignore_range =		ignore_range,		\
 			.force =		force,			\
 		}
 


-- 
Jean Delvare
