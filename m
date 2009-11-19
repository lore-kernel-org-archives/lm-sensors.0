From: Wu Zhangjin <wuzhangjin@gmail.com>
Date: Thu, 19 Nov 2009 18:02:46 +0000
Subject: Re: [lm-sensors] [PATCH 5/5] [loongson] yeeloong2f: add platform
Message-Id: <1258653766.14308.13.camel@falcon.domain.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <cover.1258651050.git.wuzhangjin@gmail.com>
	 <08cd92bb27734174fd53df79cc926e76400d586d.1258651050.git.wuzhangjin@gmail.com>
In-Reply-To: <08cd92bb27734174fd53df79cc926e76400d586d.1258651050.git.wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org, zhangfx@lemote.com, yanh@lemote.com, huhb@lemote.com, Richard Purdie <rpurdie@rpsys.net>, lm-sensors@lm-sensors.org, Jamey Hicks <jamey@crl.dec.com>

Sorry, This patch can not be compiled without CONFIG_PM, this patch is
needed to fix it:

We need to wrap the source code relative to CONFIG_PM, otherwise, it
will fail in compiling.

This patch is needed to "[PATCH 5/5] [loongson] yeeloong2f: add platform
specific support".

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/loongson/lemote-2f/yeeloong_laptop.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/mips/loongson/lemote-2f/yeeloong_laptop.c
b/arch/mips/loongson/lemote-2f/yeeloong_laptop.c
index ff74f7f..46c3847 100644
--- a/arch/mips/loongson/lemote-2f/yeeloong_laptop.c
+++ b/arch/mips/loongson/lemote-2f/yeeloong_laptop.c
@@ -1025,9 +1025,10 @@ static int yeeloong_hotkey_init(struct device
*dev)
 	/* update the current status of lid */
 	yeeloong_lid_update_status(BIT_LID_DETECT_ON);
 
+#ifdef CONFIG_SUSPEND
 	/* install the real yeeloong_report_lid_status for pm.c */
 	yeeloong_report_lid_status = yeeloong_lid_update_status;
-
+#endif
 	/* install event handler */
 	yeeloong_install_sci_handler(EVENT_CAMERA, camera_set);
 
@@ -1039,9 +1040,10 @@ static void yeeloong_hotkey_exit(void)
 	/* free irq */
 	remove_irq(SCI_IRQ_NUM, &sci_irqaction);
 
+#ifdef CONFIG_SUSPEND
 	/* uninstall the real yeeloong_report_lid_status for pm.c */
 	yeeloong_report_lid_status = NULL;
-
+#endif
 	/* uninstall event handler */
 	yeeloong_uninstall_sci_handler(EVENT_CAMERA, camera_set);
 
@@ -1083,7 +1085,8 @@ static void get_fixed_battery_info(void)
 
 #define APM_CRITICAL		5
 
-static void yeeloong_apm_get_power_status(struct apm_power_info *info)
+static void __maybe_unused yeeloong_apm_get_power_status(struct
apm_power_info
+		*info)
 {
 	unsigned char bat_status;
 
@@ -1144,8 +1147,9 @@ static int yeeloong_apm_init(void)
 	/* print fixed information of battery */
 	get_fixed_battery_info();
 
+#ifdef APM_EMULATION
 	apm_get_power_status = yeeloong_apm_get_power_status;
-
+#endif
 	return 0;
 }
 
-- 
1.6.2.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
