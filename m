From: gregkh@suse.de (Greg KH)
Date: Sat, 29 Oct 2005 01:14:18 +0000
Subject: [lm-sensors] [PATCH] i2c: Drop unused per-i2c-algorithm adapter max
Message-Id: <11305336614072@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] i2c: Drop unused per-i2c-algorithm adapter max

There are no more per-i2c-algorithm adapter max. Last time there were
was in July 1999.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit d3554b4a2fb0e2229eb0d3fa9ece5b2f0b906d3e
tree 34015428b2b1eee320130b7fea86504ff41834d0
parent 862bc36f682b25dd97833f702b4f8c97661b8811
author Jean Delvare <khali@linux-fr.org> Sat, 08 Oct 2005 00:14:17 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 28 Oct 2005 14:02:10 -0700

 include/linux/i2c-algo-bit.h |    2 --
 include/linux/i2c-algo-pca.h |    2 --
 include/linux/i2c-algo-pcf.h |    2 --
 3 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/include/linux/i2c-algo-bit.h b/include/linux/i2c-algo-bit.h
index fb59214..c0e7fab 100644
--- a/include/linux/i2c-algo-bit.h
+++ b/include/linux/i2c-algo-bit.h
@@ -44,8 +44,6 @@ struct i2c_algo_bit_data {
 	int timeout;		/* in jiffies */
 };
 
-#define I2C_BIT_ADAP_MAX	16
-
 int i2c_bit_add_bus(struct i2c_adapter *);
 int i2c_bit_del_bus(struct i2c_adapter *);
 
diff --git a/include/linux/i2c-algo-pca.h b/include/linux/i2c-algo-pca.h
index 941b786..226693e 100644
--- a/include/linux/i2c-algo-pca.h
+++ b/include/linux/i2c-algo-pca.h
@@ -9,8 +9,6 @@ struct i2c_algo_pca_data {
 	int  (*wait_for_interrupt)	(struct i2c_algo_pca_data *adap);
 };
 
-#define I2C_PCA_ADAP_MAX	16
-
 int i2c_pca_add_bus(struct i2c_adapter *);
 int i2c_pca_del_bus(struct i2c_adapter *);
 
diff --git a/include/linux/i2c-algo-pcf.h b/include/linux/i2c-algo-pcf.h
index a0e534b..18b0adf 100644
--- a/include/linux/i2c-algo-pcf.h
+++ b/include/linux/i2c-algo-pcf.h
@@ -39,8 +39,6 @@ struct i2c_algo_pcf_data {
 	int timeout;
 };
 
-#define I2C_PCF_ADAP_MAX	16
-
 int i2c_pcf_add_bus(struct i2c_adapter *);
 int i2c_pcf_del_bus(struct i2c_adapter *);
 

