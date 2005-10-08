From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 08 Oct 2005 00:14:37 +0000
Subject: [lm-sensors] [PATCH 11/16] i2c: Drop unused per-i2c-algorithm
Message-Id: <20051008001417.5efb1573.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

There are no more per-i2c-algorithm adapter max. Last time there were
was in July 1999.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

 include/linux/i2c-algo-bit.h |    2 --
 include/linux/i2c-algo-pca.h |    2 --
 include/linux/i2c-algo-pcf.h |    2 --
 3 files changed, 6 deletions(-)

--- linux-2.6.14-rc3.orig/include/linux/i2c-algo-bit.h	2005-10-07 20:37:30.000000000 +0200
+++ linux-2.6.14-rc3/include/linux/i2c-algo-bit.h	2005-10-07 21:33:06.000000000 +0200
@@ -44,8 +44,6 @@
 	int timeout;		/* in jiffies */
 };
 
-#define I2C_BIT_ADAP_MAX	16
-
 int i2c_bit_add_bus(struct i2c_adapter *);
 int i2c_bit_del_bus(struct i2c_adapter *);
 
--- linux-2.6.14-rc3.orig/include/linux/i2c-algo-pca.h	2005-10-07 20:08:16.000000000 +0200
+++ linux-2.6.14-rc3/include/linux/i2c-algo-pca.h	2005-10-07 21:33:06.000000000 +0200
@@ -9,8 +9,6 @@
 	int  (*wait_for_interrupt)	(struct i2c_algo_pca_data *adap);
 };
 
-#define I2C_PCA_ADAP_MAX	16
-
 int i2c_pca_add_bus(struct i2c_adapter *);
 int i2c_pca_del_bus(struct i2c_adapter *);
 
--- linux-2.6.14-rc3.orig/include/linux/i2c-algo-pcf.h	2005-10-07 20:37:30.000000000 +0200
+++ linux-2.6.14-rc3/include/linux/i2c-algo-pcf.h	2005-10-07 21:33:06.000000000 +0200
@@ -39,8 +39,6 @@
 	int timeout;
 };
 
-#define I2C_PCF_ADAP_MAX	16
-
 int i2c_pcf_add_bus(struct i2c_adapter *);
 int i2c_pcf_del_bus(struct i2c_adapter *);
 

-- 
Jean Delvare
