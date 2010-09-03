From: Guillem Jover <guillem@hadrons.org>
Date: Fri, 03 Sep 2010 02:54:59 +0000
Subject: [lm-sensors] [PATCH 1/2] hwmon: (f75375s) Shift control mode to the
Message-Id: <20100903025459.GA15996@gaara.hadrons.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Riku Voipio <riku.voipio@iki.fi>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

The spec notes that fan0 and fan1 control mode bits are located in bits
7-6 and 5-4 respectively, but the FAN_CTRL_MODE macro was making the
bits shift by 5 instead of by 4.

Signed-off-by: Guillem Jover <guillem@hadrons.org>
---
 drivers/hwmon/f75375s.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/f75375s.c b/drivers/hwmon/f75375s.c
index 0f58ecc..e5828c0 100644
--- a/drivers/hwmon/f75375s.c
+++ b/drivers/hwmon/f75375s.c
@@ -79,7 +79,7 @@ enum chips { f75373, f75375 };
 #define F75375_REG_PWM2_DROP_DUTY	0x6C
 
 #define FAN_CTRL_LINEAR(nr)		(4 + nr)
-#define FAN_CTRL_MODE(nr)		(5 + ((nr) * 2))
+#define FAN_CTRL_MODE(nr)		(4 + ((nr) * 2))
 
 /*
  * Data structures and manipulation thereof
-- 
1.7.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
