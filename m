From: gregkh@suse.de (Greg KH)
Date: Mon, 05 Sep 2005 23:47:30 +0000
Subject: [lm-sensors] [PATCH] I2C: Outdated i2c_adapter comment
Message-Id: <11259567701915@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] I2C: Outdated i2c_adapter comment

Delete an outdated comment about i2c_algorithm.id being computed
from algo->id.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 020789e9cb688ac8b15a9950d25fe45492b23398
tree 71634ce861f1bed2159a9db16c83004015996e59
parent c2459cf257106cea5adbc83f084b76d0030eb700
author Jean Delvare <khali@linux-fr.org> Sat, 13 Aug 2005 13:04:32 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 05 Sep 2005 09:14:33 -0700

 include/linux/i2c.h |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/include/linux/i2c.h b/include/linux/i2c.h
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -219,8 +219,7 @@ struct i2c_algorithm {
  */
 struct i2c_adapter {
 	struct module *owner;
-	unsigned int id;/* = is algo->id | hwdep.struct->id, 		*/
-			/* for registered values see below		*/
+	unsigned int id;
 	unsigned int class;
 	struct i2c_algorithm *algo;/* the algorithm to access the bus	*/
 	void *algo_data;

