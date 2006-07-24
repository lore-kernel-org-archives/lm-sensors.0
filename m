From: adobriyan@gmail.com (Alexey Dobriyan)
Date: Mon, 24 Jul 2006 08:31:18 +0000
Subject: [lm-sensors] [PATCH] atxp1: signed/unsigned char bug
Message-Id: <20060724083118.GB6815@martell.zuzino.mipt.ru>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

vid_to_reg() can return -1 and char can be unsigned.

Signed-off-by: Alexey Dobriyan <adobriyan at gmail.com>
---

 drivers/hwmon/atxp1.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/hwmon/atxp1.c
+++ b/drivers/hwmon/atxp1.c
@@ -116,8 +116,7 @@ static ssize_t atxp1_storevcore(struct d
 {
 	struct atxp1_data *data;
 	struct i2c_client *client;
-	char vid;
-	char cvid;
+	int vid, cvid;
 	unsigned int vcore;
 
 	client = to_i2c_client(dev);


