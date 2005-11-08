From: gregkh@suse.de (Greg KH)
Date: Tue, 08 Nov 2005 06:53:15 +0000
Subject: [lm-sensors] [PATCH] hwmon: Fix two w83627hf bugs
Message-Id: <11314291481730@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] hwmon: Fix two w83627hf bugs

* Fix in4 reads for W83627THF and W83637HF chips.
* Use the correct register for alarm flags.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 4a1c4447e523003019a2bf9b972ed6fe411e84d2
tree 90dc9edf07dc4373e5c474c6d0083afd8a201998
parent ef9627464490fe67235bbd5724d55345b92c0315
author Yuan Mu <Ymu@winbond.com.tw> Mon, 07 Nov 2005 22:19:04 +0100
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 07 Nov 2005 21:46:37 -0800

 drivers/hwmon/w83627hf.c |   16 ++++------------
 1 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/hwmon/w83627hf.c b/drivers/hwmon/w83627hf.c
index 70ef926..4e9a04e 100644
--- a/drivers/hwmon/w83627hf.c
+++ b/drivers/hwmon/w83627hf.c
@@ -180,11 +180,10 @@ superio_exit(void)
 #define W83781D_REG_BANK 0x4E
 
 #define W83781D_REG_CONFIG 0x40
-#define W83781D_REG_ALARM1 0x41
-#define W83781D_REG_ALARM2 0x42
-#define W83781D_REG_ALARM3 0x450
+#define W83781D_REG_ALARM1 0x459
+#define W83781D_REG_ALARM2 0x45A
+#define W83781D_REG_ALARM3 0x45B
 
-#define W83781D_REG_IRQ 0x4C
 #define W83781D_REG_BEEP_CONFIG 0x4D
 #define W83781D_REG_BEEP_INTS1 0x56
 #define W83781D_REG_BEEP_INTS2 0x57
@@ -1370,13 +1369,6 @@ static void w83627hf_init_client(struct 
 					W83781D_REG_TEMP3_CONFIG, tmp & 0xfe);
 			}
 		}
-
-		/* enable comparator mode for temp2 and temp3 so
-	           alarm indication will work correctly */
-		i = w83627hf_read_value(client, W83781D_REG_IRQ);
-		if (!(i & 0x40))
-			w83627hf_write_value(client, W83781D_REG_IRQ,
-					    i | 0x40);
 	}
 
 	/* Start monitoring */
@@ -1400,7 +1392,7 @@ static struct w83627hf_data *w83627hf_up
 			/* skip missing sensors */
 			if (((data->type = w83697hf) && (i = 1)) ||
 			    ((data->type = w83627thf || data->type = w83637hf)
-			    && (i = 4 || i = 5)))
+			    && (i = 5 || i = 6)))
 				continue;
 			data->in[i]  			    w83627hf_read_value(client, W83781D_REG_IN(i));

