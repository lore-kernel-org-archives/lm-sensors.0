From: kyosti.malkki@welho.com (=?ISO-8859-1?Q?Ky=F6sti_M=E4lkki?=)
Date: Thu, 19 May 2005 06:24:27 +0000
Subject: lm_sensors2/prog/dump i2cbusses.c
Message-Id: <Pine.LNX.4.53.0311300716090.4386@cosmos.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <3FC6898D.DF9ECF07@paradyne.com>
In-Reply-To: <3FC6898D.DF9ECF07@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Walk the list of adapters and exit with the smallest unused bus number.
Feeling lucky? No 2.6 here yet.

--- linux-2.6.0-test10/drivers/i2c/i2c-core.c	2003-11-24 13:33:19.000000000 +0200
+++ i2c-drv-model/i2c-core-bus-number.c	2003-11-30 07:10:36.000000000 +0200
@@ -122,13 +122,25 @@
  */
 int i2c_add_adapter(struct i2c_adapter *adap)
 {
-	static int nr = 0;
+	int used, nr;
 	struct list_head   *item;
 	struct i2c_driver  *driver;
+	struct i2c_adapter *adapter;

 	down(&core_lists);

-	adap->nr = nr++;
+	for (nr=0, used=1; used ; nr++) {
+		used = 0;
+		list_for_each(item,&adapters) {
+			adapter = list_entry(item, struct i2c_adapter, list);
+			if (nr = adapter->nr) {
+				used = 1;
+				break;
+			}
+		}
+	}
+	adap->nr = nr;
+
 	init_MUTEX(&adap->bus_lock);
 	init_MUTEX(&adap->clist_lock);
 	list_add_tail(&adap->list,&adapters);


-- 
  Ky?sti M?lkki  <kyosti.malkki@welho.com>  +358 50 462 8786
