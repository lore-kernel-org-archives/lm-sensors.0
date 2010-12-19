From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 19 Dec 2010 11:43:32 +0000
Subject: [lm-sensors] [PATCH] hwmon: (w83795) Silent false warning from gcc
Message-Id: <20101219124332.24e084ca@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The code triggers a false warning with older versions of gcc:
w83795.c: In function 'w83795_update_device':
w83795.c:475: warning: 'lsb' may be used uninitialized in this function

I admit that the code is a little tricky, but I see no way to write it
differently without hurting performance. So let's just silent the
warning with a needless initialization.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/w83795.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.37-rc6.orig/drivers/hwmon/w83795.c	2010-12-19 11:05:32.000000000 +0100
+++ linux-2.6.37-rc6/drivers/hwmon/w83795.c	2010-12-19 11:37:57.000000000 +0100
@@ -458,6 +458,7 @@ static void w83795_update_limits(struct
 {
 	struct w83795_data *data = i2c_get_clientdata(client);
 	int i, limit;
+	u8 lsb;
 
 	/* Read the voltage limits */
 	for (i = 0; i < ARRAY_SIZE(data->in); i++) {
@@ -479,9 +480,8 @@ static void w83795_update_limits(struct
 	}
 
 	/* Read the fan limits */
+	lsb = 0; /* Silent false gcc warning */
 	for (i = 0; i < ARRAY_SIZE(data->fan); i++) {
-		u8 lsb;
-
 		/* Each register contains LSB for 2 fans, but we want to
 		 * read it only once to save time */
 		if ((i & 1) = 0 && (data->has_fan & (3 << i)))


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
