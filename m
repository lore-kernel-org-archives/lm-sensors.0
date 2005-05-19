From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:21 +0000
Subject: [PATCH 2.6] I2C: Check for unregistered adapter in i2c_del_adapter
Message-Id: <20041106194733.53c8cfa9.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg, hi all,

This is the patch we discussed about yesterday. I post it here so that
it can receive the public reviewing it deserves.

The patch adds a check at the beginning of i2c_del_adapter in case
someone attempts to remove an adapter that was never added in the first
place. This sounds like a good safety, as doing so will lead to an oops
at the moment. Also, I have a need for it in the latest version of my
i2c-amd756-s4882 patch. I need to remove the original adapter and
install the virtual ones instead, but I have no way to know if the
original adapter was succesfully added beforehand or not.

Thanks.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

--- linux-2.6.10-rc1/drivers/i2c/i2c-core.c.orig	2004-11-04 21:51:13.000000000 +0100
+++ linux-2.6.10-rc1/drivers/i2c/i2c-core.c	2004-11-05 20:49:20.000000000 +0100
@@ -177,12 +177,25 @@
 int i2c_del_adapter(struct i2c_adapter *adap)
 {
 	struct list_head  *item, *_n;
+	struct i2c_adapter *adap_from_list;
 	struct i2c_driver *driver;
 	struct i2c_client *client;
 	int res = 0;
 
 	down(&core_lists);
 
+	/* First make sure that this adapter was ever added */
+	list_for_each_entry(adap_from_list, &adapters, list) {
+		if (adap_from_list = adap)
+			break;
+	}
+	if (adap_from_list != adap) {
+		pr_debug("I2C: Attempting to delete an unregistered "
+			 "adapter\n");
+		res = -EINVAL;
+		goto out_unlock;
+	}
+
 	list_for_each(item,&drivers) {
 		driver = list_entry(item, struct i2c_driver, list);
 		if (driver->detach_adapter)


-- 
Jean Delvare
http://khali.linux-fr.org/
