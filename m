From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:47 +0000
Subject: [PATCH] i2c driver fixes for 2.6.4
Message-Id: <10793913912632@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <10793913913858@kroah.com>
References: <10793913903814@kroah.com>
In-Reply-To: <10793913903814@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1557.61.11, 2004/02/23 16:28:43-08:00, khali@linux-fr.org

[PATCH] I2C: fix Hangs with w83781d

Here is a patch for the w83781d driver that prevents register bits from
being arbitrary changed when we force temp2/3 to comparator mode. Keith
Duthie had been reporting various problems with that driver and finally
found that this arbitrary change was the cause of them. He also tested
this patch, which he confirmed to work.


 drivers/i2c/chips/w83781d.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletion(-)


diff -Nru a/drivers/i2c/chips/w83781d.c b/drivers/i2c/chips/w83781d.c
--- a/drivers/i2c/chips/w83781d.c	Mon Mar 15 14:37:03 2004
+++ b/drivers/i2c/chips/w83781d.c	Mon Mar 15 14:37:03 2004
@@ -1632,7 +1632,11 @@
 		if (type != w83781d) {
 			/* enable comparator mode for temp2 and temp3 so
 			   alarm indication will work correctly */
-			w83781d_write_value(client, W83781D_REG_IRQ, 0x41);
+			i = w83781d_read_value(client, W83781D_REG_IRQ);
+			if (!(i & 0x40))
+				w83781d_write_value(client, W83781D_REG_IRQ,
+						    i | 0x40);
+
 			for (i = 0; i < 3; i++)
 				data->pwmenable[i] = 1;
 		}

