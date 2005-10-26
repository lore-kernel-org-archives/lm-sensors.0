From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 26 Oct 2005 21:09:01 +0000
Subject: [lm-sensors] [PATCH 04/16] i2c: Static function fixes, 4 of 4
Message-Id: <20051026210941.28517044.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Ben Dooks <ben-linux@fluff.org>
Content-Disposition: inline; filename=static-04-i2c-chips-other.patch

Fix functions declared static and then implemented
without the static in drivers/i2c/chips.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
Signed-off-by: Jean Delvare <khali@linux-fr.org>

---
 drivers/i2c/chips/ds1374.c  |    3 ++-
 drivers/i2c/chips/pcf8574.c |    2 +-
 drivers/i2c/chips/pcf8591.c |    2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff -urpN -X ../dontdiff linux-2.6.14-rc4-git4-bjd1/drivers/i2c/chips/ds1374.c linux-2.6.14-rc4-git4-bjd2/drivers/i2c/chips/ds1374.c
--- linux-2.6.14-rc4-git4-bjd1/drivers/i2c/chips/ds1374.c	2005-10-11 10:56:32.000000000 +0100
+++ linux-2.6.14-rc4-git4-bjd2/drivers/i2c/chips/ds1374.c	2005-10-17 22:08:33.000000000 +0100
@@ -167,7 +167,8 @@ static void ds1374_set_tlet(ulong arg)
 
 static ulong new_time;
 
-DECLARE_TASKLET_DISABLED(ds1374_tasklet, ds1374_set_tlet, (ulong) & new_time);
+static DECLARE_TASKLET_DISABLED(ds1374_tasklet, ds1374_set_tlet,
+				(ulong) & new_time);
 
 int ds1374_set_rtc_time(ulong nowtime)
 {
diff -urpN -X ../dontdiff linux-2.6.14-rc4-git4-bjd1/drivers/i2c/chips/pcf8574.c linux-2.6.14-rc4-git4-bjd2/drivers/i2c/chips/pcf8574.c
--- linux-2.6.14-rc4-git4-bjd1/drivers/i2c/chips/pcf8574.c	2005-10-11 10:56:32.000000000 +0100
+++ linux-2.6.14-rc4-git4-bjd2/drivers/i2c/chips/pcf8574.c	2005-10-17 22:08:03.000000000 +0100
@@ -115,7 +115,7 @@ static int pcf8574_attach_adapter(struct
 }
 
 /* This function is called by i2c_probe */
-int pcf8574_detect(struct i2c_adapter *adapter, int address, int kind)
+static int pcf8574_detect(struct i2c_adapter *adapter, int address, int kind)
 {
 	struct i2c_client *new_client;
 	struct pcf8574_data *data;
diff -urpN -X ../dontdiff linux-2.6.14-rc4-git4-bjd1/drivers/i2c/chips/pcf8591.c linux-2.6.14-rc4-git4-bjd2/drivers/i2c/chips/pcf8591.c
--- linux-2.6.14-rc4-git4-bjd1/drivers/i2c/chips/pcf8591.c	2005-10-11 10:56:32.000000000 +0100
+++ linux-2.6.14-rc4-git4-bjd2/drivers/i2c/chips/pcf8591.c	2005-10-17 22:07:59.000000000 +0100
@@ -166,7 +166,7 @@ static int pcf8591_attach_adapter(struct
 }
 
 /* This function is called by i2c_probe */
-int pcf8591_detect(struct i2c_adapter *adapter, int address, int kind)
+static int pcf8591_detect(struct i2c_adapter *adapter, int address, int kind)
 {
 	struct i2c_client *new_client;
 	struct pcf8591_data *data;

-- 
Jean Delvare
