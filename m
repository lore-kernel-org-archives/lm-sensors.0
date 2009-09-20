From: Robert Hancock <hancockrwd@gmail.com>
Date: Sun, 20 Sep 2009 18:19:54 +0000
Subject: [lm-sensors] [PATCH] coretemp: add support for Core i5 CPU
Message-Id: <4AB6724A.1060702@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4AB5DE1F.1020004@gmail.com>
In-Reply-To: <4AB5DE1F.1020004@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org
Cc: r.marek@assembler.cz

Add coretemp support for Core i5 (Lynnfield) CPUs with model 0x1E.

Signed-off-by: Robert Hancock <hancockrwd@gmail.com>

---

This minimal patch works to add support for these CPUs, though we should likely
still look into using the CPUID flags instead of the model check.

diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index 93c1722..a9a21dc 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -413,11 +413,11 @@ static int __init coretemp_init(void)
 	for_each_online_cpu(i) {
 		struct cpuinfo_x86 *c = &cpu_data(i);
 
-		/* check if family 6, models 0xe, 0xf, 0x16, 0x17, 0x1A */
+		/* check if family 6, models 0xe, 0xf, 0x16, 0x17, 0x1A, 0x1E */
 		if ((c->cpuid_level < 0) || (c->x86 != 0x6) ||
 		    !((c->x86_model = 0xe) || (c->x86_model = 0xf) ||
 			(c->x86_model = 0x16) || (c->x86_model = 0x17) ||
-			(c->x86_model = 0x1A))) {
+			(c->x86_model = 0x1A) || (c->x86_model = 0x1E))) {
 
 			/* supported CPU not found, but report the unknown
 			   family 6 CPU */

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
