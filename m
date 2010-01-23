From: Hans de Goede <hdegoede@redhat.com>
Date: Sat, 23 Jan 2010 16:24:57 +0000
Subject: [lm-sensors] PATCH: hwmon fschmd: Fix a memleak on multiple opens
Message-Id: <4B5B22D9.2020105@redhat.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------020909060600070309070503"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------020909060600070309070503
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

When /dev/watchdog gets opened a second time we return -EBUSY, but
we already have got a kref then, so we end up leaking our data struct.
This patch fixes this.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>

--------------020909060600070309070503
Content-Type: text/plain;
 name="hwmon-fschmd-fix-memleak.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="hwmon-fschmd-fix-memleak.patch"

hwmon fschmd: Fix a memleak on multiple opens of /dev/watchdog

When /dev/watchdog gets opened a second time we return -EBUSY, but
we already have got a kref then, so we end up leaking our data struct.
This patch fixes this.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
--- vanilla-2.6.32-rc5-git3/drivers/hwmon/fschmd.c~	2009-10-29 09:11:52.000000000 +0100
+++ vanilla-2.6.32-rc5-git3/drivers/hwmon/fschmd.c	2010-01-23 16:56:41.000000000 +0100
@@ -767,6 +767,7 @@ leave:
 static int watchdog_open(struct inode *inode, struct file *filp)
 {
 	struct fschmd_data *pos, *data = NULL;
+	int watchdog_is_open;
 
 	/* We get called from drivers/char/misc.c with misc_mtx hold, and we
 	   call misc_register() from fschmd_probe() with watchdog_data_mutex
@@ -781,10 +782,12 @@ static int watchdog_open(struct inode *i
 		}
 	}
 	/* Note we can never not have found data, so we don't check for this */
-	kref_get(&data->kref);
+	watchdog_is_open = test_and_set_bit(0, &data->watchdog_is_open);
+	if (!watchdog_is_open)
+		kref_get(&data->kref);
 	mutex_unlock(&watchdog_data_mutex);
 
-	if (test_and_set_bit(0, &data->watchdog_is_open))
+	if (watchdog_is_open)
 		return -EBUSY;
 
 	/* Start the watchdog */

--------------020909060600070309070503
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------020909060600070309070503--
