From: gregkh@suse.de (Greg KH)
Date: Mon, 05 Sep 2005 23:48:15 +0000
Subject: [lm-sensors] [PATCH] I2C: inline i2c_adapter_id
Message-Id: <11259567671427@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] I2C: inline i2c_adapter_id

We could inline i2c_adapter_id, as it is really, really short. Doing
so saves a few bytes both in i2c-core and in the drivers using this
function.

                                            before     after      diff
drivers/hwmon/adm1026.ko                     41344     41305       -39
drivers/hwmon/asb100.ko                      27325     27246       -79
drivers/hwmon/gl518sm.ko                     20824     20785       -39
drivers/hwmon/it87.ko                        26419     26380       -39
drivers/hwmon/lm78.ko                        21424     21385       -39
drivers/hwmon/lm85.ko                        41034     40939       -95
drivers/hwmon/w83781d.ko                     39561     39514       -47
drivers/hwmon/w83792d.ko                     32979     32932       -47
drivers/i2c/i2c-core.ko                      24708     24531      -177

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit cdcb19219714c796ddef1202e952566c5f86354d
tree 35569bf55128dbbeac19fc05db8ce2bb940fdb18
parent e6cfb3ad7209e4f4dcdc14f5fc437db55667041f
author Jean Delvare <khali@linux-fr.org> Thu, 28 Jul 2005 23:09:40 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 05 Sep 2005 09:14:15 -0700

 drivers/i2c/i2c-core.c |    9 ---------
 include/linux/i2c.h    |   10 ++++++----
 2 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -759,14 +759,6 @@ int i2c_probe(struct i2c_adapter *adapte
 	return 0;
 }
 
-/*
- * return id number for a specific adapter
- */
-int i2c_adapter_id(struct i2c_adapter *adap)
-{
-	return adap->nr;
-}
-
 struct i2c_adapter* i2c_get_adapter(int id)
 {
 	struct i2c_adapter *adapter;
@@ -1196,7 +1188,6 @@ EXPORT_SYMBOL(i2c_master_send);
 EXPORT_SYMBOL(i2c_master_recv);
 EXPORT_SYMBOL(i2c_control);
 EXPORT_SYMBOL(i2c_transfer);
-EXPORT_SYMBOL(i2c_adapter_id);
 EXPORT_SYMBOL(i2c_get_adapter);
 EXPORT_SYMBOL(i2c_put_adapter);
 EXPORT_SYMBOL(i2c_probe);
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -364,10 +364,6 @@ extern int i2c_probe(struct i2c_adapter 
  */
 extern int i2c_control(struct i2c_client *,unsigned int, unsigned long);
 
-/* This call returns a unique low identifier for each registered adapter,
- * or -1 if the adapter was not registered. 
- */
-extern int i2c_adapter_id(struct i2c_adapter *adap);
 extern struct i2c_adapter* i2c_get_adapter(int id);
 extern void i2c_put_adapter(struct i2c_adapter *adap);
 
@@ -384,6 +380,12 @@ static inline int i2c_check_functionalit
 	return (func & i2c_get_functionality(adap)) = func;
 }
 
+/* Return id number for a specific adapter */
+static inline int i2c_adapter_id(struct i2c_adapter *adap)
+{
+	return adap->nr;
+}
+
 /*
  * I2C Message - used for pure i2c transaction, also from /dev interface
  */

