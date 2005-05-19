From: grant_lkml@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:58 +0000
Subject: [PATCH 2.6] I2C: Setting w83627hf fan divisor 128 fails.
Message-Id: <9lj58114ceoef48hfo6lect8u0m38hc0ai@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,
 
Jarkko Lavinen provided patch to fix: "couldn't set the divisor 128 
through fan1_div sysfs entry even though the chip supports it and 
setting divisors 1..64 worked. This was due to POWER_TO_REG() only 
checking 2's powers 0 till 5 but not 6."
 
This patch applies that fix to w83627hf and w83781d drivers. 

--Grant.

Signed-off-by: Grant Coady <gcoady@gmail.com>

---
 w83627hf.c |    2 +-
 w83781d.c  |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff -X dontdiff -Nru linux-2.6.12-rc4/drivers/i2c/chips/w83627hf.c linux-2.6.12-rc4b/drivers/i2c/chips/w83627hf.c
--- linux-2.6.12-rc4/drivers/i2c/chips/w83627hf.c	2005-05-12 09:47:33.000000000 +1000
+++ linux-2.6.12-rc4b/drivers/i2c/chips/w83627hf.c	2005-05-12 13:24:55.000000000 +1000
@@ -264,7 +264,7 @@
 {
 	int i;
 	val = SENSORS_LIMIT(val, 1, 128) >> 1;
-	for (i = 0; i < 6; i++) {
+	for (i = 0; i < 7; i++) {
 		if (val = 0)
 			break;
 		val >>= 1;
diff -X dontdiff -Nru linux-2.6.12-rc4/drivers/i2c/chips/w83781d.c linux-2.6.12-rc4b/drivers/i2c/chips/w83781d.c
--- linux-2.6.12-rc4/drivers/i2c/chips/w83781d.c	2005-05-12 09:47:33.000000000 +1000
+++ linux-2.6.12-rc4b/drivers/i2c/chips/w83781d.c	2005-05-12 13:26:33.000000000 +1000
@@ -193,7 +193,7 @@
 	val = SENSORS_LIMIT(val, 1,
 			    ((type = w83781d
 			      || type = as99127f) ? 8 : 128)) >> 1;
-	for (i = 0; i < 6; i++) {
+	for (i = 0; i < 7; i++) {
 		if (val = 0)
 			break;
 		val >>= 1;
