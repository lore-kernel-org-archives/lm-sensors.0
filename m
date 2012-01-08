From: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
Date: Sun, 08 Jan 2012 16:23:30 +0000
Subject: [lm-sensors] [PATCH 07/17] drivers/hwmon/f71882fg.c: fix checkpatch
Message-Id: <1326039820-11147-7-git-send-email-fransmeulenbroeks@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
---
 drivers/hwmon/f71882fg.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/f71882fg.c b/drivers/hwmon/f71882fg.c
index 59dd881..8b0489d 100644
--- a/drivers/hwmon/f71882fg.c
+++ b/drivers/hwmon/f71882fg.c
@@ -112,7 +112,7 @@ MODULE_PARM_DESC(force_id, "Override the detected device ID");
 enum chips { f71808e, f71808a, f71858fg, f71862fg, f71869, f71869a, f71882fg,
 	     f71889fg, f71889ed, f71889a, f8000, f81865f };
 
-static const char *f71882fg_names[] = {
+static const char *const f71882fg_names[] = {
 	"f71808e",
 	"f71808a",
 	"f71858fg",
-- 
1.7.8.2


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
