From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 25 Sep 2005 16:27:25 +0000
Subject: [lm-sensors] [PATCH] (4/13) hwmon: Discard explicit static
Message-Id: <20050925162644.73ca1f94.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Kill explicit static initializations to 0 in 2 hwmon drivers.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

 drivers/hwmon/adm1021.c |    2 +-
 drivers/hwmon/via686a.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.14-rc2.orig/drivers/hwmon/adm1021.c	2005-09-25 09:03:35.000000000 +0200
+++ linux-2.6.14-rc2/drivers/hwmon/adm1021.c	2005-09-25 14:34:19.000000000 +0200
@@ -121,7 +121,7 @@
 static struct adm1021_data *adm1021_update_device(struct device *dev);
 
 /* (amalysh) read only mode, otherwise any limit's writing confuse BIOS */
-static int read_only = 0;
+static int read_only;
 
 
 /* This is the driver that will be inserted */
--- linux-2.6.14-rc2.orig/drivers/hwmon/via686a.c	2005-09-25 14:18:05.000000000 +0200
+++ linux-2.6.14-rc2/drivers/hwmon/via686a.c	2005-09-25 14:34:19.000000000 +0200
@@ -44,7 +44,7 @@
 
 /* If force_addr is set to anything different from 0, we forcibly enable
    the device at the given address. */
-static unsigned short force_addr = 0;
+static unsigned short force_addr;
 module_param(force_addr, ushort, 0);
 MODULE_PARM_DESC(force_addr,
 		 "Initialize the base address of the sensors");

-- 
Jean Delvare
