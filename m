From: gregkh@suse.de (Greg KH)
Date: Mon, 05 Sep 2005 23:48:12 +0000
Subject: [lm-sensors] [PATCH] hwmon: tag super-i/o find functions __init
Message-Id: <1125956767392@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] hwmon: tag super-i/o find functions __init

Super-I/O find functions in hardware monitoring drivers can be tagged
__init as they are only called from functions themselves tagged __init.
Two of them (smsc47b397 and w83627ehf) already do, but the other four
of them (it87, pc87360, smsc47m1 and w83627hf) did not.

This saves a few bytes of memory after the drivers are loaded, 192 in
the case of the it87 driver.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit e6cfb3ad7209e4f4dcdc14f5fc437db55667041f
tree 13f6390bd5a31db45012ff93d9b93968256a7ab7
parent 7bef559455fc71f66f8573cc1aafe1dd33966c1c
author Jean Delvare <khali@linux-fr.org> Wed, 27 Jul 2005 21:32:02 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 05 Sep 2005 09:14:15 -0700

 drivers/hwmon/it87.c     |    2 +-
 drivers/hwmon/pc87360.c  |    2 +-
 drivers/hwmon/smsc47m1.c |    2 +-
 drivers/hwmon/w83627hf.c |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
--- a/drivers/hwmon/it87.c
+++ b/drivers/hwmon/it87.c
@@ -707,7 +707,7 @@ static int it87_isa_attach_adapter(struc
 }
 
 /* SuperIO detection - will change isa_address if a chip is found */
-static int it87_find(int *address)
+static int __init it87_find(int *address)
 {
 	int err = -ENODEV;
 
diff --git a/drivers/hwmon/pc87360.c b/drivers/hwmon/pc87360.c
--- a/drivers/hwmon/pc87360.c
+++ b/drivers/hwmon/pc87360.c
@@ -626,7 +626,7 @@ static DEVICE_ATTR(alarms_temp, S_IRUGO,
  * Device detection, registration and update
  */
 
-static int pc87360_find(int sioaddr, u8 *devid, unsigned short *addresses)
+static int __init pc87360_find(int sioaddr, u8 *devid, unsigned short *addresses)
 {
 	u16 val;
 	int i;
diff --git a/drivers/hwmon/smsc47m1.c b/drivers/hwmon/smsc47m1.c
--- a/drivers/hwmon/smsc47m1.c
+++ b/drivers/hwmon/smsc47m1.c
@@ -345,7 +345,7 @@ fan_present(2);
 
 static DEVICE_ATTR(alarms, S_IRUGO, get_alarms, NULL);
 
-static int smsc47m1_find(unsigned short *addr)
+static int __init smsc47m1_find(unsigned short *addr)
 {
 	u8 val;
 
diff --git a/drivers/hwmon/w83627hf.c b/drivers/hwmon/w83627hf.c
--- a/drivers/hwmon/w83627hf.c
+++ b/drivers/hwmon/w83627hf.c
@@ -958,7 +958,7 @@ device_create_file(&client->dev, &dev_at
 } while (0)
 
 
-static int w83627hf_find(int sioaddr, unsigned short *addr)
+static int __init w83627hf_find(int sioaddr, unsigned short *addr)
 {
 	u16 val;
 

