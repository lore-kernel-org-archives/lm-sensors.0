From: gregkh@suse.de (Greg KH)
Date: Sat, 29 Oct 2005 01:14:23 +0000
Subject: [lm-sensors] [PATCH] hwmon: Discard bogus comment about init
Message-Id: <11305336571556@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] hwmon: Discard bogus comment about init setting limits

Discard a common out-of-date comment in 5 hardware monitoring drivers.
The hardware monitoring chip drivers are no more setting sensor limits
at initialization time, for quite some time already.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

 drivers/hwmon/lm78.c     |    1 -
 drivers/hwmon/via686a.c  |    1 -
 drivers/hwmon/w83627hf.c |    1 -
 drivers/hwmon/w83781d.c  |    1 -
 drivers/hwmon/w83792d.c  |    1 -
 5 files changed, 5 deletions(-)

---
commit 7d845b10d06fa20a595a5161edabc5e846ed28a6
tree 93082c4be645f1d7a242e34de74d343e1aa3ff46
parent 0200296310a454b39efc995e676f9ff60e641edb
author Jean Delvare <khali@linux-fr.org> Sun, 25 Sep 2005 16:29:38 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 28 Oct 2005 14:02:06 -0700

 drivers/hwmon/lm78.c     |    1 -
 drivers/hwmon/via686a.c  |    1 -
 drivers/hwmon/w83627hf.c |    1 -
 drivers/hwmon/w83781d.c  |    1 -
 drivers/hwmon/w83792d.c  |    1 -
 5 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/lm78.c b/drivers/hwmon/lm78.c
index f6730dc..d697a55 100644
--- a/drivers/hwmon/lm78.c
+++ b/drivers/hwmon/lm78.c
@@ -726,7 +726,6 @@ static int lm78_write_value(struct i2c_c
 		return i2c_smbus_write_byte_data(client, reg, value);
 }
 
-/* Called when we have found a new LM78. It should set limits, etc. */
 static void lm78_init_client(struct i2c_client *client)
 {
 	u8 config = lm78_read_value(client, LM78_REG_CONFIG);
diff --git a/drivers/hwmon/via686a.c b/drivers/hwmon/via686a.c
index 54861f1..c6e64f4 100644
--- a/drivers/hwmon/via686a.c
+++ b/drivers/hwmon/via686a.c
@@ -712,7 +712,6 @@ static int via686a_detach_client(struct 
 	return 0;
 }
 
-/* Called when we have found a new VIA686A. Set limits, etc. */
 static void via686a_init_client(struct i2c_client *client)
 {
 	u8 reg;
diff --git a/drivers/hwmon/w83627hf.c b/drivers/hwmon/w83627hf.c
index 3479dc5..7f6f728 100644
--- a/drivers/hwmon/w83627hf.c
+++ b/drivers/hwmon/w83627hf.c
@@ -1275,7 +1275,6 @@ static int w83627hf_write_value(struct i
 	return 0;
 }
 
-/* Called when we have found a new W83781D. It should set limits, etc. */
 static void w83627hf_init_client(struct i2c_client *client)
 {
 	struct w83627hf_data *data = i2c_get_clientdata(client);
diff --git a/drivers/hwmon/w83781d.c b/drivers/hwmon/w83781d.c
index 4c43337..26b1fac 100644
--- a/drivers/hwmon/w83781d.c
+++ b/drivers/hwmon/w83781d.c
@@ -1451,7 +1451,6 @@ w83781d_write_value(struct i2c_client *c
 	return 0;
 }
 
-/* Called when we have found a new W83781D. It should set limits, etc. */
 static void
 w83781d_init_client(struct i2c_client *client)
 {
diff --git a/drivers/hwmon/w83792d.c b/drivers/hwmon/w83792d.c
index ba0c280..7bbd188 100644
--- a/drivers/hwmon/w83792d.c
+++ b/drivers/hwmon/w83792d.c
@@ -1429,7 +1429,6 @@ w83792d_write_value(struct i2c_client *c
 	return 0;
 }
 
-/* Called when we have found a new W83792D. It should set limits, etc. */
 static void
 w83792d_init_client(struct i2c_client *client)
 {

