From: greg@kroah.com (Greg KH)
Date: Wed, 27 Sep 2006 01:01:58 +0000
Subject: [lm-sensors] [PATCH 27/30] i2c: Let drivers constify i2c_algorithm
Message-Id: <11593190141717-git-send-email-greg@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: David Brownell <david-b at pacbell.net>

i2c: Let drivers constify i2c_algorithm data

Let drivers constify I2C algorithm method operations tables,
moving them from ".data" to ".rodata".

Signed-off-by: David Brownell <dbrownell at users.sourceforge.net>
Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>
---
 include/linux/i2c.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index eb0628a..23ad1ee 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -220,7 +220,7 @@ struct i2c_adapter {
 	struct module *owner;
 	unsigned int id;
 	unsigned int class;
-	struct i2c_algorithm *algo;/* the algorithm to access the bus	*/
+	const struct i2c_algorithm *algo; /* the algorithm to access the bus */
 	void *algo_data;
 
 	/* --- administration stuff. */
-- 
1.4.2.1


