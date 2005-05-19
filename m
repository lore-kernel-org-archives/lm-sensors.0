From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:22 +0000
Subject: [PATCH] I2C update for 2.6.10-rc1
Message-Id: <10999778572385@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <10999778574012@kroah.com>
References: <10999778552595@kroah.com>
In-Reply-To: <10999778552595@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.2014.1.21, 2004/11/08 16:45:21-08:00, khali@linux-fr.org

[PATCH] I2C: Check for unregistered adapter in i2c_del_adapter

The patch adds a check at the beginning of i2c_del_adapter in case
someone attempts to remove an adapter that was never added in the first
place. This sounds like a good safety, as doing so will lead to an oops
at the moment. Also, I have a need for it in the latest version of my
i2c-amd756-s4882 patch. I need to remove the original adapter and
install the virtual ones instead, but I have no way to know if the
original adapter was succesfully added beforehand or not.


Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/i2c-core.c |   13 +++++++++++++
 1 files changed, 13 insertions(+)


diff -Nru a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
--- a/drivers/i2c/i2c-core.c	2004-11-08 18:54:39 -08:00
+++ b/drivers/i2c/i2c-core.c	2004-11-08 18:54:39 -08:00
@@ -177,11 +177,24 @@
 int i2c_del_adapter(struct i2c_adapter *adap)
 {
 	struct list_head  *item, *_n;
+	struct i2c_adapter *adap_from_list;
 	struct i2c_driver *driver;
 	struct i2c_client *client;
 	int res = 0;
 
 	down(&core_lists);
+
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
 
 	list_for_each(item,&drivers) {
 		driver = list_entry(item, struct i2c_driver, list);

