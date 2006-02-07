From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 07 Feb 2006 16:53:32 +0000
Subject: [lm-sensors] [PATCH] it87: Fix oops on removal
Message-Id: <20060207175332.3c1be7ba.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

Please push this to Linux as soon as possible.

* * * * *

Fix an oops on it87 module removal when no supported hardware was
found.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
---
 drivers/hwmon/it87.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- linux-2.6.16-rc2.orig/drivers/hwmon/it87.c	2006-02-07 09:15:09.000000000 +0100
+++ linux-2.6.16-rc2/drivers/hwmon/it87.c	2006-02-07 16:51:22.000000000 +0100
@@ -1187,7 +1187,8 @@
 
 static void __exit sm_it87_exit(void)
 {
-	i2c_isa_del_driver(&it87_isa_driver);
+	if (isa_address)
+		i2c_isa_del_driver(&it87_isa_driver);
 	i2c_del_driver(&it87_driver);
 }
 


-- 
Jean Delvare

