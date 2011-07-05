From: Luca Tettamanti <kronos.it@gmail.com>
Date: Tue, 05 Jul 2011 19:51:59 +0000
Subject: Re: [lm-sensors] Using Asus P5Q-E sensors/pwm
Message-Id: <20110705195159.GA21510@nb-core2.darkstar.lan>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110628194643.GM21173@epicure.lazyet.homelinux.net>
In-Reply-To: <20110628194643.GM21173@epicure.lazyet.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Jun 30, 2011 at 01:47:15PM +0200, Jean Delvare wrote:
> On Thu, 30 Jun 2011 13:34:48 +0200, Luca Tettamanti wrote:
> > On Thu, Jun 30, 2011 at 12:19 PM, Etienne Buira
> > > Yeah, I know about q-fan, but it doesn't gives enough air in some
> > > situations, even in turbo mode
> 
> Is it OK if you disable smart fan control altogether? If even the
> fastest smart fan setting doesn't work for you, then maybe your cooling
> solution is simply not adequate.
> 
> > > (...)
> > > If none, do you know if an acpi compatible solution is on cooking time?
> > > Or would it be possible/not too hard to implement? (I might volunteer to
> > > write some code, if I'm directed in some way to relevant docs)
> > 
> > The interface does not seem complicated, but I feel I'm still missing
> > something... e.g on my old P5B-E Q-FAN setting were applied only after
> > a reboot, on a newer M4A79XTD nothing happens, while my M5A78L seems
> > to work correctly...
> 
> Would you mind sharing your code? I would love to give it a try and
> report how it goes on my P5QL Pro.

Sorry for the delay... busy week :)
Patch is attached. It adds a new file (sitm) to the debugfs interface.
Select the id of the Q-FAN profile control (in your case 0x04080011):

echo 0x04070011 > /sys/kernel/debug/asus_atk0110/id

and reprogram it:

echo 0x0000000100000001 > /sys/kernel/debug/asus_atk0110/sitm

The 64 bit value is actually two 32 bit params packaged together, the
first is the value to program (0 = optimal, 1 = silent, 2 performance), the second one... is a mistery, on your board is not used
though.
The return value of the method is also different from what I was
expecting, so the code path with the debug statement won't be triggered.

diff --git a/drivers/hwmon/asus_atk0110.c b/drivers/hwmon/asus_atk0110.c
index dcb78a7..067f507 100644
--- a/drivers/hwmon/asus_atk0110.c
+++ b/drivers/hwmon/asus_atk0110.c
@@ -784,6 +784,43 @@ static const struct file_operations atk_debugfs_ggrp_fops = {
 	.llseek		= no_llseek,
 };
 
+static int atk_debugfs_sitm_set(void *p, u64 val)
+{
+	struct atk_data *data = p;
+	union acpi_object *ret;
+	struct atk_acpi_input_buf sitm;
+	struct atk_acpi_ret_buffer *buf;
+	int err = 0;
+
+	if (!data->write_handle)
+		return -ENODEV;
+
+	if (!data->debugfs.id)
+		return -EINVAL;
+
+	sitm.id = data->debugfs.id;
+	sitm.param1 = (val & 0xffffffff00000000) >> 32;
+	sitm.param2 = (val & 0xffffffff);
+
+	ret = atk_sitm(data, &sitm);
+	if (IS_ERR(ret))
+		return PTR_ERR(ret);
+
+	buf = (struct atk_acpi_ret_buffer *)ret->buffer.pointer;
+	if (buf->flags) {
+		if (sitm.id & ATK_CLASS_MASK = ATK_CLASS_FAN_CTL &&
+				buf->flags & 0x2)
+			dev_dbg(&data->acpi_dev->dev,
+					"%#llu updated\n", sitm.id);
+	} else {
+		err = -EIO;
+	}
+
+	ACPI_FREE(ret);
+
+	return err;
+}
+
 static void atk_debugfs_init(struct atk_data *data)
 {
 	struct dentry *d;

-- 
"It is more complicated than you think"
                -- The Eighth Networking Truth from RFC 1925

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
