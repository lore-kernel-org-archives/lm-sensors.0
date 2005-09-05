From: gregkh@suse.de (Greg KH)
Date: Mon, 05 Sep 2005 23:47:12 +0000
Subject: [lm-sensors] [PATCH] i2c: bug fix for busses/i2c-mv64xxx.c
Message-Id: <11259567713187@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] i2c: bug fix for busses/i2c-mv64xxx.c

When an i2c transfer is successful, an incorrect value is returned.
This patch fixes that.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit d1b2f0a9754d3087ee29b3e88b8f20f2d30090d3
tree 292f29b437f14c9af06ac276be48004ec1df8460
parent 8e14d6c173f8fff05a94e62669c87c26141766af
author Jean Delvare <khali@linux-fr.org> Fri, 02 Sep 2005 21:25:47 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 05 Sep 2005 09:26:53 -0700

 drivers/i2c/busses/i2c-mv64xxx.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
--- a/drivers/i2c/busses/i2c-mv64xxx.c
+++ b/drivers/i2c/busses/i2c-mv64xxx.c
@@ -423,13 +423,13 @@ static int
 mv64xxx_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 {
 	struct mv64xxx_i2c_data *drv_data = i2c_get_adapdata(adap);
-	int	i, rc = 0;
+	int	i, rc;
 
 	for (i=0; i<num; i++)
-		if ((rc = mv64xxx_i2c_execute_msg(drv_data, &msgs[i])) != 0)
-			break;
+		if ((rc = mv64xxx_i2c_execute_msg(drv_data, &msgs[i])) < 0)
+			return rc;
 
-	return rc;
+	return num;
 }
 
 static struct i2c_algorithm mv64xxx_i2c_algo = {

