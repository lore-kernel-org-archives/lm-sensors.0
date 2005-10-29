From: gregkh@suse.de (Greg KH)
Date: Sat, 29 Oct 2005 00:16:47 +0000
Subject: [lm-sensors] [PATCH] hwmon: via686a: save 0.5k by long v[256] ->
Message-Id: <1130533656553@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] hwmon: via686a: save 0.5k by long v[256] -> s16 v[256]

We can save 0.5kB of data in the via686a driver.

From: Denis Vlasenko <vda@ilport.com.ua>
Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 088341bd0c78143bf82ff21f7f0a715f99568c73
tree 5044d28b37f1a7f46575810e5e2bb8bcee78d965
parent c7461a6652f40ce4f8e19d7368c7a807a618fb68
author Jean Delvare <khali@linux-fr.org> Sat, 10 Sep 2005 23:00:46 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 28 Oct 2005 14:02:05 -0700

 drivers/hwmon/via686a.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/via686a.c b/drivers/hwmon/via686a.c
index 05ddc88..60e9487 100644
--- a/drivers/hwmon/via686a.c
+++ b/drivers/hwmon/via686a.c
@@ -198,7 +198,7 @@ static inline u8 FAN_TO_REG(long rpm, in
  but the function is very linear in the useful range (0-80 deg C), so
  we'll just use linear interpolation for 10-bit readings.)  So, tempLUT
  is the temp at via register values 0-255: */
-static const long tempLUT[] +static const s16 tempLUT[]  { -709, -688, -667, -646, -627, -607, -589, -570, -553, -536, -519,
 	-503, -487, -471, -456, -442, -428, -414, -400, -387, -375,
 	-362, -350, -339, -327, -316, -305, -295, -285, -275, -265,
@@ -270,7 +270,7 @@ static inline u8 TEMP_TO_REG(long val)
 }
 
 /* for 8-bit temperature hyst and over registers */
-#define TEMP_FROM_REG(val) (tempLUT[(val)] * 100)
+#define TEMP_FROM_REG(val)	((long)tempLUT[val] * 100)
 
 /* for 10-bit temperature readings */
 static inline long TEMP_FROM_REG10(u16 val)

