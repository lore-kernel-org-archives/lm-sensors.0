From: grant_lkml@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:55 +0000
Subject: RFC PATCH sysfs names: fscher: remove revision
Message-Id: <8l9t61hd63l0tkt2n3ni27sb1559i9tmn2@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi All,

fscher exposes chip revision to user-space, but does not use it 
internally, this patch removes revision filename

--Grant


Signed-off-by: Grant Coady <gcoady@gmail.com>
---
 fscher.c |   21 ---------------------
 1 files changed, 21 deletions(-)

--- linux-2.6.12-rc3/drivers/i2c/chips/fscher.c	2005-04-21 19:50:36.000000000 +1000
+++ linux-2.6.12-rc3b/drivers/i2c/chips/fscher.c	2005-04-25 22:27:58.000000000 +1000
@@ -138,7 +138,6 @@
 	unsigned long last_updated; /* in jiffies */
 
 	/* register values */
-	u8 revision;		/* revision of chip */
 	u8 global_event;	/* global event status */
 	u8 global_control;	/* global control register */
 	u8 watchdog[3];		/* watchdog */
@@ -205,9 +204,6 @@
 #define sysfs_in(offset, reg_act) \
 sysfs_ro_n(in, _input, offset, reg_act)
 
-#define sysfs_revision(reg_revision) \
-sysfs_ro(revision, , reg_revision)
-
 #define sysfs_alarms(reg_events) \
 sysfs_ro(alarms, , reg_events)
 
@@ -234,7 +230,6 @@
 sysfs_in(1, FSCHER_REG_VOLT_5)
 sysfs_in(2, FSCHER_REG_VOLT_BATT)
 
-sysfs_revision(FSCHER_REG_REVISION)
 sysfs_alarms(FSCHER_REG_EVENTS)
 sysfs_control(FSCHER_REG_CONTROL)
 sysfs_watchdog(FSCHER_REG_WDOG_CONTROL, FSCHER_REG_WDOG_STATE, FSCHER_REG_WDOG_PRESET)
@@ -258,11 +253,6 @@
 	device_create_file(&client->dev, &dev_attr_in##offset##_input); \
 } while (0)
 
-#define device_create_file_revision(client) \
-do { \
-	device_create_file(&client->dev, &dev_attr_revision); \
-} while (0)
-
 #define device_create_file_alarms(client) \
 do { \
 	device_create_file(&client->dev, &dev_attr_alarms); \
@@ -342,7 +332,6 @@
 	fscher_init_client(new_client);
 
 	/* Register sysfs hooks */
-	device_create_file_revision(new_client);
 	device_create_file_alarms(new_client);
 	device_create_file_control(new_client);
 	device_create_file_watchdog(new_client);
@@ -399,10 +388,7 @@
 /* Called when we have found a new FSC Hermes. */
 static void fscher_init_client(struct i2c_client *client)
 {
-	struct fscher_data *data = i2c_get_clientdata(client);
 
-	/* Read revision from chip */
-	data->revision =  fscher_read_value(client, FSCHER_REG_REVISION);
 }
 
 static struct fscher_data *fscher_update_device(struct device *dev)
@@ -581,13 +567,6 @@
 
 
 
-static ssize_t show_revision(struct fscher_data *data, char *buf, int nr)
-{
-	return sprintf(buf, "%u\n", data->revision);
-}
-
-
-
 static ssize_t show_alarms(struct fscher_data *data, char *buf, int nr)
 {
 	/* bits 2, 5..6 reserved => mask with 0x9b */
