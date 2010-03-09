From: Prarit Bhargava <prarit@redhat.com>
Date: Tue, 09 Mar 2010 14:58:36 +0000
Subject: [lm-sensors] [PATCH]: coretemp: fix cpu model output
Message-Id: <20100309145836.10304.23068.sendpatchset@prarit.bos.redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Avoid hex and decimal confusion when printing out the cpu model.

Signed-off-by: Prarit Bhargava <prarit@redhat.com>

diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index 2d7bcee..f5f975b 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -466,7 +466,7 @@ static int __init coretemp_init(void)
 			   family 6 CPU */
 			if ((c->x86 = 0x6) && (c->x86_model > 0xf))
 				printk(KERN_WARNING DRVNAME ": Unknown CPU "
-					"model %x\n", c->x86_model);
+					"model 0x%x\n", c->x86_model);
 			continue;
 		}
 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
