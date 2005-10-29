From: gregkh@suse.de (Greg KH)
Date: Sat, 29 Oct 2005 01:18:52 +0000
Subject: [lm-sensors] [PATCH] i2c: Static function fixes, 4 of 4
Message-Id: <1130533663774@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] i2c: Static function fixes, 4 of 4

Fix functions declared static and then implemented
without the static in drivers/i2c/chips.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 6344a8ece0bacccf61817450e8ccf78c973fc0c5
tree 2cfb965523a097ce90163dee5482ffa5fd5ab009
parent c49efceffa599299ab3f38b1cdf8c2f1bf9811c4
author Ben Dooks <ben-linux@fluff.org> Wed, 26 Oct 2005 21:09:41 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 28 Oct 2005 14:02:13 -0700

 drivers/i2c/chips/ds1374.c  |    3 ++-
 drivers/i2c/chips/pcf8574.c |    2 +-
 drivers/i2c/chips/pcf8591.c |    2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/chips/ds1374.c b/drivers/i2c/chips/ds1374.c
index 1596e64..da488b7 100644
--- a/drivers/i2c/chips/ds1374.c
+++ b/drivers/i2c/chips/ds1374.c
@@ -167,7 +167,8 @@ static void ds1374_set_tlet(ulong arg)
 
 static ulong new_time;
 
-DECLARE_TASKLET_DISABLED(ds1374_tasklet, ds1374_set_tlet, (ulong) & new_time);
+static DECLARE_TASKLET_DISABLED(ds1374_tasklet, ds1374_set_tlet,
+				(ulong) & new_time);
 
 int ds1374_set_rtc_time(ulong nowtime)
 {
diff --git a/drivers/i2c/chips/pcf8574.c b/drivers/i2c/chips/pcf8574.c
index 2c2555d..c323c2d 100644
--- a/drivers/i2c/chips/pcf8574.c
+++ b/drivers/i2c/chips/pcf8574.c
@@ -115,7 +115,7 @@ static int pcf8574_attach_adapter(struct
 }
 
 /* This function is called by i2c_probe */
-int pcf8574_detect(struct i2c_adapter *adapter, int address, int kind)
+static int pcf8574_detect(struct i2c_adapter *adapter, int address, int kind)
 {
 	struct i2c_client *new_client;
 	struct pcf8574_data *data;
diff --git a/drivers/i2c/chips/pcf8591.c b/drivers/i2c/chips/pcf8591.c
index 3c815b1..ce420a6 100644
--- a/drivers/i2c/chips/pcf8591.c
+++ b/drivers/i2c/chips/pcf8591.c
@@ -166,7 +166,7 @@ static int pcf8591_attach_adapter(struct
 }
 
 /* This function is called by i2c_probe */
-int pcf8591_detect(struct i2c_adapter *adapter, int address, int kind)
+static int pcf8591_detect(struct i2c_adapter *adapter, int address, int kind)
 {
 	struct i2c_client *new_client;
 	struct pcf8591_data *data;

