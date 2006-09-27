From: greg@kroah.com (Greg KH)
Date: Wed, 27 Sep 2006 01:01:53 +0000
Subject: [lm-sensors] [PATCH 22/30] i2c-algo-pcf: Discard the mdelay data
Message-Id: <1159318997126-git-send-email-greg@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Adrian Bunk <bunk at stusta.de>

i2c-algo-pcf: Discard the mdelay data struct member

Just as i2c-algo-bit, i2c-algo-pcf has an unused mdelay struct member,
which we can get rid of to spare some code and memory.

Signed-off-by: Adrian Bunk <bunk at stusta.de>
Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>
---
 drivers/i2c/busses/i2c-elektor.c |    1 -
 include/linux/i2c-algo-pcf.h     |    1 -
 2 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-elektor.c b/drivers/i2c/busses/i2c-elektor.c
index 59f8308..caa8e5c 100644
--- a/drivers/i2c/busses/i2c-elektor.c
+++ b/drivers/i2c/busses/i2c-elektor.c
@@ -196,7 +196,6 @@ static struct i2c_algo_pcf_data pcf_isa_
 	.getclock   = pcf_isa_getclock,
 	.waitforpin = pcf_isa_waitforpin,
 	.udelay	    = 10,
-	.mdelay	    = 10,
 	.timeout    = 100,
 };
 
diff --git a/include/linux/i2c-algo-pcf.h b/include/linux/i2c-algo-pcf.h
index 18b0adf..9908f3f 100644
--- a/include/linux/i2c-algo-pcf.h
+++ b/include/linux/i2c-algo-pcf.h
@@ -35,7 +35,6 @@ struct i2c_algo_pcf_data {
 
 	/* local settings */
 	int udelay;
-	int mdelay;
 	int timeout;
 };
 
-- 
1.4.2.1


