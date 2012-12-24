From: Chris Verges <kg4ysn@gmail.com>
Date: Mon, 24 Dec 2012 19:49:07 +0000
Subject: [lm-sensors] [PATCH 2/2] lm73: fixed Documentation/hwmon/lm73 header
Message-Id: <1356378547-31499-2-git-send-email-kg4ysn@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The lm90 documentation was used as a template for the lm73, and the
header was not appropriately updated.

Signed-off-by: Chris Verges <kg4ysn@gmail.com>
---
 Documentation/hwmon/lm73 |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/hwmon/lm73 b/Documentation/hwmon/lm73
index 2d947d3..284661a 100644
--- a/Documentation/hwmon/lm73
+++ b/Documentation/hwmon/lm73
@@ -1,4 +1,4 @@
-Kernel driver lm90
+Kernel driver lm73
 =========
 
 Supported chips:
-- 
1.7.9.5


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
