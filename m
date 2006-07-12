From: greg@kroah.com (Greg KH)
Date: Wed, 12 Jul 2006 23:27:20 +0000
Subject: [lm-sensors] [PATCH 8/13] [PATCH] i2c: Handle i2c_add_adapter
Message-Id: <11527468683316-git-send-email-greg@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Mark M. Hoffman <mhoffman at lightlink.com>

Content-Disposition: inline; filename=i2c-algo-error-handling-fix.patch

It is possible for i2c_add_adapter() to fail.  Several I2C algorithm
drivers ignore that fact.  This (compile-tested only) patch fixes them.

Signed-off-by: Mark M. Hoffman <mhoffman at lightlink.com>
Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>
---
 drivers/i2c/algos/i2c-algo-bit.c    |    3 +--
 drivers/i2c/algos/i2c-algo-ite.c    |    4 +---
 drivers/i2c/algos/i2c-algo-pca.c    |    6 +++---
 drivers/i2c/algos/i2c-algo-pcf.c    |    8 +++++---
 drivers/i2c/algos/i2c-algo-sibyte.c |    4 +---
 5 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/i2c/algos/i2c-algo-bit.c b/drivers/i2c/algos/i2c-algo-bit.c
index df05df1..3d6fc82 100644
--- a/drivers/i2c/algos/i2c-algo-bit.c
+++ b/drivers/i2c/algos/i2c-algo-bit.c
@@ -544,8 +544,7 @@ int i2c_bit_add_bus(struct i2c_adapter *
 	adap->timeout = 100;	/* default values, should	*/
 	adap->retries = 3;	/* be replaced by defines	*/
 
-	i2c_add_adapter(adap);
-	return 0;
+	return i2c_add_adapter(adap);
 }
 
 
diff --git a/drivers/i2c/algos/i2c-algo-ite.c b/drivers/i2c/algos/i2c-algo-ite.c
index 2db7bfc..70d8eef 100644
--- a/drivers/i2c/algos/i2c-algo-ite.c
+++ b/drivers/i2c/algos/i2c-algo-ite.c
@@ -742,10 +742,8 @@ int i2c_iic_add_bus(struct i2c_adapter *
 	adap->retries = 3;		/* be replaced by defines	*/
 	adap->flags = 0;
 
-	i2c_add_adapter(adap);
 	iic_init(iic_adap);
-
-	return 0;
+	return i2c_add_adapter(adap);
 }
 
 
diff --git a/drivers/i2c/algos/i2c-algo-pca.c b/drivers/i2c/algos/i2c-algo-pca.c
index 82946ac..b88a6fc 100644
--- a/drivers/i2c/algos/i2c-algo-pca.c
+++ b/drivers/i2c/algos/i2c-algo-pca.c
@@ -374,10 +374,10 @@ int i2c_pca_add_bus(struct i2c_adapter *
 	adap->timeout = 100;		/* default values, should	*/
 	adap->retries = 3;		/* be replaced by defines	*/
 
-	rval = pca_init(pca_adap);
+	if ((rval = pca_init(pca_adap)))
+		return rval;
 
-	if (!rval)
-		i2c_add_adapter(adap);
+	rval = i2c_add_adapter(adap);
 
 	return rval;
 }
diff --git a/drivers/i2c/algos/i2c-algo-pcf.c b/drivers/i2c/algos/i2c-algo-pcf.c
index 6e498df..5b24930 100644
--- a/drivers/i2c/algos/i2c-algo-pcf.c
+++ b/drivers/i2c/algos/i2c-algo-pcf.c
@@ -479,9 +479,11 @@ int i2c_pcf_add_bus(struct i2c_adapter *
 	adap->timeout = 100;		/* default values, should	*/
 	adap->retries = 3;		/* be replaced by defines	*/
 
-	rval = pcf_init_8584(pcf_adap);
-	if (!rval)
-		i2c_add_adapter(adap);
+	if ((rval = pcf_init_8584(pcf_adap)))
+		return rval;
+
+	rval = i2c_add_adapter(adap);
+
 	return rval;
 }
 
diff --git a/drivers/i2c/algos/i2c-algo-sibyte.c b/drivers/i2c/algos/i2c-algo-sibyte.c
index 3df3f09..32d41c6 100644
--- a/drivers/i2c/algos/i2c-algo-sibyte.c
+++ b/drivers/i2c/algos/i2c-algo-sibyte.c
@@ -173,9 +173,7 @@ int i2c_sibyte_add_bus(struct i2c_adapte
 		printk("\n");
 	}
 
-	i2c_add_adapter(i2c_adap);
-
-	return 0;
+	return i2c_add_adapter(i2c_adap);
 }
 
 
-- 
1.4.1


