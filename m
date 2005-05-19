From: adobriyan@mail.ru (Alexey Dobriyan)
Date: Thu, 19 May 2005 06:25:35 +0000
Subject: [PATCH] i2c/chips/*: use time_after instead of comparing jiffies
Message-Id: <200502021115.31416.adobriyan@mail.ru>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@mail.ru>
---

 drivers/i2c/chips/adm1021.c    |    5 +++--
 drivers/i2c/chips/adm1025.c    |    5 ++---
 drivers/i2c/chips/adm1026.c    |    7 ++++---
 drivers/i2c/chips/adm1031.c    |    5 +++--
 drivers/i2c/chips/asb100.c     |    5 +++--
 drivers/i2c/chips/ds1621.c     |    5 +++--
 drivers/i2c/chips/eeprom.c     |    4 ++--
 drivers/i2c/chips/fscher.c     |    4 ++--
 drivers/i2c/chips/gl518sm.c    |    5 +++--
 drivers/i2c/chips/it87.c       |    5 +++--
 drivers/i2c/chips/lm63.c       |    5 ++---
 drivers/i2c/chips/lm75.c       |    5 +++--
 drivers/i2c/chips/lm77.c       |    5 +++--
 drivers/i2c/chips/lm78.c       |    5 +++--
 drivers/i2c/chips/lm80.c       |    5 ++---
 drivers/i2c/chips/lm83.c       |    5 ++---
 drivers/i2c/chips/lm85.c       |    5 +++--
 drivers/i2c/chips/lm87.c       |    5 ++---
 drivers/i2c/chips/lm90.c       |    5 ++---
 drivers/i2c/chips/max1619.c    |    6 ++----
 drivers/i2c/chips/pc87360.c    |    4 ++--
 drivers/i2c/chips/smsc47b397.c |    5 ++---
 drivers/i2c/chips/smsc47m1.c   |    4 ++--
 drivers/i2c/chips/via686a.c    |    6 +++---
 drivers/i2c/chips/w83627hf.c   |    5 +++--
 drivers/i2c/chips/w83781d.c    |    6 +++---
 drivers/i2c/chips/w83l785ts.c  |    5 ++---
 27 files changed, 69 insertions(+), 67 deletions(-)

diff -uprN linux-2.6.11-rc2-bk10/drivers/i2c/chips/adm1021.c linux-2.6.11-rc2-bk10-time_after/drivers/i2c/chips/adm1021.c
--- linux-2.6.11-rc2-bk10/drivers/i2c/chips/adm1021.c	2004-12-24 23:33:49.000000000 +0200
+++ linux-2.6.11-rc2-bk10-time_after/drivers/i2c/chips/adm1021.c	2005-02-02 08:49:48.000000000 +0200
@@ -23,6 +23,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
+#include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
 
@@ -373,8 +374,8 @@ static struct adm1021_data *adm1021_upda
 
 	down(&data->update_lock);
 
-	if ((jiffies - data->last_updated > HZ + HZ / 2) ||
-	    (jiffies < data->last_updated) || !data->valid) {
+	if (time_after(jiffies, data->last_updated + HZ + HZ / 2)
+	    || !data->valid) {
 		dev_dbg(&client->dev, "Starting adm1021 update\n");
 
 		data->temp_input = adm1021_read_value(client, ADM1021_REG_TEMP);
diff -uprN linux-2.6.11-rc2-bk10/drivers/i2c/chips/adm1025.c linux-2.6.11-rc2-bk10-time_after/drivers/i2c/chips/adm1025.c
--- linux-2.6.11-rc2-bk10/drivers/i2c/chips/adm1025.c	2004-12-24 23:33:47.000000000 +0200
+++ linux-2.6.11-rc2-bk10-time_after/drivers/i2c/chips/adm1025.c	2005-02-02 10:49:23.000000000 +0200
@@ -49,6 +49,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
+#include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
 #include <linux/i2c-vid.h>
@@ -512,9 +513,7 @@ static struct adm1025_data *adm1025_upda
 
 	down(&data->update_lock);
 
-	if ((jiffies - data->last_updated > HZ * 2) ||
-	    (jiffies < data->last_updated) ||
-	    !data->valid) {
+	if (time_after(jiffies, data->last_updated + HZ * 2) || !data->valid) {
 		int i;
 
 		dev_dbg(&client->dev, "Updating data.\n");
diff -uprN linux-2.6.11-rc2-bk10/drivers/i2c/chips/adm1026.c linux-2.6.11-rc2-bk10-time_after/drivers/i2c/chips/adm1026.c
--- linux-2.6.11-rc2-bk10/drivers/i2c/chips/adm1026.c	2005-02-02 09:41:31.000000000 +0200
+++ linux-2.6.11-rc2-bk10-time_after/drivers/i2c/chips/adm1026.c	2005-02-02 10:13:48.000000000 +0200
@@ -27,6 +27,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
+#include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
 #include <linux/i2c-vid.h>
@@ -580,7 +581,7 @@ static struct adm1026_data *adm1026_upda
 
 	down(&data->update_lock);
 	if (!data->valid
-	    || (jiffies - data->last_reading > ADM1026_DATA_INTERVAL)) {
+	    || time_after(jiffies, data->last_reading + ADM1026_DATA_INTERVAL)) {
 		/* Things that change quickly */
 		dev_dbg(&client->dev,"(%d): Reading sensor values\n", 
 			client->id);
