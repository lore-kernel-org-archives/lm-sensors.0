From: grant_lkml@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:55 +0000
Subject: RFC PATCH 2.6 sysfs names: fscher: change div to ripple
Message-Id: <v9v471lnjjvuns5d3gs7gre5set58bgjuq@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <o99t61p4c255uvjrhpavjejblb2r1cdts5@4ax.com>
In-Reply-To: <o99t61p4c255uvjrhpavjejblb2r1cdts5@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Philip, Khali,
On Wed, 27 Apr 2005 23:14:31 +0200, Jean Delvare <khali@linux-fr.org> wrote:

Philip wrote >>
>> So the fan_ripple is the *inverse* of the fan_div value, but they
>> have the same net effect, and you can account for the reciprical in
>> the driver.  ie  fan_div = 8/fan_ripple (if the max "ripple" value
                    ^^^^^^^^^^^^^^^^^^^^^^-- sorry, I missed significance
>> is 8)
>
>Thanks for the clarification, it all makes sense now, and actually both
>ways can be seen as similar, you're right. It's really only a matter of
>whether or not we compensate for the division in the driver. We
>typically do for fan clock dividers and not in the FSC chips case, but
>this is more or less arbitrary.
. . .
>         I have no strong opinion on this (understatement of me being
>unable to decide what I think we should do) so any solution that is
>consistent will be fine with me.

Just looking at the drivers (fscher, pscpos) again, fan speed rpm 
reading is register_value * 60, so the chip reporting revs / sec.

data sheet gives fan_ripple in 2, 4, 8 =>> fan_div in 8, 4, 2

  store (16 / fan_div) to fan_ripple

  report (16 / fan_ripple) as fan_div

  fan_ripple is internal to driver, not exposed

  report (fan_ripple * 60 * fan_rps / 2) for fan speed (no change for
  'normal' 2 pps fan with default fan_ripple = 2.

Seems like a safe thing to do, and easier if everything has fan_div 
which satisfies Philip's earlier point _and_ acts the same as fan_div 
in other drivers.

Dunno if I'd go put in auto-fan-div without a live tester somewhere :)

I've been somewhat invasive removing an extra macro to expose some 
indexing trickery and renaming fan_act to fan_rps to match comments.

Expected effect is that chip will report 'default fan_div' as 8 (default 
fan_ripple is 2) and changing fake fan_div does not change reported 
fan speed, user will need to scale for fan_pps just like every other 
driver :)

Comments welcome, a live tester even more so.  Changes to fscher don't 
impact libsensors?  no interface change.

If this is acceptable approach I'll change fscpos over -- it has 
fan_ripple and wdog to change, thus will change interface and need 
libsensors changed to match, correct?

--Grant.


Signed-off-by: Grant Coady <gcoady@gmail.com>

---
 fscher.c |   48 ++++++++++++++++++++++++++----------------------
 1 files changed, 26 insertions(+), 22 deletions(-)

--- linux-2.6.12-rc3/drivers/i2c/chips/fscher.c	2005-04-21 19:50:36.000000000 +1000
+++ linux-2.6.12-rc3b/drivers/i2c/chips/fscher.c	2005-04-30 05:17:08.000000000 +1000
@@ -145,8 +145,8 @@
 	u8 volt[3];		/* 12, 5, battery voltage */ 
 	u8 temp_act[3];		/* temperature */
 	u8 temp_status[3];	/* status of sensor */
-	u8 fan_act[3];		/* fans revolutions per second */
 	u8 fan_status[3];	/* fan status */
+	u8 fan_rps[3];		/* fans revolutions per second */
 	u8 fan_min[3];		/* fan min value for rps */
 	u8 fan_ripple[3];	/* divider for rps */
 };
@@ -427,9 +427,9 @@
 		data->volt[1] = fscher_read_value(client, FSCHER_REG_VOLT_5);
 		data->volt[2] = fscher_read_value(client, FSCHER_REG_VOLT_BATT);
 
-		data->fan_act[0] = fscher_read_value(client, FSCHER_REG_FAN0_ACT);
-		data->fan_act[1] = fscher_read_value(client, FSCHER_REG_FAN1_ACT);
-		data->fan_act[2] = fscher_read_value(client, FSCHER_REG_FAN2_ACT);
+		data->fan_rps[0] = fscher_read_value(client, FSCHER_REG_FAN0_ACT);
+		data->fan_rps[1] = fscher_read_value(client, FSCHER_REG_FAN1_ACT);
+		data->fan_rps[2] = fscher_read_value(client, FSCHER_REG_FAN2_ACT);
 		data->fan_status[0] = fscher_read_value(client, FSCHER_REG_FAN0_STATE);
 		data->fan_status[1] = fscher_read_value(client, FSCHER_REG_FAN1_STATE);
 		data->fan_status[2] = fscher_read_value(client, FSCHER_REG_FAN2_STATE);
