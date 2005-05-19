From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:33 +0000
Subject: GL520SM driver
Message-Id: <a95G5pYS.1106839360.8506490.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050127104814.GA840@frans.deprez-aerts.dyndns.org>
In-Reply-To: <20050127104814.GA840@frans.deprez-aerts.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hello Maarten,

> I ported the driver for the GL520SM chip to linux 2.6 . It is only tested
> on my hardware; maybe some others could also test it? For me, it seems to
> work fine.

Some times ago I met someone on IRC (#linux-sensors) who told he was
working on a port of the gl520sm driver to Linux 2.6. Was it you?

This chip isn't much used, I don't think that any of us has one to test
your driver, unfortunately.

> Also, some changes to the lm_sensors library chips.c were needed for
> makeing it find its way through the sysfs interface (included in the 
> patch).

Looks fine to me, will apply this evening.

> Note that i also had to apply another patch (see m7101.patch) to
> un-hide the Ali M7101 PMU to which the GL520SM is connected. In the
> lm_sensors package is included a module for linux 2.4 to "hotplug"
> this device if it is hidden. This patch patches drivers/pci/quirks.c,
> as it is really a bug in the BIOS.

You are right, this is the correct location for such a BIOS workaround.
The trick to unhide the P4B and other Asus boards SMBus is already there.

> Maybe it should be integrated into the kernel or at least be included in
> the lm_sensors package? I found it on the linux kernel mailing list.

You're right, it should be included in the kernel. There is no room for
this in the lm_sensors project since this project only covers the 2.4
kernels (let alone user-space tools).

Comments about the m7101 patch:

* It is way too verbose.
* It doesn't respect the kernel coding style.
* I am surprised that you need to include "pci.h". There are a lot of
other entried in this file doing the same kind of operations. If they
don't need it, I guess there is a reason and possibly your code could
do without it.

Please note however that I am not qualified to review the details of this
patch, nor to push it upstreams. You will have to find someone else who
is (but please address the verbosity and coding style issues before you
do).

> This chip can be configured to read either a second temperature sensor or
> a fourth voltage sensor. The user can configure this through the
> two_temps file. If it contains "1" the temp2_* files are valid and if it
> contains "0" the in4_* files are valid. I think it would make sense to
> remove the irrelevant files from the directory instead of leaving dummy
> files, but i think the library needs some changes therefor.

I do not think that this is the correct approach. The correct chip
configuration depends on the way the chip was wired, and the BIOS should
hopefully have configured it properly before the driver is loaded. Is it
the case for you? If it is, you can get rid of this "two_temps" file,
and simply trust the original chip configuration. As you suggested, you
should then not create the files that make no sense in the current
configuration.

The libsensors library won't have to be modified, but the sensors
program will. It is a straightforward change however (simply discard
error messages when an optional file isn't found) and has already been
done for several other drivers. Just send us a patch.

My comments on the code itself now:

+#include <linux/config.h>

You don't really need this, do you?

+#define GL520_REG_CHIP_ID 0x00
+#define GL520_REG_REVISION 0x01
+#define GL520_REG_VID 0x02
(...)

Would be way more readable if you would align all values (using tabs!).

+/* Conversions. Rounding and limit checking is only done on the TO_REG
+   variants. Note that you should be a bit careful with which arguments
+   these macros are called: arguments may be evaluated more than once.
+   Fixing this is just not worth it. */

That old comment sucks, just kill it.

+#define DIV_TO_REG(val) ((val)=4?2:(val)=2?1:(val)=1?0:3)

Instead of defaulting to an arbitrary value, we now return an error when
one tries to set an unsupported value. This means that this macro is
replaced by real code in the set_fan_div function. See the fscher driver
(in Linux 2.6) for an example.

+static inline u8 FAN_TO_REG(long rpm, int div)
+{
+	if (rpm = 0)
+		return 0;
+	div = DIV_FROM_REG(div);
+	rpm = SENSORS_LIMIT(rpm, 1, 1920000) * div;
+	return SENSORS_LIMIT((960000 + rpm / 2) / rpm, 1, 255);
+}

You should be able to have only one call to SENSORS_LIMIT if you return 0
on rpm <= 0 (instead of only = 0).

+#define VID_FROM_REG(val)
((val)=0x1f?0:(val)>=0x10?5100-(val)*100:2050-(val)*50)

This only works for one VRM version. I know that the GL520SM is old and
used one very few systems, but you should still consider using the
standard functions in i2c-vid.h and i2c-sensor-vid.c to handle VID in
your driver. Take a look at the way other drivers do.

+#define ALARMS_FROM_REG(val) val

Useless macro, get rid of it.

+#define BEEP_MASK_TO_REG(val) (val & data->alarm_mask)

Missing parentheses around val.

+#define BEEP_MASK_FROM_REG(val) (val)

Useless too, get rid of it.

+struct gl520_data {
+	struct i2c_client client;
+	enum chips type;

You never use "type" in the code, which is quite logical since the
driver supports a single chip type. Kill it.

+	u8 fan_off;		/* Boolean */

What is this?

+/*
+ * Internal variables
+ */
+
+static int gl520_id = 0;
+

This is gone in kernel 2.6.11-rc2.

+#define get_if(name, value, cond)					\
+static ssize_t get_##name(struct device *dev, char *buf)		\
+{									\
+	struct gl520_data *data = gl520_update_device(dev);		\
+	return sprintf(buf, "%d\n", (cond) ? value : 0);		\
+}

Useless. You will only create the file if it matches the chip
configuration.

Your "set" macros aren't exactly readable. They make the code compact,
right, but I am not certain it is worth it. I wouldn't want to have to
track a bug down in there.

+	/* Determine the chip type. */
+	if (gl520_read_value(new_client, GL520_REG_CHIP_ID) != 0x20) {
+		dev_info(&adapter->dev,
+		    "Ignoring 'force' parameter for unknown "
+		    "chip at adapter %d, address 0x%02x\n",
+		    i2c_adapter_id(adapter), address);
+		goto exit_free;
+	} else {
+		kind = gl520sm;
+	}

The message isn't correct, as it may be displayed even if the force
parameter wasn't used. And actually this code doesn't honor the force
parameter. This parameter should allow one to skip the detection of the
chip. This should look like:

if (kind < 0) {
    if (gl520_read_value(new_client, GL520_REG_CHIP_ID) != 0x20) {
        dev_dbg(&new_client->dev, "Unsupported chip id 0x%02x,
skipping\n");
         goto exit_free;
    }
}

Don't bother setting kind = gl520sm, you never use it after that.

Also, this detection is rather weak. Are there no other registers we can
use to improve the detection? The sensors-detect script suggests that
bit 7 of register 0x03 (configuration) should always be cleared. It also
mentions revision register at 0x01 being possibly always equal to 0. Do
you confirm this is the case for you?

I would appreciate a dump of your chip for my collection, BTW.

+	new_client->id = gl520_id++;
+	data->type = kind;

Kill these ones.

+/* OK, this is not exactly good programming practice, usually. But it is
+   very code-efficient in this case. */

Kill that old comment too.

+/* Registers 0x07 to 0x0c are word-sized, others are byte-sized
+   GL520 uses a high-byte first convention, which is exactly opposite to
+   the usual practice. */

Please remove the "which is exactly opposite to the usual practice".
All chips actually do it that way.

Rest of the code is fine with me. Feel free to remove the other names in
MODULE_AUTHOR.

Thanks,
--
Jean Delvare
