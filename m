From: "Jan Beulich" <JBeulich@novell.com>
Date: Mon, 13 Sep 2010 10:14:43 +0000
Subject: [lm-sensors] [PATCH] x86/hwmon: don't leak device attribute file
Message-Id: <4C8E15B30200007800015AC9@vpn.id2.novell.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: khali@linux-fr.org
Cc: fenghua.yu@intel.com, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

While apparently inherited from coretemp source, this particular error
handling cleanup path wasn't copied properly (or perhaps got discarded
intermediately and not re-added properly later).

Signed-off-by: Jan Beulich <jbeulich@novell.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>

---
 drivers/hwmon/pkgtemp.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- linux-2.6.36-rc4/drivers/hwmon/pkgtemp.c	2010-09-13 08:45:03.000000000 +0200
+++ 2.6.36-rc4-x86-pkgtemp-probe-error-path/drivers/hwmon/pkgtemp.c	2010-09-03 17:54:30.000000000 +0200
@@ -224,7 +224,7 @@ static int __devinit pkgtemp_probe(struc
 
 	err = sysfs_create_group(&pdev->dev.kobj, &pkgtemp_group);
 	if (err)
-		goto exit_free;
+		goto exit_dev;
 
 	data->hwmon_dev = hwmon_device_register(&pdev->dev);
 	if (IS_ERR(data->hwmon_dev)) {
@@ -238,6 +238,8 @@ static int __devinit pkgtemp_probe(struc
 
 exit_class:
 	sysfs_remove_group(&pdev->dev.kobj, &pkgtemp_group);
+exit_dev:
+	device_remove_file(&pdev->dev, &sensor_dev_attr_temp1_max.dev_attr);
 exit_free:
 	kfree(data);
 exit:




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
