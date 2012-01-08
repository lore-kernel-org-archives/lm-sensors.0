From: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
Date: Sun, 08 Jan 2012 18:34:10 +0000
Subject: [lm-sensors] [PATCH 07/17 v2] hwmon: (f71882fg) fix checkpatch
Message-Id: <1326047660-20539-7-git-send-email-fransmeulenbroeks@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

fixed:
WARNING: static const char * array should probably be static const char * const
#115: FILE: f71882fg.c:115:
+static const char *f71882fg_names[] = {

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
