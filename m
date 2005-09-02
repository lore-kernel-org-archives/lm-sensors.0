From: mgreer@mvista.com (Mark A. Greer)
Date: Fri, 02 Sep 2005 03:06:28 +0000
Subject: [lm-sensors] [PATCH 2.6.13-mm1] i2c: bug fix for
Message-Id: <20050902010549.GD10106@mag.az.mvista.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

When an i2c transfer is successful, an incorrect value may be returned.
This patch fixes that.

Signed-off-by: David Jenkins <davej@artesyncp.com>
Signed-off-by: Mark A. Greer <mgreer@mvista.com>
--

diff -Nur linux-2.6.13-mm1/drivers/i2c/busses/i2c-mv64xxx.c linux-2.6.13-mm1-mag/drivers/i2c/busses/i2c-mv64xxx.c
--- linux-2.6.13-mm1/drivers/i2c/busses/i2c-mv64xxx.c	2005-09-01 16:26:21.000000000 -0700
+++ linux-2.6.13-mm1-mag/drivers/i2c/busses/i2c-mv64xxx.c	2005-09-01 17:00:58.000000000 -0700
@@ -429,7 +429,7 @@
 		if ((rc = mv64xxx_i2c_execute_msg(drv_data, &msgs[i])) != 0)
 			break;
 
-	return rc;
+	return (rc < 0) ? rc : num;
 }
 
 static struct i2c_algorithm mv64xxx_i2c_algo = {
