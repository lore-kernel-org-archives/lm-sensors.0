From: Andre Prendel <andre.prendel@gmx.de>
Date: Wed, 06 May 2009 07:17:41 +0000
Subject: [lm-sensors] [PATCH] k8temp: Unset driver data in exit_remove
Message-Id: <20090506071741.GA4386@ubuntu>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean, Rudolf,

after infiltrating the sensors user space part, I think it's time to
dive into kernel space. So I took a look at some of the sensor drivers
to get an understanding. Unfortunately I couldn't find a bug to fix,
so I had to do something else :)

I don't know whether this patch is worth to be applied, but I have to
start somewhere.

I'm very interested in doing more kernel stuff. So if you have some
work to do, please tell me about it.

Thanks
Andre
---

At the exit_free label in k8temp_probe() the driver data is set to
NULL. This field isn't set before. So this should be done in
exit_remove.

Signed-off-by: Andre Prendel <andre.prendel@gmx.de>
---

--- linux-2.6.orig/drivers/hwmon/k8temp.c	2009-05-05 21:31:44.000000000 +0200
+++ linux-2.6/drivers/hwmon/k8temp.c	2009-05-05 21:35:03.000000000 +0200
@@ -281,8 +281,8 @@
 	device_remove_file(&pdev->dev,
 			   &sensor_dev_attr_temp4_input.dev_attr);
 	device_remove_file(&pdev->dev, &dev_attr_name);
-exit_free:
 	dev_set_drvdata(&pdev->dev, NULL);
+exit_free:
 	kfree(data);
 exit:
 	return err;


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
