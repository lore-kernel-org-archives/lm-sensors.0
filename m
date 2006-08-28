From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 28 Aug 2006 12:18:14 +0000
Subject: [lm-sensors] [PATCH 01/14] atxp1: Signed/unsigned char bug fix
Message-Id: <20060828141814.71640724.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Alexey Dobriyan <adobriyan at gmail.com>
Content-Disposition: inline; filename=hwmon-atxp1-signed-unsigned-char-bug.patch

vid_to_reg() can return -1 and char can be unsigned.

Signed-off-by: Alexey Dobriyan <adobriyan at gmail.com>
Signed-off-by: Jean Delvare <khali at linux-fr.org>
---

 drivers/hwmon/atxp1.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- linux-2.6.18-rc4.orig/drivers/hwmon/atxp1.c	2006-08-27 22:32:01.000000000 +0200
+++ linux-2.6.18-rc4/drivers/hwmon/atxp1.c	2006-08-27 22:34:49.000000000 +0200
@@ -116,8 +116,7 @@
 {
 	struct atxp1_data *data;
 	struct i2c_client *client;
-	char vid;
-	char cvid;
+	int vid, cvid;
 	unsigned int vcore;
 
 	client = to_i2c_client(dev);

-- 
Jean Delvare

