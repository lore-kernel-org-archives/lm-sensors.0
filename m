From: Axel Lin <axel.lin@ingics.com>
Date: Wed, 12 Nov 2014 08:36:47 +0000
Subject: [lm-sensors] [PATCH] hwmon: (ibmpowernv) Convert to module_platform_driver
Message-Id: <1415781407.3373.0.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Use module_platform_driver to simplify the code a bit.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hwmon/ibmpowernv.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/hwmon/ibmpowernv.c b/drivers/hwmon/ibmpowernv.c
index 6149356..febe817 100644
--- a/drivers/hwmon/ibmpowernv.c
+++ b/drivers/hwmon/ibmpowernv.c
@@ -317,19 +317,8 @@ static struct platform_driver ibmpowernv_driver = {
 	},
 };
 
-static int __init ibmpowernv_init(void)
-{
-	return platform_driver_register(&ibmpowernv_driver);
-}
-
-static void __exit ibmpowernv_exit(void)
-{
-	platform_driver_unregister(&ibmpowernv_driver);
-}
+module_platform_driver(ibmpowernv_driver);
 
 MODULE_AUTHOR("Neelesh Gupta <neelegup@linux.vnet.ibm.com>");
 MODULE_DESCRIPTION("IBM POWERNV platform sensors");
 MODULE_LICENSE("GPL");
-
-module_init(ibmpowernv_init);
-module_exit(ibmpowernv_exit);
-- 
1.9.1




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
