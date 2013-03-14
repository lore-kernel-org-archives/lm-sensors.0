From: Fabio Porcedda <fabio.porcedda@gmail.com>
Date: Thu, 14 Mar 2013 13:11:23 +0000
Subject: [lm-sensors] [PATCH 02/10] drivers: ata: use module_platform_driver_probe()
Message-Id: <1363266691-15757-4-git-send-email-fabio.porcedda@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1363266691-15757-1-git-send-email-fabio.porcedda@gmail.com>
In-Reply-To: <1363266691-15757-1-git-send-email-fabio.porcedda@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org, linux-ide@vger.kernel.org, lm-sensors@lm-sensors.org, linux-input@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jeff Garzik <jgarzik@pobox.com>

This patch converts the drivers to use the
module_platform_driver_probe() macro which makes the code smaller and
a bit simpler.

Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org
---
 drivers/ata/pata_at32.c       | 13 +------------
 drivers/ata/pata_samsung_cf.c | 13 +------------
 2 files changed, 2 insertions(+), 24 deletions(-)

diff --git a/drivers/ata/pata_at32.c b/drivers/ata/pata_at32.c
index 36f189c..8d493b4 100644
--- a/drivers/ata/pata_at32.c
+++ b/drivers/ata/pata_at32.c
@@ -393,18 +393,7 @@ static struct platform_driver pata_at32_driver = {
 	},
 };
 
-static int __init pata_at32_init(void)
-{
-	return platform_driver_probe(&pata_at32_driver, pata_at32_probe);
-}
-
-static void __exit pata_at32_exit(void)
-{
-	platform_driver_unregister(&pata_at32_driver);
-}
-
-module_init(pata_at32_init);
-module_exit(pata_at32_exit);
+module_platform_driver_probe(pata_at32_driver, pata_at32_probe);
 
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("AVR32 SMC/CFC PATA Driver");
diff --git a/drivers/ata/pata_samsung_cf.c b/drivers/ata/pata_samsung_cf.c
index 70b0e01..6ef27e9 100644
--- a/drivers/ata/pata_samsung_cf.c
+++ b/drivers/ata/pata_samsung_cf.c
@@ -661,18 +661,7 @@ static struct platform_driver pata_s3c_driver = {
 	},
 };
 
-static int __init pata_s3c_init(void)
-{
-	return platform_driver_probe(&pata_s3c_driver, pata_s3c_probe);
-}
-
-static void __exit pata_s3c_exit(void)
-{
-	platform_driver_unregister(&pata_s3c_driver);
-}
-
-module_init(pata_s3c_init);
-module_exit(pata_s3c_exit);
+module_platform_driver_probe(pata_s3c_driver, pata_s3c_probe);
 
 MODULE_AUTHOR("Abhilash Kesavan, <a.kesavan@samsung.com>");
 MODULE_DESCRIPTION("low-level driver for Samsung PATA controller");
-- 
1.8.1.5


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
