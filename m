From: gregkh@suse.de (Greg KH)
Date: Sat, 29 Oct 2005 01:12:55 +0000
Subject: [lm-sensors] [PATCH] hwmon: Discard explicit static initializations
Message-Id: <11305336573408@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] hwmon: Discard explicit static initializations to 0

Kill explicit static initializations to 0 in 2 hwmon drivers.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

 drivers/hwmon/adm1021.c |    2 +-
 drivers/hwmon/via686a.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

---
commit 0200296310a454b39efc995e676f9ff60e641edb
tree 9567c8d36528a4118e45c4d589dc40ea4af1cc85
parent 605070952f0b41caaa211c47b02eeac703529008
author Jean Delvare <khali@linux-fr.org> Sun, 25 Sep 2005 16:26:44 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 28 Oct 2005 14:02:06 -0700

 drivers/hwmon/adm1021.c |    2 +-
 drivers/hwmon/via686a.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/adm1021.c b/drivers/hwmon/adm1021.c
index e928cdb..58aee3a 100644
--- a/drivers/hwmon/adm1021.c
+++ b/drivers/hwmon/adm1021.c
@@ -121,7 +121,7 @@ static int adm1021_write_value(struct i2
 static struct adm1021_data *adm1021_update_device(struct device *dev);
 
 /* (amalysh) read only mode, otherwise any limit's writing confuse BIOS */
-static int read_only = 0;
+static int read_only;
 
 
 /* This is the driver that will be inserted */
diff --git a/drivers/hwmon/via686a.c b/drivers/hwmon/via686a.c
index 688ccf9..54861f1 100644
--- a/drivers/hwmon/via686a.c
+++ b/drivers/hwmon/via686a.c
@@ -44,7 +44,7 @@
 
 /* If force_addr is set to anything different from 0, we forcibly enable
    the device at the given address. */
-static unsigned short force_addr = 0;
+static unsigned short force_addr;
 module_param(force_addr, ushort, 0);
 MODULE_PARM_DESC(force_addr,
 		 "Initialize the base address of the sensors");

