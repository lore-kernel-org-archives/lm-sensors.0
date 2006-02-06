From: gregkh@suse.de (Greg KH)
Date: Mon, 06 Feb 2006 20:18:58 +0000
Subject: [lm-sensors] [PATCH] hwmon: Fix reboot on it87 driver load
Message-Id: <11392571381198@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] hwmon: Fix reboot on it87 driver load

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
commit c5e3fbf22ccba0879b174fab7ec0e322b1266c2c
tree 37529cd21d0f546a4e5578a554cac0371dbf4e85
parent e53004e20a58e9d28347e02adccb37a33e0d771a
author Jean Delvare <khali at linux-fr.org> Wed, 18 Jan 2006 22:39:48 +0100
committer Greg Kroah-Hartman <gregkh at suse.de> Mon, 06 Feb 2006 12:02:15 -0800

 Documentation/feature-removal-schedule.txt |    9 +++++++++
 Documentation/hwmon/it87                   |    2 +-
 drivers/hwmon/it87.c                       |    8 ++++++--
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/Documentation/feature-removal-schedule.txt b/Documentation/feature-removal-schedule.txt
index 4d4897c..b730d76 100644
--- a/Documentation/feature-removal-schedule.txt
+++ b/Documentation/feature-removal-schedule.txt
@@ -162,3 +162,12 @@ What:	pci_module_init(driver)
 When:	January 2007
 Why:	Is replaced by pci_register_driver(pci_driver).
 Who:	Richard Knutsson <ricknu-0 at student.ltu.se> and Greg Kroah-Hartman <gregkh at suse.de>
+
+---------------------------
+
+What:	I2C interface of the it87 driver
+When:	January 2007
+Why:	The ISA interface is faster and should be always available. The I2C
+	probing is also known to cause trouble in at least one case (see
+	bug #5889.)
+Who:	Jean Delvare <khali at linux-fr.org>
diff --git a/Documentation/hwmon/it87 b/Documentation/hwmon/it87
index 7f42e44..9555be1 100644
--- a/Documentation/hwmon/it87
+++ b/Documentation/hwmon/it87
@@ -9,7 +9,7 @@ Supported chips:
                http://www.ite.com.tw/
   * IT8712F
     Prefix: 'it8712'
-    Addresses scanned: I2C 0x28 - 0x2f
+    Addresses scanned: I2C 0x2d
                        from Super I/O config space (8 I/O ports)
     Datasheet: Publicly available at the ITE website
                http://www.ite.com.tw/
diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
index 0da7c9c..e87d52c 100644
--- a/drivers/hwmon/it87.c
+++ b/drivers/hwmon/it87.c
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
 


