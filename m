From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 15 Sep 2010 14:01:19 +0000
Subject: [lm-sensors] [patch 26/36] hwmon: (w83795) Drop REST_VLT_BEGIN/END
Message-Id: <20100915160119.67bc8f4e@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Get rid of REST_VLT_BEGIN and REST_VLT_END, they don't make the code
more readable.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/w83795.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

--- linux-2.6.36-rc4.orig/drivers/hwmon/w83795.c	2010-09-15 15:14:03.000000000 +0200
+++ linux-2.6.36-rc4/drivers/hwmon/w83795.c	2010-09-15 15:14:05.000000000 +0200
@@ -175,10 +175,6 @@ static const u8 IN_LSB_SHIFT_IDX[][2]  };
 
 
-/* 3VDD, 3VSB, VBAT * 0.006 */
-#define REST_VLT_BEGIN			12  /* the 13th volt to 15th */
-#define REST_VLT_END			14  /* the 13th volt to 15th */
-
 #define W83795_REG_FAN(index)		(0x2E + (index))
 #define W83795_REG_FAN_MIN_HL(index)	(0xB6 + (index))
 #define W83795_REG_FAN_MIN_LSB(index)	(0xC4 + (index) / 2)
@@ -250,7 +246,8 @@ static const u8 IN_LSB_SHIFT_IDX[][2]  
 static inline u16 in_from_reg(u8 index, u16 val)
 {
-	if ((index >= REST_VLT_BEGIN) && (index <= REST_VLT_END))
+	/* 3VDD, 3VSB and VBAT: 6 mV/bit; other inputs: 2 mV/bit */
+	if (index >= 12 && index <= 14)
 		return val * 6;
 	else
 		return val * 2;
@@ -258,7 +255,7 @@ static inline u16 in_from_reg(u8 index,
 
 static inline u16 in_to_reg(u8 index, u16 val)
 {
-	if ((index >= REST_VLT_BEGIN) && (index <= REST_VLT_END))
+	if (index >= 12 && index <= 14)
 		return val / 6;
 	else
 		return val / 2;


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
