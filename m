From: Richard Retanubun <RichardRetanubun@RuggedCom.com>
Date: Thu, 18 Nov 2010 20:03:15 +0000
Subject: [lm-sensors] [RFC] [PATCH v2] ltc4215: Save the fault register at
Message-Id: <1290110595-29227-1-git-send-email-RichardRetanubun@RuggedCom.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Some bits in the fault register can be useful to differentiate
between a planned reset (reboot) or an unplanned reset (pwr-loss).
The EN bit can be used for this detection when a board's planned
reboot action toggles the EN bit and cuts the regulated voltage
(but keeping the hotswap device alive), meanwhile an unplanned
reset (pwr-loss) will not have the EN bit set because even the
hotswap device got powered off.

So, before clearing the fault register at boot, save the contents
of the fault register so that other tools can use it as a forensic
marker to differentiate events that preceeds this boot.

One proposed method to make this information available is via
sysfs device attributes.
---
Hi Ira & Guenter,

Wow, thanks for the lively discussions, I never expected this corner
of the kernel to be so actively monitored :)

Here is the proposed V2 of the patch, allowing the values to be
accessed via sysfs.

Now, to answer/comment on your feeback so far:

[Guenter]
* This violates sysfs abi: 
Well, is this not a living document/spec? Maybe my choice of path/variable
does not map well into the existing abi, but this is not to say it cannot be
extended, no? (I must admit I am a bit unaware of all the rules/convention of the ABI)

* The use of EN bit requires "Lots of context knowledge":
Certainly it does! this is how it is used on my board, I thought it was cool,
I am not sure if it is the 'standard' way of doing things.
The second point out of this is, Precisely for the reason that the bits in
fault registers can only be parsed correctly once one understood the context 
on the board, I deliberately choose not to parse/label the significance of the bits.
This is up to how each board choses to connect the device to do.

[Ira]
* Use uboot to store the data:
Not feasible if one have products already shipping with uboots that does not
support it. Besides, not all bootloaders are as easily expandable as uboot.

* i2c poking after the fact:
nice!, this actually works even when the driver is loaded (even with this mod)
however, this does not solve displaying the saved value at boot.

[Both]
* Store the info of SW-triggered reboot elsewhere, do not use EN:
Sounds good, until you consider what happen when the SW-Hang and
the HW-Watchdog have to reboot the board, who is going to store
the value in NVram?

In truth, you are both correct, having EN bit be recorded and parsed 
is only half the knowledge, I indeed poke something into an NVRam 
when software knows it wants to reboot. Obviously the place and
meaning is *very* board specific, which is why I can't mainline it.

With both markers, I can detect all 3 causes of reboot on my board:
* SW-Commanded-Reboot:					  EN=1; NVRam=Set
* HW-Watchdog poking EN because SW hangs: EN=1, NVRam=NotSet
* ExternalPowerloss:					  EN=0, NVRam=NotSet

So here is v2; I realize this have little hope of mainlining,
I know its an ugly hack on the sysfs ABI, if someone have an
idea of a better sysfs path to pick, do let me know.

If not, well at least the idea is out there for other folks.

Thanks for everyone's time

- Richard Retanubun

 drivers/hwmon/ltc4215.c |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/drivers/hwmon/ltc4215.c b/drivers/hwmon/ltc4215.c
index 40ebdfc..2a1125f 100644
--- a/drivers/hwmon/ltc4215.c
+++ b/drivers/hwmon/ltc4215.c
@@ -45,6 +45,8 @@ struct ltc4215_data {
 
 	/* Registers */
 	u8 regs[7];
+	/* Fault-reg-at-boot */
+	u8 faultreg_at_boot;
 };
 
 static struct ltc4215_data *ltc4215_update_device(struct device *dev)
@@ -197,6 +199,16 @@ static ssize_t ltc4215_show_alarm(struct device *dev,
 	return snprintf(buf, PAGE_SIZE, "%u\n", (reg & mask) ? 1 : 0);
 }
 
+static ssize_t ltc4215_show_fault(struct device *dev,
+				    struct device_attribute *da,
+				    char *buf)
+{
+	struct ltc4215_data *data = ltc4215_update_device(dev);
+
+	return snprintf(buf, PAGE_SIZE, "now 0x%0X, at-boot 0x%0X\n", 
+			data->regs[LTC4215_FAULT], data->faultreg_at_boot);
+}
+
 /* These macros are used below in constructing device attribute objects
  * for use with sysfs_create_group() to make a sysfs device file
  * for each register.
@@ -218,6 +230,10 @@ static ssize_t ltc4215_show_alarm(struct device *dev,
 	static SENSOR_DEVICE_ATTR_2(name, S_IRUGO, \
 	ltc4215_show_alarm, NULL, (mask), reg)
 
+#define LTC4215_FAULT(name) \
+	static SENSOR_DEVICE_ATTR(name, S_IRUGO, \
+	ltc4215_show_fault, NULL, 0);
+
 /* Construct a sensor_device_attribute structure for each register */
 
 /* Current */
@@ -236,6 +252,9 @@ LTC4215_ALARM(in1_min_alarm,	(1 << 1),	LTC4215_STATUS);
 /* Output Voltage */
 LTC4215_VOLTAGE(in2_input,			LTC4215_SOURCE);
 
+/* Fault Register */
+LTC4215_FAULT(fault);
+
 /* Finally, construct an array of pointers to members of the above objects,
  * as required for sysfs_create_group()
  */
@@ -252,6 +271,8 @@ static struct attribute *ltc4215_attributes[] = {
 
 	&sensor_dev_attr_in2_input.dev_attr.attr,
 
+	&sensor_dev_attr_fault.dev_attr.attr,
+
 	NULL,
 };
 
@@ -275,6 +296,10 @@ static int ltc4215_probe(struct i2c_client *client,
 		goto out_kzalloc;
 	}
 
+	/* Save fault register status at boot, before clearing it */
+	data->faultreg_at_boot = i2c_smbus_read_byte_data(client,
+							  LTC4215_FAULT);
+
 	i2c_set_clientdata(client, data);
 	mutex_init(&data->update_lock);
 
-- 
1.7.2.3


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
