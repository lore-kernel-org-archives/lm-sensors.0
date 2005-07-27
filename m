From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 27 Jul 2005 21:31:59 +0000
Subject: [lm-sensors] [PATCH 2.6] hwmon: tag super-i/o find functions __init
Message-Id: <20050727213202.423a4342.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg, all

Super-I/O find functions in hardware monitoring drivers can be tagged
__init as they are only called from functions themselves tagged __init.
Two of them (smsc47b397 and w83627ehf) already do, but the other four
of them (it87, pc87360, smsc47m1 and w83627hf) did not.

This saves a few bytes of memory after the drivers are loaded, 192 in
the case of the it87 driver.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

 drivers/hwmon/it87.c     |    2 +-
 drivers/hwmon/pc87360.c  |    2 +-
 drivers/hwmon/smsc47m1.c |    2 +-
 drivers/hwmon/w83627hf.c |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

--- linux-2.6.13-rc3.orig/drivers/hwmon/it87.c	2005-07-24 15:20:08.000000000 +0200
+++ linux-2.6.13-rc3/drivers/hwmon/it87.c	2005-07-24 15:22:39.000000000 +0200
@@ -707,7 +707,7 @@
 }
 
 /* SuperIO detection - will change isa_address if a chip is found */
-static int it87_find(int *address)
+static int __init it87_find(int *address)
 {
 	int err = -ENODEV;
 
--- linux-2.6.13-rc3.orig/drivers/hwmon/pc87360.c	2005-07-24 15:20:08.000000000 +0200
+++ linux-2.6.13-rc3/drivers/hwmon/pc87360.c	2005-07-24 15:22:39.000000000 +0200
@@ -626,7 +626,7 @@
  * Device detection, registration and update
  */
 
-static int pc87360_find(int sioaddr, u8 *devid, unsigned short *addresses)
+static int __init pc87360_find(int sioaddr, u8 *devid, unsigned short *addresses)
 {
 	u16 val;
 	int i;
--- linux-2.6.13-rc3.orig/drivers/hwmon/smsc47m1.c	2005-07-24 15:20:08.000000000 +0200
+++ linux-2.6.13-rc3/drivers/hwmon/smsc47m1.c	2005-07-24 15:22:39.000000000 +0200
@@ -345,7 +345,7 @@
 
 static DEVICE_ATTR(alarms, S_IRUGO, get_alarms, NULL);
 
-static int smsc47m1_find(unsigned short *addr)
+static int __init smsc47m1_find(unsigned short *addr)
 {
 	u8 val;
 
--- linux-2.6.13-rc3.orig/drivers/hwmon/w83627hf.c	2005-07-24 15:20:08.000000000 +0200
+++ linux-2.6.13-rc3/drivers/hwmon/w83627hf.c	2005-07-24 15:22:39.000000000 +0200
@@ -958,7 +958,7 @@
 } while (0)
 
 
-static int w83627hf_find(int sioaddr, unsigned short *addr)
+static int __init w83627hf_find(int sioaddr, unsigned short *addr)
 {
 	u16 val;
 


-- 
Jean Delvare
