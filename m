From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:32 +0000
Subject: Preliminary version of the sis5595 driver for Linux 2.6
Message-Id: <2y0sE5NY.1106648604.2705990.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050125003630.GA21545@bode.aurel32.net>
In-Reply-To: <20050125003630.GA21545@bode.aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Aurelien,

> As I already said to Jean Delvare, I started to port the sis5595 driver
> to Linux 2.6. Here is my preliminary version, it would be nice if
> somebody could review it. Thanks!

Great job. See my comments inline.

> Some notes
> ----------
> 1) In the sis5595_find_sis() function, I am not sure about the use of
>    printk. I can't replace them by dev_err() as i2c_adapter is not
>    available.

The use of printk in this case looks OK to me.

+static int blacklist[] = {
+			PCI_DEVICE_ID_SI_540,
+			PCI_DEVICE_ID_SI_550,
+			PCI_DEVICE_ID_SI_630,
+			PCI_DEVICE_ID_SI_730,
+			PCI_DEVICE_ID_SI_5511, /* 5513 chip has the 0008 device but
+						  that ID shows up in other chips so we
+						  use the 5511 ID for recognition */
+			PCI_DEVICE_ID_SI_5597,
+			PCI_DEVICE_ID_SI_5598,
+			0x645,
+			0x735,
+                          0 };

0x645 and 0x735 are defined in linux/pci_ids.h as:
#define PCI_DEVICE_ID_SI_645            0x0645
#define PCI_DEVICE_ID_SI_735            0x0735
So you can use these names.

Watch the identation on last line.

+/*
+   SiS southbridge has a LM78-like chip integrated on the same IC.
+   This driver is a customized copy of lm78.c
+*/

I would suggest that you move that comment to the heading comment block -
this explains why the driver exists at all so this is the first comment
one would want to read.

+static inline u8 FAN_TO_REG(long rpm, int div)
+{
+	if (rpm = 0)
+		return 255;
+	rpm = SENSORS_LIMIT(rpm, 1, 1000000);
+	return SENSORS_LIMIT((1350000 + rpm * div / 2) / (rpm * div), 1, 254);
+}

Any chance you could rewrite this one so as to call SENSORS_LIMIT only
once?

+/* TEMP: mC (-128C to +127C)
+   REG: 0.83C/bit + 52.12, two's complement  */

If the all registers value are possible (-128 to +127) then the possible
temperature range is from -54.12 to +157.53 degree C, not -128 to +127.

+static inline int TEMP_FROM_REG(u8 val)
+{
+	return (val>=0x80 ? val-0x100 : val) * 830 + 5212;
+}

That would be + 52120.

You may also save some tests by handling the temperature register as s8
instead of u8.

+static inline u8 TEMP_TO_REG(int val)
+{
+	int nval = SENSORS_LIMIT(val, -128000, 127000) ;
+	return nval<0 ? (nval-5212-415)/830+0x100 : (nval-5212+415)/830;
+}

Ditto. Also, you either want to move the SENSORS_LIMIT after the
computation, or use the limit values I gave above.

+/* ALARMS: chip-specific bitmask
+   REG: (same) */
+#define ALARMS_FROM_REG(val) (val)

Maybe you could get rid of it completely?

+/* FAN DIV: 1, 2, 4, or 8 (defaults to 2)
+   REG: 0, 1, 2, or 3 (respectively) (defaults to 1) */
+static inline u8 DIV_TO_REG(int val)
+{
+	return val=8 ? 3 : val=4 ? 2 : val=1 ? 0 : 1;
+}

A better behavior would be to accept only these 4 values, and return an
error on other values instead of arbitrarily and silently defaulting to
a divider of 2. See the fscher driver for an example.

+/* For the SIS5595, we need to keep some data in memory. That
+   data is pointed to by sis5595_list[NR]->data. The structure itself is
+   dynamically allocated, at the time when the new sis5595 client is
+   allocated. */

That comment is totally outdated (even for the lm_sensors/CVS driver, it
is).

+	u8 temp_over;		/* Register value  - really max */
+	u8 temp_hyst;		/* Register value  - really min */

Why don't you simply rename them to temp_max and temp_min then? OTOH the
rest of the driver (including the sysfs file names) suggests that these
really are over and hyst. Can you please check again?

+/* The driver. I choose to use type i2c_driver, as at is identical to
both
+   smbus_driver and isa_driver, and clients could be of either kind */

Outdated comment (which I suspect was never correct for this driver
anyway), discard.

+#define show_in_offset(offset)					\
+static ssize_t							\
+	show_in##offset (struct device *dev, char *buf)		\
+{								\
+	return show_in(dev, buf, 0x##offset);			\
+}								\

Please get rid of all these 0x## all over the code. Mark Hoffman cleaned
up all drivers some months ago, we better don't reintroduce this
ugliness now.

+static ssize_t set_fan_1_div(struct device *dev, const char *buf,
+		size_t count)
+{
+	return set_fan_div(dev, buf, count, 0) ;
+}
+
+static ssize_t set_fan_2_div(struct device *dev, const char *buf,
+		size_t count)
+{
+	return set_fan_div(dev, buf, count, 1) ;
+}
+
+show_fan_offset(1);
+show_fan_offset(2);

It would probably be better to swap these, i.e. call show_fan_offset()
right after you define it, and move to the dividers only after.

+static ssize_t show_alarms(struct device *dev, char *buf)
+{
+	struct sis5595_data *data = sis5595_update_device(dev);
+	return sprintf(buf, "%d\n", ALARMS_FROM_REG(data->alarms));
+}

data->alarms is unsigned, so that would be %u, not %d.

+int sis5595_detect(struct i2c_adapter *adapter, int address, int kind)

With the current i2c_detect() implementation, detect function are not
supposed to return an error (non-zero value) on non-fatal errors such as
a missing device. Thus you should get rid of all "err = -ENODEV;".

+	if (!request_region(address, SIS5595_EXTENT, "sis5595")) {

Please use sis5595_driver.name for as the name for requesting the region,
os as to avoid string duplication.

+	if(data->revision < REV2MIN) {
+		data->maxins = 3;
+	} else {
+		pci_read_config_byte(s_bridge, SIS5595_PIN_REG, &val);
+		if(val & 0x80)
+			/* 4 voltages, 1 temp */
+			data->maxins = 3;
+		else
+			/* 5 voltages, no temps */
+			data->maxins = 4;
+	}

This code could probably be made more simple if you were initializing
data->maxins to 3 in the first place. I believe this is the most common
case anyway?

+	/* release ISA region first */
+	if(i2c_is_isa_client(client))
+		release_region(client->addr, SIS5595_EXTENT);
+
+	/* now it's safe to scrap the rest */
+	if ((err = i2c_detach_client(client))) {
+		dev_err(&client->dev,
+		    "Client deregistration failed, client not detached.\n");
+		return err;
+	}

Hm, shouldn't it precisely be done in the contrary order? As long as the
client is attached, people can access the sysfs files. If the region is
already released this will lead to I/O on a released region. As a matter
of fact, the order in the original sis5595 driver used the order I
suggest.

+   There are some ugly typecasts here, but the good news is - they should
+   nowhere else be necessary! */

Old comment, drop.

Rest is fine with me. Feel free to put youself in MODULE_AUTHOR() instead
of Ky?sti.

I would appreciate if you could backport to the lm_sensors/CVS driver all
changes made to the 2.6 driver that would also make sense there.

Thanks,
--
Jean Delvare
