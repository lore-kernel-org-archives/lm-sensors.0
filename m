From: Jean Delvare <jdelvare@suse.de>
Date: Sun, 02 Feb 2014 17:33:40 +0000
Subject: [lm-sensors] [PATCH] hwmon: (f71805f) Fix author's address
Message-Id: <20140202183340.3ec36a7b@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The original address was incomplete, and this caused it to be missed
by the recent update to my new address.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
---
 drivers/hwmon/f71805f.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-3.14-rc0.orig/drivers/hwmon/f71805f.c	2014-02-02 16:53:20.041989953 +0100
+++ linux-3.14-rc0/drivers/hwmon/f71805f.c	2014-02-02 18:28:35.715794036 +0100
@@ -1648,7 +1648,7 @@ static void __exit f71805f_exit(void)
 	platform_driver_unregister(&f71805f_driver);
 }
 
-MODULE_AUTHOR("Jean Delvare <khali@linux-fr>");
+MODULE_AUTHOR("Jean Delvare <jdelvare@suse.de>");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("F71805F/F71872F hardware monitoring driver");
 


-- 
Jean Delvare
Suse L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
