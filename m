From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Thu, 20 Dec 2007 15:42:59 +0000
Subject: Re: [lm-sensors] PATCH: hwmon-fschmd-use-dmi-tables.patch
Message-Id: <476A8D83.5090109@hhs.nl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------070605080208050506050101"
List-Id: <lm-sensors.vger.kernel.org>
References: <47669C8B.2080507@hhs.nl>
In-Reply-To: <47669C8B.2080507@hhs.nl>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------070605080208050506050101
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jean Delvare wrote:
> Hi Hans,
> 
> On Mon, 17 Dec 2007 16:58:03 +0100, Hans de Goede wrote:
>> This patch adds support to the fschmd driver for reading the voltage scaling
>> factors from BIOS DMI tables, as specified in the Siemens datasheet.
>>
>> Notice that this patch depends on the patch to the in kernel DMI parser titled:
>> "dmi: Let drivers walk the DMI table" by Jean Delvare:
>> http://lists.lm-sensors.org/pipermail/lm-sensors/2007-November/021864.html
>>
>> Signed-off-by: Hans de Goede <j.w.r.degoede@hhs.nl>
> 
> Looks good to me, I have mainly cosmetic comments:
> 

Thanks,

All fixed, new version attached.

Regards,

Hans

--------------070605080208050506050101
Content-Type: text/x-patch;
 name="hwmon-fschmd-use-dmi-tables-v2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hwmon-fschmd-use-dmi-tables-v2.patch"

This patch adds support to the fschmd driver for reading the voltage scaling
factors from BIOS DMI tables, as specified in the Siemens datasheet.

This is the second version featuring several small cleanups as a result of the
review by Jean Delvare.

Notice that this patch depends on the patch to the in kernel DMI parser titled:
"dmi: Let drivers walk the DMI table" by Jean Delvare:
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-November/021864.html

Signed-off-by: Hans de Goede <j.w.r.degoede@hhs.nl>
diff -up vanilla-2.6.24-rc5-git3/drivers/hwmon/fschmd.c.orig vanilla-2.6.24-rc5-git3/drivers/hwmon/fschmd.c
--- vanilla-2.6.24-rc5-git3/drivers/hwmon/fschmd.c.orig	2007-12-17 16:44:05.000000000 +0100
+++ vanilla-2.6.24-rc5-git3/drivers/hwmon/fschmd.c	2007-12-20 14:09:12.000000000 +0100
@@ -41,6 +41,7 @@
 #include <linux/err.h>
 #include <linux/mutex.h>
 #include <linux/sysfs.h>
+#include <linux/dmi.h>
 
 /* Addresses to scan */
 static unsigned short normal_i2c[] = { 0x73, I2C_CLIENT_END };
@@ -210,6 +211,13 @@ struct fschmd_data {
 	u8 fan_ripple[6];	/* divider for rps */
 };
 
+/* Global variables to hold information read from special DMI tables, which are
+   available on FSC machines with an fscher or later chip. */
+static int dmi_mult[3] = { 490, 200, 100 };
+static int dmi_offset[3] = { 0, 0, 0 };
+static int dmi_vref = -1;
+
+
 /*
  * Sysfs attr show / store functions
  */
@@ -221,8 +229,13 @@ static ssize_t show_in_value(struct devi
 	int index = to_sensor_dev_attr(devattr)->index;
 	struct fschmd_data *data = fschmd_update_device(dev);
 
-	return sprintf(buf, "%d\n", (data->volt[index] *
-		max_reading[index] + 128) / 255);
+	/* fscher / fschrc - 1 as data->kind is an array index, not a chips */
+	if (data->kind == (fscher - 1) || data->kind >= (fschrc - 1))
+		return sprintf(buf, "%d\n", (data->volt[index] * dmi_vref *
+			dmi_mult[index]) / 255 + dmi_offset[index]);
+	else
+		return sprintf(buf, "%d\n", (data->volt[index] *
+			max_reading[index] + 128) / 255);
 }
 
 
@@ -525,6 +538,68 @@ static struct sensor_device_attribute fs
  * Real code
  */
 
+/* DMI decode routine to read voltage scaling factors from special DMI tables,
+   which are available on FSC machines with an fscher or later chip. */
+static void fschmd_dmi_decode(const struct dmi_header *header)
+{
+	int i, mult[3] = { 0 }, offset[3] = { 0 }, vref = 0, found = 0;
+
+	/* dmi code ugliness, we get passed the address of the contents of
+	   a complete DMI record, but in the form of a dmi_header pointer, in
+	   reality this address holds header->length bytes of which the header
+	   are the first 4 bytes */
+	u8 *dmi_data = (u8 *)header;
+
+	/* We are looking for OEM-specific type 185 */
+	if (header->type != 185)
+		return;
+
+	/* we are looking for what Siemens calls "subtype" 19, the subtype
+	   is stored in byte 5 of the dmi block */
+	if (header->length < 5 || dmi_data[4] != 19)
+		return;
+
+	/* After the subtype comes 1 unknown byte and then blocks of 5 bytes,
+	   consisting of what Siemens calls an "Entity" number, followed by
+	   2 16-bit words in LSB first order */
+	for (i = 6; (i + 4) < header->length; i += 5) {
+		/* entity 1 - 3: voltage multiplier and offset */
+		if (dmi_data[i] >= 1 && dmi_data[i] <= 3) {
+			/* Our in sensors order and the DMI order differ */
+			const int shuffle[3] = { 1, 0, 2 };
+			int in = shuffle[dmi_data[i] - 1];
+
+			/* Check for twice the same entity */
+			if (found & (1 << in))
+				return;
+
+			mult[in] = dmi_data[i + 1] | (dmi_data[i + 2] << 8);
+			offset[in] = dmi_data[i + 3] | (dmi_data[i + 4] << 8);
+
+			found |= 1 << in;
+		}
+
+		/* entity 7: reference voltage */
+		if (dmi_data[i] == 7) {
+			/* Check for twice the same entity */
+			if (found & 0x08)
+				return;
+
+			vref = dmi_data[i + 1] | (dmi_data[i + 2] << 8);
+
+			found |= 0x08;
+		}
+	}
+
+	if (found == 0x0F) {
+		for (i = 0; i < 3; i++) {
+			dmi_mult[i] = mult[i] * 10;
+			dmi_offset[i] = offset[i] * 10;
+		}
+		dmi_vref = vref;
+	}
+}
+
 static int fschmd_detect(struct i2c_adapter *adapter, int address, int kind)
 {
 	struct i2c_client *client;
@@ -586,6 +661,17 @@ static int fschmd_detect(struct i2c_adap
 		data->temp_max[2] = 50 + 128;
 	}
 
+	/* Read the special DMI table for fscher and newer chips */
+	if (kind == fscher || kind >= fschrc) {
+		dmi_walk(fschmd_dmi_decode);
+		if (dmi_vref == -1) {
+			printk(KERN_WARNING FSCHMD_NAME
+				": Couldn't get voltage scaling factors from "
+				"BIOS DMI table, using builtin defaults\n");
+			dmi_vref = 33;
+		}
+	}
+
 	/* i2c kind goes from 1-5, we want from 0-4 to address arrays */
 	data->kind = kind - 1;
 	strlcpy(client->name, client_names[data->kind], I2C_NAME_SIZE);

--------------070605080208050506050101
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------070605080208050506050101--

