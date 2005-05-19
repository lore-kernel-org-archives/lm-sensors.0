From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:23:53 +0000
Subject: [PATCH] i2c driver changes for 2.5.67
Message-Id: <10499274993464@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <10499274991641@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1133.1.3, 2003/04/08 02:49:21-07:00, azarah@gentoo.org

[PATCH] i2c: Fix w83781d sensor to use Milli-Volt for in_* in sysfs

I did the w83781d sysfs update as per the old spec, which was not
milli-volt.  This patch should fix it.


 drivers/i2c/chips/w83781d.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff -Nru a/drivers/i2c/chips/w83781d.c b/drivers/i2c/chips/w83781d.c
--- a/drivers/i2c/chips/w83781d.c	Wed Apr  9 15:16:04 2003
+++ b/drivers/i2c/chips/w83781d.c	Wed Apr  9 15:16:04 2003
@@ -364,7 +364,7 @@
 	 \
 	w83781d_update_client(client); \
 	 \
-	return sprintf(buf,"%ld\n", (long)IN_FROM_REG(data->reg[nr])); \
+	return sprintf(buf,"%ld\n", (long)IN_FROM_REG(data->reg[nr] * 10)); \
 }
 show_in_reg(in);
 show_in_reg(in_min);
@@ -378,7 +378,7 @@
 	u32 val; \
 	 \
 	val = simple_strtoul(buf, NULL, 10); \
-	data->in_##reg[nr] = IN_TO_REG(val); \
+	data->in_##reg[nr] = (IN_TO_REG(val) / 10); \
 	w83781d_write_value(client, W83781D_REG_IN_##REG(nr), data->in_##reg[nr]); \
 	 \
 	return count; \

