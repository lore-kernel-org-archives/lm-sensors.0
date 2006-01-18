From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 18 Jan 2006 21:39:48 +0000
Subject: [lm-sensors] [PATCH 01/17] hwmon: Fix reboot on it87 driver load
Message-Id: <20060118223948.16bd611a.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Content-Disposition: inline; filename=hwmon-it87-probe-i2c-0x2d-only.patch

Only scan I2C address 0x2d. This is the default address and no IT87xxF
chip was ever seen on I2C at a different address. These chips are
better accessed through their ISA interface anyway.

This fixes bug #5889, although it doesn't address the whole class
of problems. We'd need the ability to blacklist arbitrary I2C addresses
on systems known to contain I2C devices which behave badly when probed.

Plan the I2C interface for removal as well. If nobody complains within
a year, it will confirm my impression that the I2C interface isn't
actually needed by anyone.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
---
 Documentation/feature-removal-schedule.txt |    9 +++++++++
 Documentation/hwmon/it87                   |    2 +-
 drivers/hwmon/it87.c                       |    8 ++++++--
 3 files changed, 16 insertions(+), 3 deletions(-)

--- linux-2.6.16-rc1.orig/Documentation/hwmon/it87	2006-01-18 18:23:01.000000000 +0100
+++ linux-2.6.16-rc1/Documentation/hwmon/it87	2006-01-18 19:54:16.000000000 +0100
@@ -9,7 +9,7 @@
                http://www.ite.com.tw/
   * IT8712F
     Prefix: 'it8712'
-    Addresses scanned: I2C 0x28 - 0x2f
+    Addresses scanned: I2C 0x2d
                        from Super I/O config space (8 I/O ports)
     Datasheet: Publicly available at the ITE website
                http://www.ite.com.tw/
--- linux-2.6.16-rc1.orig/drivers/hwmon/it87.c	2006-01-18 18:28:57.000000000 +0100
+++ linux-2.6.16-rc1/drivers/hwmon/it87.c	2006-01-18 19:54:16.000000000 +0100
@@ -45,8 +45,7 @@
 
 
 /* Addresses to scan */
-static unsigned short normal_i2c[] = { 0x28, 0x29, 0x2a, 0x2b, 0x2c, 0x2d,
-					0x2e, 0x2f, I2C_CLIENT_END };
+static unsigned short normal_i2c[] = { 0x2d, I2C_CLIENT_END };
 static unsigned short isa_address;
 
 /* Insmod parameters */
@@ -830,6 +829,11 @@
 	if ((err = i2c_attach_client(new_client)))
 		goto ERROR2;
 
+	if (!is_isa)
+		dev_info(&new_client->dev, "The I2C interface to IT87xxF "
+			 "hardware monitoring chips is deprecated. Please "
+			 "report if you still rely on it.\n");
+
 	/* Check PWM configuration */
 	enable_pwm_interface = it87_check_pwm(new_client);
 
--- linux-2.6.16-rc1.orig/Documentation/feature-removal-schedule.txt	2006-01-18 18:28:38.000000000 +0100
+++ linux-2.6.16-rc1/Documentation/feature-removal-schedule.txt	2006-01-18 19:54:16.000000000 +0100
@@ -148,3 +148,12 @@
 	brother on Alchemy SOCs.  The loss of features is not considered an
 	issue.
 Who:	Ralf Baechle <ralf at linux-mips.org>
+
+---------------------------
+
+What:	I2C interface of the it87 driver
+When:	January 2007
+Why:	The ISA interface is faster and should be always available. The I2C
+	probing is also known to cause trouble in at least one case (see
+	bug #5889.)
+Who:	Jean Delvare <khali at linux-fr.org>

-- 
Jean Delvare