@@ -628,8 +629,8 @@ static struct adm1026_data *adm1026_upda
 		data->last_reading = jiffies;
 	};  /* last_reading */
 
-	if (!data->valid || (jiffies - data->last_config > 
-		ADM1026_CONFIG_INTERVAL)) {
+	if (!data->valid ||
+	    time_after(jiffies, data->last_config + ADM1026_CONFIG_INTERVAL)) {
 		/* Things that don't change often */
 		dev_dbg(&client->dev, "(%d): Reading config values\n", 
 			client->id);
diff -uprN linux-2.6.11-rc2-bk10/drivers/i2c/chips/adm1031.c linux-2.6.11-rc2-bk10-time_after/drivers/i2c/chips/adm1031.c
--- linux-2.6.11-rc2-bk10/drivers/i2c/chips/adm1031.c	2004-12-24 23:34:32.000000000 +0200
+++ linux-2.6.11-rc2-bk10-time_after/drivers/i2c/chips/adm1031.c	2005-02-02 10:14:39.000000000 +0200
@@ -24,6 +24,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
+#include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
 
@@ -888,8 +889,8 @@ static struct adm1031_data *adm1031_upda
 
 	down(&data->update_lock);
 
-	if ((jiffies - data->last_updated > HZ + HZ / 2) ||
-	    (jiffies < data->last_updated) || !data->valid) {
+	if (time_after(jiffies, data->last_updated + HZ + HZ / 2)
+	    || !data->valid) {
 
 		dev_dbg(&client->dev, "Starting adm1031 update\n");
 		for (chan = 0;
diff -uprN linux-2.6.11-rc2-bk10/drivers/i2c/chips/asb100.c linux-2.6.11-rc2-bk10-time_after/drivers/i2c/chips/asb100.c
--- linux-2.6.11-rc2-bk10/drivers/i2c/chips/asb100.c	2005-02-02 09:40:57.000000000 +0200
+++ linux-2.6.11-rc2-bk10-time_after/drivers/i2c/chips/asb100.c	2005-02-02 08:56:44.000000000 +0200
@@ -41,6 +41,7 @@
 #include <linux/slab.h>
 #include <linux/ioport.h>
 #include <linux/types.h>
+#include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
 #include <linux/i2c-vid.h>
@@ -970,8 +971,8 @@ static struct asb100_data *asb100_update
 
 	down(&data->update_lock);
 
-	if (time_after(jiffies - data->last_updated, (unsigned long)(HZ+HZ/2))
-		|| time_before(jiffies, data->last_updated) || !data->valid) {
+	if (time_after(jiffies, data->last_updated + HZ + HZ / 2)
+		|| !data->valid) {
 
 		dev_dbg(&client->dev, "starting device update...\n");
 
diff -uprN linux-2.6.11-rc2-bk10/drivers/i2c/chips/ds1621.c linux-2.6.11-rc2-bk10-time_after/drivers/i2c/chips/ds1621.c
--- linux-2.6.11-rc2-bk10/drivers/i2c/chips/ds1621.c	2004-12-24 23:35:40.000000000 +0200
+++ linux-2.6.11-rc2-bk10-time_after/drivers/i2c/chips/ds1621.c	2005-02-02 08:58:03.000000000 +0200
@@ -24,6 +24,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
+#include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
 #include "lm75.h"
@@ -284,8 +285,8 @@ static struct ds1621_data *ds1621_update
 
 	down(&data->update_lock);
 
-	if ((jiffies - data->last_updated > HZ + HZ / 2) ||
-	    (jiffies < data->last_updated) || !data->valid) {
+	if (time_after(jiffies, data->last_updated + HZ + HZ / 2)
+	    || !data->valid) {
 
 		dev_dbg(&client->dev, "Starting ds1621 update\n");
 
diff -uprN linux-2.6.11-rc2-bk10/drivers/i2c/chips/eeprom.c linux-2.6.11-rc2-bk10-time_after/drivers/i2c/chips/eeprom.c
--- linux-2.6.11-rc2-bk10/drivers/i2c/chips/eeprom.c	2005-02-02 09:41:31.000000000 +0200
+++ linux-2.6.11-rc2-bk10-time_after/drivers/i2c/chips/eeprom.c	2005-02-02 08:59:34.000000000 +0200
@@ -32,6 +32,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/sched.h>
+#include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
 
@@ -86,8 +87,7 @@ static void eeprom_update_client(struct 
 	down(&data->update_lock);
 
 	if (!(data->valid & (1 << slice)) ||
-	    (jiffies - data->last_updated[slice] > 300 * HZ) ||
-	    (jiffies < data->last_updated[slice])) {
+	    time_after(jiffies, data->last_updated[slice] + 300 * HZ)) {
 		dev_dbg(&client->dev, "Starting eeprom update, slice %u\n", slice);
 
 		if (i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_READ_I2C_BLOCK)) {
diff -uprN linux-2.6.11-rc2-bk10/drivers/i2c/chips/fscher.c linux-2.6.11-rc2-bk10-time_after/drivers/i2c/chips/fscher.c
--- linux-2.6.11-rc2-bk10/drivers/i2c/chips/fscher.c	2005-02-02 09:40:57.000000000 +0200
+++ linux-2.6.11-rc2-bk10-time_after/drivers/i2c/chips/fscher.c	2005-02-02 10:16:12.000000000 +0200
@@ -30,6 +30,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
+#include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
 
@@ -418,8 +419,7 @@ static struct fscher_data *fscher_update
 
 	down(&data->update_lock);
 
-	if ((jiffies - data->last_updated > 2 * HZ) ||
-	    (jiffies < data->last_updated) || !data->valid) {
+	if (time_after(jiffies, data->last_updated + 2 * HZ) || !data->valid) {
 
 		dev_dbg(&client->dev, "Starting fscher update\n");
 
diff -uprN linux-2.6.11-rc2-bk10/drivers/i2c/chips/gl518sm.c linux-2.6.11-rc2-bk10-time_after/drivers/i2c/chips/gl518sm.c
--- linux-2.6.11-rc2-bk10/drivers/i2c/chips/gl518sm.c	2004-12-24 23:35:39.000000000 +0200
+++ linux-2.6.11-rc2-bk10-time_after/drivers/i2c/chips/gl518sm.c	2005-02-02 09:03:35.000000000 +0200
@@ -40,6 +40,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
+#include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
 
@@ -512,8 +513,8 @@ static struct gl518_data *gl518_update_d
 
 	down(&data->update_lock);
 
-	if ((jiffies - data->last_updated > HZ + HZ / 2) ||
-	    (jiffies < data->last_updated) || !data->valid) {
+	if (time_after(jiffies, data->last_updated + HZ + HZ / 2)
+	    || !data->valid) {
 		dev_dbg(&client->dev, "Starting gl518 update\n");
 
 		data->alarms = gl518_read_value(client, GL518_REG_INT);
diff -uprN linux-2.6.11-rc2-bk10/drivers/i2c/chips/it87.c linux-2.6.11-rc2-bk10-time_after/drivers/i2c/chips/it87.c
--- linux-2.6.11-rc2-bk10/drivers/i2c/chips/it87.c	2005-02-02 09:41:31.000000000 +0200
+++ linux-2.6.11-rc2-bk10-time_after/drivers/i2c/chips/it87.c	2005-02-02 09:06:30.000000000 +0200
@@ -35,6 +35,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
+#include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
 #include <linux/i2c-vid.h>
@@ -1040,8 +1041,8 @@ static struct it87_data *it87_update_dev
 
 	down(&data->update_lock);
 
-	if ((jiffies - data->last_updated > HZ + HZ / 2) ||
-	    (jiffies < data->last_updated) || !data->valid) {
+	if (time_after(jiffies, data->last_updated + HZ + HZ / 2)
+	    || !data->valid) {
 
 		if (update_vbat) {
 			/* Cleared after each update, so reenable.  Value
diff -uprN linux-2.6.11-rc2-bk10/drivers/i2c/chips/lm63.c linux-2.6.11-rc2-bk10-time_after/drivers/i2c/chips/lm63.c
--- linux-2.6.11-rc2-bk10/drivers/i2c/chips/lm63.c	2005-02-02 09:41:31.000000000 +0200
+++ linux-2.6.11-rc2-bk10-time_after/drivers/i2c/chips/lm63.c	2005-02-02 10:17:04.000000000 +0200
@@ -41,6 +41,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
+#include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
 
@@ -492,9 +493,7 @@ static struct lm63_data *lm63_update_dev
 
 	down(&data->update_lock);
 
-	if ((jiffies - data->last_updated > HZ) ||
-	    (jiffies < data->last_updated) ||
-	    !data->valid) {
+	if (time_after(jiffies, data->last_updated + HZ) || !data->valid) {
 		if (data->config & 0x04) { /* tachometer enabled  */
 			/* order matters for fan1_input */
 			data->fan1_input = i2c_smbus_read_byte_data(client,
diff -uprN linux-2.6.11-rc2-bk10/drivers/i2c/chips/lm75.c linux-2.6.11-rc2-bk10-time_after/drivers/i2c/chips/lm75.c
--- linux-2.6.11-rc2-bk10/drivers/i2c/chips/lm75.c	2004-12-24 23:33:48.000000000 +0200
+++ linux-2.6.11-rc2-bk10-time_after/drivers/i2c/chips/lm75.c	2005-02-02 09:09:33.000000000 +0200
@@ -22,6 +22,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
+#include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
 #include "lm75.h"
@@ -263,8 +264,8 @@ static struct lm75_data *lm75_update_dev
 
 	down(&data->update_lock);
 
-	if ((jiffies - data->last_updated > HZ + HZ / 2) ||
-	    (jiffies < data->last_updated) || !data->valid) {
+	if (time_after(jiffies, data->last_updated + HZ + HZ / 2)
+	    || !data->valid) {
 		dev_dbg(&client->dev, "Starting lm75 update\n");
 
 		data->temp_input = lm75_read_value(client, LM75_REG_TEMP);
diff -uprN linux-2.6.11-rc2-bk10/drivers/i2c/chips/lm77.c linux-2.6.11-rc2-bk10-time_after/drivers/i2c/chips/lm77.c
--- linux-2.6.11-rc2-bk10/drivers/i2c/chips/lm77.c	2004-12-24 23:36:00.000000000 +0200
+++ linux-2.6.11-rc2-bk10-time_after/drivers/i2c/chips/lm77.c	2005-02-02 09:10:51.000000000 +0200
@@ -29,6 +29,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
+#include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
 
@@ -364,8 +365,8 @@ static struct lm77_data *lm77_update_dev
 
 	down(&data->update_lock);
 
-	if ((jiffies - data->last_updated > HZ + HZ / 2) ||
-	    (jiffies < data->last_updated) || !data->valid) {
+	if (time_after(jiffies, data->last_updated + HZ + HZ / 2)
+	    || !data->valid) {
 		dev_dbg(&client->dev, "Starting lm77 update\n");
 		data->temp_input  			LM77_TEMP_FROM_REG(lm77_read_value(client,
diff -uprN linux-2.6.11-rc2-bk10/drivers/i2c/chips/lm78.c linux-2.6.11-rc2-bk10-time_after/drivers/i2c/chips/lm78.c
--- linux-2.6.11-rc2-bk10/drivers/i2c/chips/lm78.c	2005-02-02 09:40:57.000000000 +0200
+++ linux-2.6.11-rc2-bk10-time_after/drivers/i2c/chips/lm78.c	2005-02-02 09:11:53.000000000 +0200
@@ -22,6 +22,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
+#include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
 #include <asm/io.h>
@@ -709,8 +710,8 @@ static struct lm78_data *lm78_update_dev
 
 	down(&data->update_lock);
 
-	if ((jiffies - data->last_updated > HZ + HZ / 2) ||
-	    (jiffies < data->last_updated) || !data->valid) {
+	if (time_after(jiffies, data->last_updated + HZ + HZ / 2)
+	    || !data->valid) {
 
 		dev_dbg(&client->dev, "Starting lm78 update\n");
 
diff -uprN linux-2.6.11-rc2-bk10/drivers/i2c/chips/lm80.c linux-2.6.11-rc2-bk10-time_after/drivers/i2c/chips/lm80.c
--- linux-2.6.11-rc2-bk10/drivers/i2c/chips/lm80.c	2004-12-24 23:33:52.000000000 +0200
+++ linux-2.6.11-rc2-bk10-time_after/drivers/i2c/chips/lm80.c	2005-02-02 10:18:13.000000000 +0200
@@ -25,6 +25,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
+#include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
 
@@ -530,9 +531,7 @@ static struct lm80_data *lm80_update_dev
 
 	down(&data->update_lock);
 
-	if ((jiffies - data->last_updated > 2 * HZ) ||
-	    (jiffies < data->last_updated) || !data->valid) {
-
+	if (time_after(jiffies, data->last_updated + 2 * HZ) || !data->valid) {
 		dev_dbg(&client->dev, "Starting lm80 update\n");
 		for (i = 0; i <= 6; i++) {
 			data->in[i] diff -uprN linux-2.6.11-rc2-bk10/drivers/i2c/chips/lm83.c linux-2.6.11-rc2-bk10-time_after/drivers/i2c/chips/lm83.c
--- linux-2.6.11-rc2-bk10/drivers/i2c/chips/lm83.c	2004-12-24 23:34:32.000000000 +0200
+++ linux-2.6.11-rc2-bk10-time_after/drivers/i2c/chips/lm83.c	2005-02-02 10:19:16.000000000 +0200
@@ -31,6 +31,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
+#include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
 
@@ -369,9 +370,7 @@ static struct lm83_data *lm83_update_dev
 
 	down(&data->update_lock);
 
-	if ((jiffies - data->last_updated > HZ * 2) ||
-	    (jiffies < data->last_updated) ||
-	    !data->valid) {
+	if (time_after(jiffies, data->last_updated + HZ * 2) || !data->valid) {
 		int nr;
 
 		dev_dbg(&client->dev, "Updating lm83 data.\n");
diff -uprN linux-2.6.11-rc2-bk10/drivers/i2c/chips/lm85.c linux-2.6.11-rc2-bk10-time_after/drivers/i2c/chips/lm85.c
--- linux-2.6.11-rc2-bk10/drivers/i2c/chips/lm85.c	2005-02-02 09:41:31.000000000 +0200
+++ linux-2.6.11-rc2-bk10-time_after/drivers/i2c/chips/lm85.c	2005-02-02 09:15:28.000000000 +0200
@@ -27,6 +27,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
+#include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
 #include <linux/i2c-vid.h>
@@ -1363,7 +1364,7 @@ static struct lm85_data *lm85_update_dev
 	down(&data->update_lock);
 
 	if ( !data->valid ||
-	     (jiffies - data->last_reading > LM85_DATA_INTERVAL ) ) {
+	     time_after(jiffies, data->last_reading + LM85_DATA_INTERVAL) ) {
 		/* Things that change quickly */
 		dev_dbg(&client->dev, "Reading sensor values\n");
 		
@@ -1417,7 +1418,7 @@ static struct lm85_data *lm85_update_dev
 	};  /* last_reading */
 
 	if ( !data->valid ||
-	     (jiffies - data->last_config > LM85_CONFIG_INTERVAL) ) {
+	     time_after(jiffies, data->last_config + LM85_CONFIG_INTERVAL) ) {
 		/* Things that don't change often */
 		dev_dbg(&client->dev, "Reading config values\n");
 
diff -uprN linux-2.6.11-rc2-bk10/drivers/i2c/chips/lm87.c linux-2.6.11-rc2-bk10-time_after/drivers/i2c/chips/lm87.c
--- linux-2.6.11-rc2-bk10/drivers/i2c/chips/lm87.c	2004-12-24 23:35:39.000000000 +0200
+++ linux-2.6.11-rc2-bk10-time_after/drivers/i2c/chips/lm87.c	2005-02-02 10:49:53.000000000 +0200
@@ -56,6 +56,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
+#include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
 #include <linux/i2c-vid.h>
@@ -720,9 +721,7 @@ static struct lm87_data *lm87_update_dev
 
 	down(&data->update_lock);
 
-	if (jiffies - data->last_updated > HZ
-	  || jiffies < data->last_updated
-	  || !data->valid) {
+	if (time_after(jiffies, data->last_updated + HZ) || !data->valid) {
 		int i, j;
 
 		dev_dbg(&client->dev, "Updating data.\n");
diff -uprN linux-2.6.11-rc2-bk10/drivers/i2c/chips/lm90.c linux-2.6.11-rc2-bk10-time_after/drivers/i2c/chips/lm90.c
--- linux-2.6.11-rc2-bk10/drivers/i2c/chips/lm90.c	2005-02-02 09:40:57.000000000 +0200
+++ linux-2.6.11-rc2-bk10-time_after/drivers/i2c/chips/lm90.c	2005-02-02 10:20:44.000000000 +0200
@@ -66,6 +66,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
+#include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
 
@@ -495,9 +496,7 @@ static struct lm90_data *lm90_update_dev
 
 	down(&data->update_lock);
 
-	if ((jiffies - data->last_updated > HZ * 2) ||
-	    (jiffies < data->last_updated) ||
-	    !data->valid) {
+	if (time_after(jiffies, data->last_updated + HZ * 2) || !data->valid) {
 		u8 oldh, newh;
 
 		dev_dbg(&client->dev, "Updating lm90 data.\n");
diff -uprN linux-2.6.11-rc2-bk10/drivers/i2c/chips/max1619.c linux-2.6.11-rc2-bk10-time_after/drivers/i2c/chips/max1619.c
--- linux-2.6.11-rc2-bk10/drivers/i2c/chips/max1619.c	2004-12-24 23:35:25.000000000 +0200
+++ linux-2.6.11-rc2-bk10-time_after/drivers/i2c/chips/max1619.c	2005-02-02 10:49:43.000000000 +0200
@@ -30,6 +30,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
+#include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
 
@@ -331,10 +332,7 @@ static struct max1619_data *max1619_upda
 
 	down(&data->update_lock);
 
-	if ((jiffies - data->last_updated > HZ * 2) ||
-	    (jiffies < data->last_updated) ||
-	    !data->valid) {
-		
+	if (time_after(jiffies, data->last_updated + HZ * 2) || !data->valid) {
 		dev_dbg(&client->dev, "Updating max1619 data.\n");
 		data->temp_input1 = i2c_smbus_read_byte_data(client,
 					MAX1619_REG_R_LOCAL_TEMP);
diff -uprN linux-2.6.11-rc2-bk10/drivers/i2c/chips/pc87360.c linux-2.6.11-rc2-bk10-time_after/drivers/i2c/chips/pc87360.c
--- linux-2.6.11-rc2-bk10/drivers/i2c/chips/pc87360.c	2005-02-02 09:40:57.000000000 +0200
+++ linux-2.6.11-rc2-bk10-time_after/drivers/i2c/chips/pc87360.c	2005-02-02 10:22:48.000000000 +0200
@@ -37,6 +37,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
+#include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
 #include <linux/i2c-vid.h>
@@ -1153,8 +1154,7 @@ static struct pc87360_data *pc87360_upda
 
 	down(&data->update_lock);
 
-	if ((jiffies - data->last_updated > HZ * 2)
-	 || (jiffies < data->last_updated) || !data->valid) {
+	if (time_after(jiffies, data->last_updated + HZ * 2) || !data->valid) {
 		dev_dbg(&client->dev, "Data update\n");
 
 		/* Fans */
diff -uprN linux-2.6.11-rc2-bk10/drivers/i2c/chips/smsc47b397.c linux-2.6.11-rc2-bk10-time_after/drivers/i2c/chips/smsc47b397.c
--- linux-2.6.11-rc2-bk10/drivers/i2c/chips/smsc47b397.c	2005-02-02 09:40:57.000000000 +0200
+++ linux-2.6.11-rc2-bk10-time_after/drivers/i2c/chips/smsc47b397.c	2005-02-02 10:23:21.000000000 +0200
@@ -29,6 +29,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/ioport.h>
+#include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
 #include <linux/init.h>
@@ -130,9 +131,7 @@ static struct smsc47b397_data *smsc47b39
 
 	down(&data->update_lock);
 
-	if (time_after(jiffies - data->last_updated, (unsigned long)HZ)
-		|| time_before(jiffies, data->last_updated) || !data->valid) {
-
+	if (time_after(jiffies, data->last_updated + HZ) || !data->valid) {
 		dev_dbg(&client->dev, "starting device update...\n");
 
 		/* 4 temperature inputs, 4 fan inputs */
diff -uprN linux-2.6.11-rc2-bk10/drivers/i2c/chips/smsc47m1.c linux-2.6.11-rc2-bk10-time_after/drivers/i2c/chips/smsc47m1.c
--- linux-2.6.11-rc2-bk10/drivers/i2c/chips/smsc47m1.c	2005-02-02 09:40:57.000000000 +0200
+++ linux-2.6.11-rc2-bk10-time_after/drivers/i2c/chips/smsc47m1.c	2005-02-02 09:31:57.000000000 +0200
@@ -28,6 +28,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/ioport.h>
+#include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
 #include <linux/init.h>
@@ -532,8 +533,7 @@ static struct smsc47m1_data *smsc47m1_up
 
 	down(&data->update_lock);
 
-	if ((jiffies - data->last_updated > HZ + HZ / 2) ||
-	    (jiffies < data->last_updated) || init) {
+	if (time_after(jiffies, data->last_updated + HZ + HZ / 2) || init) {
 		int i;
 
 		for (i = 0; i < 2; i++) {
diff -uprN linux-2.6.11-rc2-bk10/drivers/i2c/chips/via686a.c linux-2.6.11-rc2-bk10-time_after/drivers/i2c/chips/via686a.c
--- linux-2.6.11-rc2-bk10/drivers/i2c/chips/via686a.c	2005-02-02 09:41:31.000000000 +0200
+++ linux-2.6.11-rc2-bk10-time_after/drivers/i2c/chips/via686a.c	2005-02-02 10:25:11.000000000 +0200
@@ -35,6 +35,7 @@
 #include <linux/slab.h>
 #include <linux/pci.h>
 #include <linux/delay.h>
+#include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
 #include <linux/init.h>
@@ -726,9 +727,8 @@ static struct via686a_data *via686a_upda
 
 	down(&data->update_lock);
 
-       if ((jiffies - data->last_updated > HZ + HZ / 2) ||
-           (jiffies < data->last_updated) || !data->valid) {
-
+	if (time_after(jiffies, data->last_updated + HZ + HZ / 2)
+	    || !data->valid) {
 		for (i = 0; i <= 4; i++) {
 			data->in[i]  			    via686a_read_value(client, VIA686A_REG_IN(i));
diff -uprN linux-2.6.11-rc2-bk10/drivers/i2c/chips/w83627hf.c linux-2.6.11-rc2-bk10-time_after/drivers/i2c/chips/w83627hf.c
--- linux-2.6.11-rc2-bk10/drivers/i2c/chips/w83627hf.c	2005-02-02 09:40:57.000000000 +0200
+++ linux-2.6.11-rc2-bk10-time_after/drivers/i2c/chips/w83627hf.c	2005-02-02 09:34:43.000000000 +0200
@@ -40,6 +40,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
+#include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
 #include <linux/i2c-vid.h>
@@ -1350,8 +1351,8 @@ static struct w83627hf_data *w83627hf_up
 
 	down(&data->update_lock);
 
-	if ((jiffies - data->last_updated > HZ + HZ / 2) ||
-	    (jiffies < data->last_updated) || !data->valid) {
+	if (time_after(jiffies, data->last_updated + HZ + HZ / 2)
+	    || !data->valid) {
 		for (i = 0; i <= 8; i++) {
 			/* skip missing sensors */
 			if (((data->type = w83697hf) && (i = 1)) ||
diff -uprN linux-2.6.11-rc2-bk10/drivers/i2c/chips/w83781d.c linux-2.6.11-rc2-bk10-time_after/drivers/i2c/chips/w83781d.c
--- linux-2.6.11-rc2-bk10/drivers/i2c/chips/w83781d.c	2005-02-02 09:40:57.000000000 +0200
+++ linux-2.6.11-rc2-bk10-time_after/drivers/i2c/chips/w83781d.c	2005-02-02 09:36:51.000000000 +0200
@@ -39,6 +39,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
+#include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
 #include <linux/i2c-vid.h>
@@ -1606,9 +1607,8 @@ static struct w83781d_data *w83781d_upda
 
 	down(&data->update_lock);
 
-	if (time_after
-	    (jiffies - data->last_updated, (unsigned long) (HZ + HZ / 2))
-	    || time_before(jiffies, data->last_updated) || !data->valid) {
+	if (time_after(jiffies, data->last_updated + HZ + HZ / 2)
+	    || !data->valid) {
 		dev_dbg(dev, "Starting device update\n");
 
 		for (i = 0; i <= 8; i++) {
diff -uprN linux-2.6.11-rc2-bk10/drivers/i2c/chips/w83l785ts.c linux-2.6.11-rc2-bk10-time_after/drivers/i2c/chips/w83l785ts.c
--- linux-2.6.11-rc2-bk10/drivers/i2c/chips/w83l785ts.c	2004-12-24 23:34:26.000000000 +0200
+++ linux-2.6.11-rc2-bk10-time_after/drivers/i2c/chips/w83l785ts.c	2005-02-02 09:38:40.000000000 +0200
@@ -35,6 +35,7 @@
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/slab.h>
+#include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
 
@@ -301,9 +302,7 @@ static struct w83l785ts_data *w83l785ts_
 
 	down(&data->update_lock);
 
-	if (!data->valid
-	 || (jiffies - data->last_updated > HZ * 2)
-	 || (jiffies < data->last_updated)) {
+	if (!data->valid || time_after(jiffies, data->last_updated + HZ * 2)) {
 		dev_dbg(&client->dev, "Updating w83l785ts data.\n");
 		data->temp = w83l785ts_read_value(client,
 			     W83L785TS_REG_TEMP, data->temp);
