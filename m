From: gregkh@suse.de (gregkh@suse.de)
Date: Thu, 19 Jan 2006 00:44:35 +0000
Subject: [lm-sensors] patch hwmon-it87-probe-i2c-0x2d-only.patch added to
Message-Id: <1EzNul-0MP-00@press.kroah.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


This is a note to let you know that I've just added the patch titled

     Subject: [PATCH 01/17] hwmon: Fix reboot on it87 driver load

to my gregkh-2.6 tree.  Its filename is

     hwmon-it87-probe-i2c-0x2d-only.patch

This tree can be found at 
    http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/


From khali at linux-fr.org Wed Jan 18 13:39:09 2006
Date: Wed, 18 Jan 2006 22:39:48 +0100
From: Jean Delvare <khali at linux-fr.org>
To: Greg KH <greg at kroah.com>
Cc: LM Sensors <lm-sensors at lm-sensors.org>, dragoran at feuerpokemon.de
Subject: [PATCH 01/17] hwmon: Fix reboot on it87 driver load
Message-Id: <20060118223948.16bd611a.khali at linux-fr.org>
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
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>
---
 Documentation/feature-removal-schedule.txt |    9 +++++++++
 Documentation/hwmon/it87                   |    2 +-
 drivers/hwmon/it87.c                       |    8 ++++++--
 3 files changed, 16 insertions(+), 3 deletions(-)

--- gregkh-2.6.orig/Documentation/hwmon/it87
+++ gregkh-2.6/Documentation/hwmon/it87
@@ -9,7 +9,7 @@ Supported chips:
                http://www.ite.com.tw/
   * IT8712F
     Prefix: 'it8712'
-    Addresses scanned: I2C 0x28 - 0x2f
+    Addresses scanned: I2C 0x2d
                        from Super I/O config space (8 I/O ports)
     Datasheet: Publicly available at the ITE website
                http://www.ite.com.tw/
--- gregkh-2.6.orig/drivers/hwmon/it87.c
+++ gregkh-2.6/drivers/hwmon/it87.c
@@ -45,8 +45,7 @@
 
 
 /* Addresses to scan */
-static unsigned short normal_i2c[] = { 0x28, 0x29, 0x2a, 0x2b, 0x2c, 0x2d,
-					0x2e, 0x2f, I2C_CLIENT_END };
+static unsigned short normal_i2c[] = { 0x2d, I2C_CLIENT_END };
 static unsigned short isa_address;
 
 /* Insmod parameters */
@@ -830,6 +829,11 @@ static int it87_detect(struct i2c_adapte
 	if ((err = i2c_attach_client(new_client)))
 		goto ERROR2;
 
+	if (!is_isa)
+		dev_info(&new_client->dev, "The I2C interface to IT87xxF "
+			 "hardware monitoring chips is deprecated. Please "
+			 "report if you still rely on it.\n");
+
 	/* Check PWM configuration */
 	enable_pwm_interface = it87_check_pwm(new_client);
 
--- gregkh-2.6.orig/Documentation/feature-removal-schedule.txt
+++ gregkh-2.6/Documentation/feature-removal-schedule.txt
@@ -148,3 +148,12 @@ Why:	The 8250 serial driver now has the 
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


Patches currently in gregkh-2.6 which might be from khali at linux-fr.org are

i2c/hwmon-allow-sensor-attr-arrays.patch
i2c/hwmon-f71805f-add-documentation.patch
i2c/hwmon-f71805f-new-driver.patch
i2c/hwmon-f71805f-use-attr-arrays.patch
i2c/hwmon-lm77-negative-temp-fix.patch
i2c/hwmon-pc87360-use-attr-arrays.patch
i2c/hwmon-w83792d-inline-register-access-functions.patch
i2c/i2c-algo-sibyte-module-param.patch
i2c/i2c-busses-use-array-size-macro.patch
i2c/i2c-sis96x-rename-documentation.patch
i2c/i2c-resurrect-i2c_smbus_write_i2c_block_data.patch
i2c/hwmon-convert-semaphores-to-mutexes.patch
i2c/hwmon-f71805f-convert-semaphore-to-mutex.patch
i2c/hwmon-it87-probe-i2c-0x2d-only.patch
i2c/hwmon-sensor-attr-array-2.patch
i2c/hwmon-w83627hf-add-w83687thf-support.patch
i2c/hwmon-w83792d-drop-useless-macros.patch
i2c/hwmon-w83792d-use-attr-arrays.patch
i2c/i2c-convert-semaphores-to-mutexes-2.patch
i2c/i2c-convert-semaphores-to-mutexes-3.patch
i2c/i2c-scx200_acb-01-whitespace.patch
i2c/i2c-scx200_acb-02-debug.patch
i2c/i2c-scx200_acb-03-refactor.patch
i2c/i2c-scx200_acb-04-lock_kernel.patch
i2c/i2c-scx200_acb-05-cs5535.patch
i2c/i2c-scx200_acb-06-poll.patch
i2c/i2c-scx200_acb-07-docs.patch
i2c/i2c-speedup-block-transfers.patch
pci/pci-schedule-pci_legacy_proc-for-removal.patch

