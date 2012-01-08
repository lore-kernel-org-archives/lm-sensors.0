From: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
Date: Sun, 08 Jan 2012 18:34:16 +0000
Subject: [lm-sensors] [PATCH 13/17 v2] hwmon: (w83l785ts) fix checkpatch
Message-Id: <1326047660-20539-13-git-send-email-fransmeulenbroeks@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

fixed:
ERROR: trailing whitespace
#89: FILE: w83l785ts.c:89:
+ $

WARNING: please, no spaces at the start of a line
#89: FILE: w83l785ts.c:89:
+ $

not fixed (did not want to break url):
WARNING: line over 80 characters
#10: FILE: w83l785ts.c:10:
+ *   http://www.winbond-usa.com/products/winbond_products/pdfs/PCIC/W83L785TS-S.pdf

total: 1 errors, 2 warnings, 320 lines checked

NOTE: whitespace errors detected, you may wish to use scripts/cleanpatch or
      scripts/cleanfile

w83l785ts.c has style problems, please review.

If any of these errors are false positives, please report
them to the maintainer, see CHECKPATCH in MAINTAINERS.
Signed-off-by: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
---
 drivers/hwmon/w83l785ts.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/w83l785ts.c b/drivers/hwmon/w83l785ts.c
index 20781de..edfc1ec 100644
--- a/drivers/hwmon/w83l785ts.c
+++ b/drivers/hwmon/w83l785ts.c
@@ -86,7 +86,7 @@ static struct w83l785ts_data *w83l785ts_update_device(struct device *dev);
 /*
  * Driver data (common to all clients)
  */
- 
+
 static const struct i2c_device_id w83l785ts_id[] = {
 	{ "w83l785ts", 0 },
 	{ }
-- 
1.7.8.2


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
