From: Hans de Goede <hdegoede@redhat.com>
Date: Sun, 13 Mar 2011 12:50:32 +0000
Subject: [lm-sensors] [PATCH 1/3] hwmon/f71882fg: Fix a typo in a comment
Message-Id: <1300020634-7724-1-git-send-email-hdegoede@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/hwmon/f71882fg.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/f71882fg.c b/drivers/hwmon/f71882fg.c
index bebc57e..9cb52f5 100644
--- a/drivers/hwmon/f71882fg.c
+++ b/drivers/hwmon/f71882fg.c
@@ -37,7 +37,7 @@
 #define SIO_F71858FG_LD_HWM	0x02	/* Hardware monitor logical device */
 #define SIO_F71882FG_LD_HWM	0x04	/* Hardware monitor logical device */
 #define SIO_UNLOCK_KEY		0x87	/* Key to enable Super-I/O */
-#define SIO_LOCK_KEY		0xAA	/* Key to diasble Super-I/O */
+#define SIO_LOCK_KEY		0xAA	/* Key to disable Super-I/O */
 
 #define SIO_REG_LDSEL		0x07	/* Logical device select */
 #define SIO_REG_DEVID		0x20	/* Device ID (2 bytes) */
-- 
1.7.3.2


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
