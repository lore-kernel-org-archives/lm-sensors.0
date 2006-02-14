From: gregkh@suse.de (Greg Kroah-Hartman)
Date: Tue, 14 Feb 2006 06:48:21 +0000
Subject: [lm-sensors] [PATCH 4/5] it87: Fix oops on removal
Message-Id: <1139899701180-git-send-email-gregkh@suse.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Fix an oops on it87 module removal when no supported hardware was
found.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>

---

 drivers/hwmon/it87.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

be79c383254cd3eb50953d8c0a7cacdbf6db31c0
diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
index e87d52c..d7a9401 100644
--- a/drivers/hwmon/it87.c
+++ b/drivers/hwmon/it87.c
@@ -1186,7 +1186,8 @@ static int __init sm_it87_init(void)
 
 static void __exit sm_it87_exit(void)
 {
-	i2c_isa_del_driver(&it87_isa_driver);
+	if (isa_address)
+		i2c_isa_del_driver(&it87_isa_driver);
 	i2c_del_driver(&it87_driver);
 }
 



