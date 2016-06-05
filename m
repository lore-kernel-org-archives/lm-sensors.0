From: Wolfram Sang <wsa@the-dreams.de>
Date: Sun, 05 Jun 2016 07:35:43 +0000
Subject: [lm-sensors] [PATCH] hwmon: (lm90) use proper type for update_interval
Message-Id: <1465112143-15337-1-git-send-email-wsa@the-dreams.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The code handles this variable always as unsigned, so adapt the type.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---

Triggered by a code-checker warning. Only compile tested.

 drivers/hwmon/lm90.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index c9ff08dbe10cef..e30a5939dc0d55 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -375,7 +375,7 @@ struct lm90_data {
 	int kind;
 	u32 flags;
 
-	int update_interval;	/* in milliseconds */
+	unsigned int update_interval; /* in milliseconds */
 
 	u8 config_orig;		/* Original configuration register value */
 	u8 convrate_orig;	/* Original conversion rate register value */
-- 
2.8.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
