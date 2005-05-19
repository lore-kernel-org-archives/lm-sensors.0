From: grant_lkml@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:58 +0000
Subject: [PATCH 2.6] I2C: adm9240 driver cleanup, take 2
Message-Id: <6vv881d0gkm41uq91he47mj92j8jgr80fk@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <ccs881d9udtiesr60rl07knb7j12dk9f96@4ax.com>
In-Reply-To: <ccs881d9udtiesr60rl07knb7j12dk9f96@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg, Jean,

This patch adds an info print of detected VRM stolen from Sebastian 
Witt's atxp1 sriver.  ADM9240 already has vrm accessor removed.

Write no-op and whitespace fixes removed :)

Couple of comments changed, tested on 2.6.11.9.

--Grant.


Signed-off-by: Grant Coady <gcoady@gmail.com>

---
 adm9240.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

--- linux-2.6.12-rc4-mm1/drivers/i2c/chips/adm9240.c	2005-05-12 21:33:22.000000000 +1000
+++ linux-2.6.12-rc4-mm1b/drivers/i2c/chips/adm9240.c	2005-05-13 20:18:10.000000000 +1000
@@ -165,7 +165,7 @@ struct adm9240_data {
 	s8 temp_high;		/* rw	temp1_max */
 	s8 temp_hyst;		/* rw	temp1_max_hyst */
 	u16 alarms;		/* ro	alarms */
-	u8 aout;		/* rw	analog_out */
+	u8 aout;		/* rw	aout_output */
 	u8 vid;			/* ro	vid */
 	u8 vrm;			/* --	vrm set on startup, no accessor */
 };
@@ -192,7 +192,7 @@ static ssize_t show_##value(struct devic
 }
 show_temp(temp_high, 1000);
 show_temp(temp_hyst, 1000);
-show_temp(temp, 500);
+show_temp(temp, 500); /* 0.5'C per bit */
 
 #define set_temp(value, reg)					\
 static ssize_t set_##value(struct device *dev, const char *buf,	\
@@ -630,6 +630,9 @@ static void adm9240_init_client(struct i
 
 	data->vrm = i2c_which_vrm(); /* need this to report vid as mV */
 
+	dev_info(&client->dev, "Using VRM: %d.%d\n", data->vrm / 10,
+			data->vrm % 10);
+
 	if (conf & 1) { /* measurement cycle running: report state */
 
 		dev_info(&client->dev, "status: config 0x%02x mode %u\n",
