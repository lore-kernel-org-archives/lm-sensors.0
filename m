From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Wed, 31 Oct 2007 08:42:38 +0000
Subject: [lm-sensors] PATCH:
Message-Id: <47283FFE.4000105@hhs.nl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------080106040703050906060905"
List-Id: <lm-sensors.vger.kernel.org>
References: <46F3DD44.4070307@hhs.nl>
In-Reply-To: <46F3DD44.4070307@hhs.nl>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------080106040703050906060905
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi All,

As discussed on the lm-sensors list, using the fixed scaling factors from the
fscpos datasheet for the fscher and newer models as wel, was nood a good idea,
as the actual scaling factors may be different and can be read from OEM DMI
entries.

This patch changes the behaviour of the merged FSC familiy fschmd driver to be
the same as the old standalone fscher driver for fscher and newer models,
leaving the scaling to userspace.

This also preserves compatibility of existing sensors.conf files.

Signed-of-by: Hans de Goede <j.w.r.degoede@hhs.nl>

---

Jean, can you review this please?
Mark, can you send this to Linus for 2.6.24 please, otherwise we will have one 
official kernel release with different scaling for the voltage inputs of the 
fschmd compared to the next releases.


And yes I tested my patch this time.

Thanks & Regards,

Hans

--------------080106040703050906060905
Content-Type: text/x-patch;
	name="hwmon-fschmd-fscher-and-newer-no-fixed-scaling.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename*0="hwmon-fschmd-fscher-and-newer-no-fixed-scaling.patch"

As discussed on the lm-sensors list, using the fixed scaling factors from the
fscpos datasheet for the fscher and newer models as wel, was nood a good idea,
as the actual scaling factors may be different and can be read from OEM DMI
entries.

This patch changes the behaviour of the merged FSC familiy fschmd driver to be
the same as the old standalone fscher driver for fscher and newer models,
leaving the scaling to userspace.

This also preserves compatibility of existing sensors.conf files.

Signed-of-by: Hans de Goede <j.w.r.degoede@hhs.nl>

diff -up linux-2.6.24-rc1-git7/drivers/hwmon/fschmd.c~ linux-2.6.24-rc1-git7/drivers/hwmon/fschmd.c
--- linux-2.6.24-rc1-git7/drivers/hwmon/fschmd.c~	2007-10-30 22:30:43.000000000 +0100
+++ linux-2.6.24-rc1-git7/drivers/hwmon/fschmd.c	2007-10-30 22:30:43.000000000 +0100
@@ -221,8 +221,17 @@ static ssize_t show_in_value(struct devi
 	int index = to_sensor_dev_attr(devattr)->index;
 	struct fschmd_data *data = fschmd_update_device(dev);
 
-	return sprintf(buf, "%d\n", (data->volt[index] *
-		max_reading[index] + 128) / 255);
+	/* Only use fixed scaling factor for the fscpos and fscscy, the newer
+	   models have the scaling factors stored in the BIOS DMI tables, so
+	   here we use a scale of 10mv / step like the standalone fscher driver
+	   does (did) and let userspace do the real scaling. There is a
+	   userspace utility called fscher-dmi2compute to generate the proper
+	   compute lines from the DMI info for the fscher and newer chips. */
+	if (data->kind == (fscpos - 1) || data->kind == (fscscy - 1))
+		return sprintf(buf, "%d\n", (data->volt[index] *
+			max_reading[index] + 128) / 255);
+	else
+		return sprintf(buf, "%d\n", data->volt[index] * 10);
 }
 
 

--------------080106040703050906060905
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------080106040703050906060905--

