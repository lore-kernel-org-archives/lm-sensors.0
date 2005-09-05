From: gregkh@suse.de (Greg KH)
Date: Mon, 05 Sep 2005 23:47:22 +0000
Subject: [lm-sensors] [PATCH] I2C: Kill i2c_algorithm.id (3/7)
Message-Id: <11259567701956@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] I2C: Kill i2c_algorithm.id (3/7)

Don't rely on i2c_algorithm.id to alter the i2c adapter's id, use the
I2C_ALGO_* value directly instead, because i2c_algorithm will soon
have no id member no more.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 87c3d7a8bc0ff5c8d4481e509b407b6be1859925
tree 73fadb7bdd87a054cf3131b541af4216ba545755
parent e51cc6b3a365e170d3ebe51c2308fdd42e027a46
author Jean Delvare <khali@linux-fr.org> Thu, 11 Aug 2005 23:38:52 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 05 Sep 2005 09:14:29 -0700

 drivers/i2c/algos/i2c-algo-bit.c    |    2 +-
 drivers/i2c/algos/i2c-algo-ite.c    |    2 +-
 drivers/i2c/algos/i2c-algo-pca.c    |    2 +-
 drivers/i2c/algos/i2c-algo-pcf.c    |    2 +-
 drivers/i2c/algos/i2c-algo-sgi.c    |    2 +-
 drivers/i2c/algos/i2c-algo-sibyte.c |    2 +-
 drivers/i2c/busses/i2c-ibm_iic.c    |    2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/algos/i2c-algo-bit.c b/drivers/i2c/algos/i2c-algo-bit.c
--- a/drivers/i2c/algos/i2c-algo-bit.c
+++ b/drivers/i2c/algos/i2c-algo-bit.c
@@ -541,7 +541,7 @@ int i2c_bit_add_bus(struct i2c_adapter *
 
 	/* register new adapter to i2c module... */
 
-	adap->id |= i2c_bit_algo.id;
+	adap->id |= I2C_ALGO_BIT;
 	adap->algo = &i2c_bit_algo;
 
 	adap->timeout = 100;	/* default values, should	*/
diff --git a/drivers/i2c/algos/i2c-algo-ite.c b/drivers/i2c/algos/i2c-algo-ite.c
--- a/drivers/i2c/algos/i2c-algo-ite.c
+++ b/drivers/i2c/algos/i2c-algo-ite.c
@@ -738,7 +738,7 @@ int i2c_iic_add_bus(struct i2c_adapter *
 
 	/* register new adapter to i2c module... */
 
-	adap->id |= iic_algo.id;
+	adap->id |= I2C_ALGO_IIC;
 	adap->algo = &iic_algo;
 
 	adap->timeout = 100;	/* default values, should	*/
diff --git a/drivers/i2c/algos/i2c-algo-pca.c b/drivers/i2c/algos/i2c-algo-pca.c
--- a/drivers/i2c/algos/i2c-algo-pca.c
+++ b/drivers/i2c/algos/i2c-algo-pca.c
@@ -371,7 +371,7 @@ int i2c_pca_add_bus(struct i2c_adapter *
 
 	/* register new adapter to i2c module... */
 
-	adap->id |= pca_algo.id;
+	adap->id |= I2C_ALGO_PCA;
 	adap->algo = &pca_algo;
 
 	adap->timeout = 100;		/* default values, should	*/
diff --git a/drivers/i2c/algos/i2c-algo-pcf.c b/drivers/i2c/algos/i2c-algo-pcf.c
--- a/drivers/i2c/algos/i2c-algo-pcf.c
+++ b/drivers/i2c/algos/i2c-algo-pcf.c
@@ -476,7 +476,7 @@ int i2c_pcf_add_bus(struct i2c_adapter *
 
 	/* register new adapter to i2c module... */
 
-	adap->id |= pcf_algo.id;
+	adap->id |= I2C_ALGO_PCF;
 	adap->algo = &pcf_algo;
 
 	adap->timeout = 100;		/* default values, should	*/
diff --git a/drivers/i2c/algos/i2c-algo-sgi.c b/drivers/i2c/algos/i2c-algo-sgi.c
--- a/drivers/i2c/algos/i2c-algo-sgi.c
+++ b/drivers/i2c/algos/i2c-algo-sgi.c
@@ -168,7 +168,7 @@ static struct i2c_algorithm sgi_algo = {
  */
 int i2c_sgi_add_bus(struct i2c_adapter *adap)
 {
-	adap->id |= sgi_algo.id;
+	adap->id |= I2C_ALGO_SGI;
 	adap->algo = &sgi_algo;
 
 	return i2c_add_adapter(adap);
diff --git a/drivers/i2c/algos/i2c-algo-sibyte.c b/drivers/i2c/algos/i2c-algo-sibyte.c
--- a/drivers/i2c/algos/i2c-algo-sibyte.c
+++ b/drivers/i2c/algos/i2c-algo-sibyte.c
@@ -151,7 +151,7 @@ int i2c_sibyte_add_bus(struct i2c_adapte
 
 	/* register new adapter to i2c module... */
 
-	i2c_adap->id |= i2c_sibyte_algo.id;
+	i2c_adap->id |= I2C_ALGO_SIBYTE;
 	i2c_adap->algo = &i2c_sibyte_algo;
         
         /* Set the frequency to 100 kHz */
diff --git a/drivers/i2c/busses/i2c-ibm_iic.c b/drivers/i2c/busses/i2c-ibm_iic.c
--- a/drivers/i2c/busses/i2c-ibm_iic.c
+++ b/drivers/i2c/busses/i2c-ibm_iic.c
@@ -726,7 +726,7 @@ static int __devinit iic_probe(struct oc
 	adap = &dev->adap;
 	strcpy(adap->name, "IBM IIC");
 	i2c_set_adapdata(adap, dev);
-	adap->id = I2C_HW_OCP | iic_algo.id;
+	adap->id = I2C_ALGO_OCP | I2C_HW_OCP;
 	adap->algo = &iic_algo;
 	adap->client_register = NULL;
 	adap->client_unregister = NULL;

