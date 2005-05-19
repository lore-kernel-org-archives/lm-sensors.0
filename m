From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:17 +0000
Subject: [PATCH] i2c driver fixes for 2.6.0-test5
Message-Id: <10642734181829@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <10642734181751@kroah.com>
References: <1064273416272@kroah.com>
In-Reply-To: <1064273416272@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1153.123.2, 2003/09/04 11:28:46-07:00, azarah@gentoo.org

[PATCH] I2C: Fix conversion from milli volts in store_in_reg() for w83781d.c

I am not sure if it was a later patch from me that fixed in_* to display
milli volts in sysfs, or if it was a patch from Jan Dittmer, but the
conversion in the store_in_*() functions is wrong, and cause something
like:


 drivers/i2c/chips/w83781d.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff -Nru a/drivers/i2c/chips/w83781d.c b/drivers/i2c/chips/w83781d.c
--- a/drivers/i2c/chips/w83781d.c	Mon Sep 22 16:16:19 2003
+++ b/drivers/i2c/chips/w83781d.c	Mon Sep 22 16:16:19 2003
@@ -378,8 +378,8 @@
 	struct w83781d_data *data = i2c_get_clientdata(client); \
 	u32 val; \
 	 \
-	val = simple_strtoul(buf, NULL, 10); \
-	data->in_##reg[nr] = (IN_TO_REG(val) / 10); \
+	val = simple_strtoul(buf, NULL, 10) / 10; \
+	data->in_##reg[nr] = IN_TO_REG(val); \
 	w83781d_write_value(client, W83781D_REG_IN_##REG(nr), data->in_##reg[nr]); \
 	 \
 	return count; \