@@ -455,10 +455,7 @@
 	return data;
 }
 
-
-
-#define FAN_INDEX_FROM_NUM(nr)	((nr) - 1)
-
+/* fans */
 static ssize_t set_fan_status(struct i2c_client *client, struct fscher_data *data,
 			      const char *buf, size_t count, int nr, int reg)
 {
@@ -466,7 +463,7 @@
 	unsigned long v = simple_strtoul(buf, NULL, 10) & 0x04;
 	
 	down(&data->update_lock);
-	data->fan_status[FAN_INDEX_FROM_NUM(nr)] &= ~v;
+	data->fan_status[nr - 1] &= ~v;
 	fscher_write_value(client, reg, v);
 	up(&data->update_lock);
 	return count;
@@ -475,7 +472,7 @@
 static ssize_t show_fan_status(struct fscher_data *data, char *buf, int nr)
 {
 	/* bits 0..1, 3..7 reserved => mask with 0x04 */  
-	return sprintf(buf, "%u\n", data->fan_status[FAN_INDEX_FROM_NUM(nr)] & 0x04);
+	return sprintf(buf, "%u\n", data->fan_status[nr - 1] & 0x04);
 }
 
 static ssize_t set_pwm(struct i2c_client *client, struct fscher_data *data,
@@ -484,17 +481,25 @@
 	unsigned long v = simple_strtoul(buf, NULL, 10);
 
 	down(&data->update_lock);
-	data->fan_min[FAN_INDEX_FROM_NUM(nr)] = v > 0xff ? 0xff : v;
-	fscher_write_value(client, reg, data->fan_min[FAN_INDEX_FROM_NUM(nr)]);
+	data->fan_min[nr - 1] = v > 0xff ? 0xff : v;
+	fscher_write_value(client, reg, data->fan_min[nr - 1]);
 	up(&data->update_lock);
 	return count;
 }
 
 static ssize_t show_pwm(struct fscher_data *data, char *buf, int nr)
 {
-	return sprintf(buf, "%u\n", data->fan_min[FAN_INDEX_FROM_NUM(nr)]);
+	return sprintf(buf, "%u\n", data->fan_min[nr - 1]);
 }
 
+/*
+ * We going to tell a little lie to sysfs: pretend we have a fan_div like
+ * our sibling drivers.
+ * How?  make fan_div 2, 4, 8 =>> fan_ripple 8, 4, 2, 'normalise' fan speed
+ * store (16 / fan_div) to fan_ripple
+ * report (16 / fan_ripple) as fan_div
+ * report (fan_rps * fan_ripple / 2) as fan speed, no change for fan_ripple = 2
+ */
 static ssize_t set_fan_div(struct i2c_client *client, struct fscher_data *data,
 			   const char *buf, size_t count, int nr, int reg)
 {
@@ -502,9 +507,9 @@
 	unsigned long v = simple_strtoul(buf, NULL, 10);
 
 	switch (v) {
-	case 2: v = 1; break;
+	case 8: v = 1; break;
 	case 4: v = 2; break;
-	case 8: v = 3; break;
+	case 2: v = 3; break;
 	default:
 		dev_err(&client->dev, "fan_div value %ld not "
 			 "supported. Choose one of 2, 4 or 8!\n", v);
@@ -514,10 +519,10 @@
 	down(&data->update_lock);
 
 	/* bits 2..7 reserved => mask with 0x03 */
-	data->fan_ripple[FAN_INDEX_FROM_NUM(nr)] &= ~0x03;
-	data->fan_ripple[FAN_INDEX_FROM_NUM(nr)] |= v;
+	data->fan_ripple[nr - 1] &= ~0x03;
+	data->fan_ripple[nr - 1] |= v;
 
-	fscher_write_value(client, reg, data->fan_ripple[FAN_INDEX_FROM_NUM(nr)]);
+	fscher_write_value(client, reg, data->fan_ripple[nr - 1]);
 	up(&data->update_lock);
 	return count;
 }
@@ -525,14 +530,13 @@
 static ssize_t show_fan_div(struct fscher_data *data, char *buf, int nr)
 {
 	/* bits 2..7 reserved => mask with 0x03 */  
-	return sprintf(buf, "%u\n", 1 << (data->fan_ripple[FAN_INDEX_FROM_NUM(nr)] & 0x03));
+	return sprintf(buf, "%u\n", 16 / (1 << (data->fan_ripple[nr - 1] & 0x03)));
 }
 
-#define RPM_FROM_REG(val)	(val*60)
-
 static ssize_t show_fan_input (struct fscher_data *data, char *buf, int nr)
 {
-	return sprintf(buf, "%u\n", RPM_FROM_REG(data->fan_act[FAN_INDEX_FROM_NUM(nr)]));
+	return sprintf(buf, "%u\n", 60 * data->fan_ripple[nr - 1] *
+					 data->fan_rps[nr - 1] / 2);
 }
 
 
