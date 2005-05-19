From: grant_lkml@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:55 +0000
Subject: RFC PATCH sysfs names: fscher: remove revision
Message-Id: <576571124i72objua2jma4nk4jjn3thtpo@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <8l9t61hd63l0tkt2n3ni27sb1559i9tmn2@4ax.com>
In-Reply-To: <8l9t61hd63l0tkt2n3ni27sb1559i9tmn2@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Khali,

On Wed, 27 Apr 2005 18:55:09 +0200, Jean Delvare <khali@linux-fr.org> wrote:

>> fscher exposes chip revision to user-space, but does not use it 
>> internally, this patch removes revision filename
>
>I am in favor of this change, with two minor objections:
>
>1* Maybe you could add an info printk saying "fscher: Found FSC Hermes
>chip, revision %d", like the it87 driver does for example. That way,
>people still get to know the revision of the chip if it should ever
>matter.
done
>
>2*
>>  static void fscher_init_client(struct i2c_client *client)
removed

I haven't looked at libsensors for this change (I forgot how) -- grab 
CVS and patch against that?

--Grant.



Signed-off-by: Grant Coady <gcoady@gmail.com>

---
 fscher.c |   36 ++++++------------------------------
 1 files changed, 6 insertions(+), 30 deletions(-)

--- linux-2.6.12-rc3/drivers/i2c/chips/fscher.c	2005-04-21 19:50:36.000000000 +1000
+++ linux-2.6.12-rc3b/drivers/i2c/chips/fscher.c	2005-04-30 06:24:03.000000000 +1000
@@ -109,7 +109,6 @@
 static int fscher_detect(struct i2c_adapter *adapter, int address, int kind);
 static int fscher_detach_client(struct i2c_client *client);
 static struct fscher_data *fscher_update_device(struct device *dev);
-static void fscher_init_client(struct i2c_client *client);
 
 static int fscher_read_value(struct i2c_client *client, u8 reg);
 static int fscher_write_value(struct i2c_client *client, u8 reg, u8 value);
@@ -138,7 +137,6 @@
 	unsigned long last_updated; /* in jiffies */
 
 	/* register values */
-	u8 revision;		/* revision of chip */
 	u8 global_event;	/* global event status */
 	u8 global_control;	/* global control register */
 	u8 watchdog[3];		/* watchdog */
@@ -205,9 +203,6 @@
 #define sysfs_in(offset, reg_act) \
 sysfs_ro_n(in, _input, offset, reg_act)
 
-#define sysfs_revision(reg_revision) \
-sysfs_ro(revision, , reg_revision)
-
 #define sysfs_alarms(reg_events) \
 sysfs_ro(alarms, , reg_events)
 
@@ -234,7 +229,6 @@
 sysfs_in(1, FSCHER_REG_VOLT_5)
 sysfs_in(2, FSCHER_REG_VOLT_BATT)
 
-sysfs_revision(FSCHER_REG_REVISION)
 sysfs_alarms(FSCHER_REG_EVENTS)
 sysfs_control(FSCHER_REG_CONTROL)
 sysfs_watchdog(FSCHER_REG_WDOG_CONTROL, FSCHER_REG_WDOG_STATE, FSCHER_REG_WDOG_PRESET)
@@ -258,11 +252,6 @@
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
@@ -296,6 +285,7 @@
 	struct i2c_client *new_client;
 	struct fscher_data *data;
 	int err = 0;
+	u8 die_rev;
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		goto exit;
@@ -329,6 +319,11 @@
 			goto exit_free;
 	}
 
+	/* Report we found chip, revision */
+	die_rev = i2c_smbus_read_byte_data(new_client, FSCHER_REG_REVISION);
+	dev_info(&adapter->dev, "fscher: Found FSC Hermes chip, "
+			"revision %u\n", die_rev);
+
 	/* Fill in the remaining client fields and put it into the
 	 * global list */
 	strlcpy(new_client->name, "fscher", I2C_NAME_SIZE);
@@ -339,10 +334,7 @@
 	if ((err = i2c_attach_client(new_client)))
 		goto exit_free;
 
-	fscher_init_client(new_client);
-
 	/* Register sysfs hooks */
-	device_create_file_revision(new_client);
 	device_create_file_alarms(new_client);
 	device_create_file_control(new_client);
 	device_create_file_watchdog(new_client);
@@ -396,15 +388,6 @@
 	return i2c_smbus_write_byte_data(client, reg, value);
 }
 
-/* Called when we have found a new FSC Hermes. */
-static void fscher_init_client(struct i2c_client *client)
-{
-	struct fscher_data *data = i2c_get_clientdata(client);
-
-	/* Read revision from chip */
-	data->revision =  fscher_read_value(client, FSCHER_REG_REVISION);
-}
-
 static struct fscher_data *fscher_update_device(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
@@ -581,13 +564,6 @@
 
 
 
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
