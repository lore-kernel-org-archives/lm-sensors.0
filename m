From: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
Date: Thu, 05 Jan 2012 18:50:15 +0000
Subject: [lm-sensors] [PATCH 1/4] drivers/hwmon/amc6821.c: fix initialisation
Message-Id: <1325789418-11276-1-git-send-email-fransmeulenbroeks@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

fix checkpatch error:
ERROR: do not initialise statics to 0 or NULL

Signed-off-by: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
---
 drivers/hwmon/amc6821.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/amc6821.c b/drivers/hwmon/amc6821.c
index 4033974..8e9e927 100644
--- a/drivers/hwmon/amc6821.c
+++ b/drivers/hwmon/amc6821.c
@@ -47,7 +47,7 @@ static const unsigned short normal_i2c[] = {0x18, 0x19, 0x1a, 0x2c, 0x2d, 0x2e,
  * Insmod parameters
  */
 
-static int pwminv = 0;	/*Inverted PWM output. */
+static int pwminv;	/*Inverted PWM output. */
 module_param(pwminv, int, S_IRUGO);
 
 static int init = 1; /*Power-on initialization.*/
-- 
1.7.8.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
