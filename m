From: Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>
Date: Wed, 26 Mar 2014 20:11:04 +0000
Subject: [lm-sensors] [PATCH] misc: (ds1682) replace obsolete simple_strtoull() with kstrtoull()
Message-Id: <1395864664-16404-1-git-send-email-sebastien.bourdelin@savoirfairelinux.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@lm-sensors.org
Cc: jerome.oufella@savoirfairelinux.com, linux-kernel@vger.kernel.org, Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>

simple_strtoull() is obsolete, use the newer kstrtoull() instead.

Signed-off-by: Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>
---
 drivers/misc/ds1682.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/ds1682.c b/drivers/misc/ds1682.c
index 154b02e..155a150 100644
--- a/drivers/misc/ds1682.c
+++ b/drivers/misc/ds1682.c
@@ -86,7 +86,6 @@ static ssize_t ds1682_store(struct device *dev, struct device_attribute *attr,
 {
 	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
 	struct i2c_client *client = to_i2c_client(dev);
-	char *endp;
 	u64 val;
 	__le32 val_le;
 	int rc;
@@ -94,8 +93,8 @@ static ssize_t ds1682_store(struct device *dev, struct device_attribute *attr,
 	dev_dbg(dev, "ds1682_store() called on %s\n", attr->attr.name);
 
 	/* Decode input */
-	val = simple_strtoull(buf, &endp, 0);
-	if (buf = endp) {
+	rc = kstrtoull(buf, 0, &val);
+	if (rc < 0) {
 		dev_dbg(dev, "input string not a number\n");
 		return -EINVAL;
 	}
-- 
1.9.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
