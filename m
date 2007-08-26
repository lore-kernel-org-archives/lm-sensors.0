From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Sun, 26 Aug 2007 18:49:51 +0000
Subject: Re: [lm-sensors] PATCH: hwmon-f71882fg-new-driver-v2.patch
Message-Id: <20070826184951.GA3679@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <4697714B.9090606@hhs.nl>
In-Reply-To: <4697714B.9090606@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans:

* Hans de Goede <j.w.r.degoede@hhs.nl> [2007-07-13 14:34:19 +0200]:
> Hi all,
> 
> Here is the second version of my fintek f71882fg driver. Many thanks to 
> Darrick J. Wong for the review.

Applied to hwmon-2.6.git/testing (with much trailing whitespace deleted), thanks.
Some additional text in Documenation/hwmon would be nice.

Also, I've applied the following patch on top of yours...

commit 9b4ed78e6e9a64ad4f9f40e6895b207316106d79
Author: Mark M. Hoffman <mhoffman@lightlink.com>
Date:   Tue Aug 21 23:10:46 2007 -0400

    hwmon: (f71882fg) trivial whitespace cleanup
    
    Signed-off-by: Mark M. Hoffman <mhoffman@lightlink.com>

diff --git a/drivers/hwmon/f71882fg.c b/drivers/hwmon/f71882fg.c
index 68f5102..b4ff0f9 100644
--- a/drivers/hwmon/f71882fg.c
+++ b/drivers/hwmon/f71882fg.c
@@ -384,7 +384,7 @@ static struct f71882fg_data *f71882fg_update_device(struct device * dev)
 	}
 
 	/* Update every second */
-	if (time_after(jiffies, data->last_updated + HZ) || !data->valid)  {
+	if (time_after(jiffies, data->last_updated + HZ) || !data->valid) {
 		data->temp_status = f71882fg_read8(data,
 						F71882FG_REG_TEMP_STATUS);
 		data->temp_diode_open = f71882fg_read8(data,
@@ -614,7 +614,7 @@ static ssize_t store_temp_max_hyst(struct device *dev, struct device_attribute
 	data->temp_hyst[nr] = val;
 
 	/* convert value to register contents */
-	switch(nr) {
+	switch (nr) {
 		case 0:
 			val = val << 4;
 			break;
@@ -748,7 +748,7 @@ static int __devinit f71882fg_probe(struct platform_device * pdev)
 	int err, i;
 	u8 start_reg;
 
-	if(!(data = kzalloc(sizeof(struct f71882fg_data), GFP_KERNEL)))
+	if (!(data = kzalloc(sizeof(struct f71882fg_data), GFP_KERNEL)))
 		return -ENOMEM;
 
 	data->addr = platform_get_resource(pdev, IORESOURCE_IO, 0)->start;
@@ -850,7 +850,7 @@ static int __init f71882fg_find(int sioaddr, unsigned short *address)
 	}
 
 	superio_select(sioaddr, SIO_F71882FG_LD_HWM);
-	if (!(superio_inb(sioaddr, SIO_REG_ENABLE) & 0x01))  {
+	if (!(superio_inb(sioaddr, SIO_REG_ENABLE) & 0x01)) {
 		printk(KERN_WARNING DRVNAME ": Device not activated\n");
 		goto exit;
 	}
@@ -890,18 +890,18 @@ static int __init f71882fg_device_add(unsigned short address)
 	int err;
 
 	f71882fg_pdev = platform_device_alloc(DRVNAME, address);
-	if(!f71882fg_pdev)
+	if (!f71882fg_pdev)
 		return -ENOMEM;
 
 	res.name = f71882fg_pdev->name;
 	err = platform_device_add_resources(f71882fg_pdev, &res, 1);
-	if(err) {
+	if (err) {
 		printk(KERN_ERR DRVNAME ": Device resource addition failed\n");
 		goto exit_device_put;
 	}
 
 	err = platform_device_add(f71882fg_pdev);
-	if(err) {
+	if (err) {
 		printk(KERN_ERR DRVNAME ": Device addition failed\n");
 		goto exit_device_put;
 	}
-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
