From: greg@kroah.com (Greg KH)
Date: Thu, 28 Sep 2006 22:48:23 +0000
Subject: [lm-sensors] [PATCH 3/39] atxp1: Signed/unsigned char bug fix
Message-Id: <11594837471774-git-send-email-greg@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Alexey Dobriyan <adobriyan at gmail.com>

vid_to_reg() can return -1 and char can be unsigned.

Signed-off-by: Alexey Dobriyan <adobriyan at gmail.com>
Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>
---
 drivers/hwmon/atxp1.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/atxp1.c b/drivers/hwmon/atxp1.c
index 728a1e8..ba843f8 100644
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
-- 
1.4.2.1


