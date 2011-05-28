From: Hans de Goede <hdegoede@redhat.com>
Date: Sat, 28 May 2011 07:21:24 +0000
Subject: [lm-sensors] [PATCH 2/3] hwmon: use <> rather then@around my
Message-Id: <1306567285-2322-2-git-send-email-hdegoede@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/hwmon/f71882fg.c |    2 +-
 drivers/hwmon/sch5627.c  |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/f71882fg.c b/drivers/hwmon/f71882fg.c
index a4a94a0..f8ef196 100644
--- a/drivers/hwmon/f71882fg.c
+++ b/drivers/hwmon/f71882fg.c
@@ -2662,7 +2662,7 @@ static void __exit f71882fg_exit(void)
 }
 
 MODULE_DESCRIPTION("F71882FG Hardware Monitoring Driver");
-MODULE_AUTHOR("Hans Edgington, Hans de Goede (hdegoede@redhat.com)");
+MODULE_AUTHOR("Hans Edgington, Hans de Goede <hdegoede@redhat.com>");
 MODULE_LICENSE("GPL");
 
 module_init(f71882fg_init);
diff --git a/drivers/hwmon/sch5627.c b/drivers/hwmon/sch5627.c
index 695b2ab..e3b5c60 100644
--- a/drivers/hwmon/sch5627.c
+++ b/drivers/hwmon/sch5627.c
@@ -601,7 +601,7 @@ static void __exit sch5627_exit(void)
 }
 
 MODULE_DESCRIPTION("SMSC SCH5627 Hardware Monitoring Driver");
-MODULE_AUTHOR("Hans de Goede (hdegoede@redhat.com)");
+MODULE_AUTHOR("Hans de Goede <hdegoede@redhat.com>");
 MODULE_LICENSE("GPL");
 
 module_init(sch5627_init);
-- 
1.7.5.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
