From: greg@kroah.com (Greg KH)
Date: Wed, 27 Sep 2006 01:01:57 +0000
Subject: [lm-sensors] [PATCH 26/30] i2c-isa: Restore driver owner
Message-Id: <11593190102288-git-send-email-greg@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Jean Delvare <khali at linux-fr.org>

i2c-isa: Restore driver owner

Commit 2b48716d1d2f2edb1e7cbc5ecf1cb2cb39373e33 back in January
2006 was a bit overzealous. It removed .owner from all i2c drivers,
including i2c-isa ones, while they still need it.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>
---
 drivers/hwmon/it87.c       |    1 +
 drivers/hwmon/lm78.c       |    1 +
 drivers/hwmon/pc87360.c    |    1 +
 drivers/hwmon/sis5595.c    |    1 +
 drivers/hwmon/smsc47b397.c |    1 +
 drivers/hwmon/smsc47m1.c   |    1 +
 drivers/hwmon/via686a.c    |    1 +
 drivers/hwmon/vt8231.c     |    1 +
 drivers/hwmon/w83627ehf.c  |    1 +
 drivers/hwmon/w83627hf.c   |    1 +
 drivers/hwmon/w83781d.c    |    1 +
 11 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
index 06df92b..b0ee574 100644
--- a/drivers/hwmon/it87.c
+++ b/drivers/hwmon/it87.c
@@ -243,6 +243,7 @@ static struct i2c_driver it87_driver = {
 
 static struct i2c_driver it87_isa_driver = {
 	.driver = {
+		.owner	= THIS_MODULE,
 		.name	= "it87-isa",
 	},
 	.attach_adapter	= it87_isa_attach_adapter,
diff --git a/drivers/hwmon/lm78.c b/drivers/hwmon/lm78.c
index a6ce7ab..fa1715b 100644
--- a/drivers/hwmon/lm78.c
+++ b/drivers/hwmon/lm78.c
@@ -175,6 +175,7 @@ static struct i2c_driver lm78_driver = {
 
 static struct i2c_driver lm78_isa_driver = {
 	.driver = {
+		.owner	= THIS_MODULE,
 		.name	= "lm78-isa",
 	},
 	.attach_adapter	= lm78_isa_attach_adapter,
diff --git a/drivers/hwmon/pc87360.c b/drivers/hwmon/pc87360.c
index ae05e48..236f9f2 100644
--- a/drivers/hwmon/pc87360.c
+++ b/drivers/hwmon/pc87360.c
@@ -238,6 +238,7 @@ static struct pc87360_data *pc87360_upda
 
 static struct i2c_driver pc87360_driver = {
 	.driver = {
+		.owner	= THIS_MODULE,
 		.name	= "pc87360",
 	},
 	.attach_adapter	= pc87360_detect,
diff --git a/drivers/hwmon/sis5595.c b/drivers/hwmon/sis5595.c
index 063f71c..3783af4 100644
--- a/drivers/hwmon/sis5595.c
+++ b/drivers/hwmon/sis5595.c
@@ -200,6 +200,7 @@ static void sis5595_init_client(struct i
 
 static struct i2c_driver sis5595_driver = {
 	.driver = {
+		.owner	= THIS_MODULE,
 		.name	= "sis5595",
 	},
 	.attach_adapter	= sis5595_detect,
diff --git a/drivers/hwmon/smsc47b397.c b/drivers/hwmon/smsc47b397.c
index b608618..a858693 100644
--- a/drivers/hwmon/smsc47b397.c
+++ b/drivers/hwmon/smsc47b397.c
@@ -228,6 +228,7 @@ static int smsc47b397_detect(struct i2c_
 
 static struct i2c_driver smsc47b397_driver = {
 	.driver = {
+		.owner	= THIS_MODULE,
 		.name	= "smsc47b397",
 	},
 	.attach_adapter	= smsc47b397_detect,
diff --git a/drivers/hwmon/smsc47m1.c b/drivers/hwmon/smsc47m1.c
index 825e8f7..6c81b84 100644
--- a/drivers/hwmon/smsc47m1.c
+++ b/drivers/hwmon/smsc47m1.c
@@ -128,6 +128,7 @@ static struct smsc47m1_data *smsc47m1_up
 
 static struct i2c_driver smsc47m1_driver = {
 	.driver = {
+		.owner	= THIS_MODULE,
 		.name	= "smsc47m1",
 	},
 	.attach_adapter	= smsc47m1_detect,
diff --git a/drivers/hwmon/via686a.c b/drivers/hwmon/via686a.c
index 166298f..95ae056 100644
--- a/drivers/hwmon/via686a.c
+++ b/drivers/hwmon/via686a.c
@@ -574,6 +574,7 @@ static DEVICE_ATTR(alarms, S_IRUGO, show
    smbus_driver and isa_driver, and clients could be of either kind */
 static struct i2c_driver via686a_driver = {
 	.driver = {
+		.owner	= THIS_MODULE,
 		.name	= "via686a",
 	},
 	.attach_adapter	= via686a_detect,
diff --git a/drivers/hwmon/vt8231.c b/drivers/hwmon/vt8231.c
index 686f3de..236ccf0 100644
--- a/drivers/hwmon/vt8231.c
+++ b/drivers/hwmon/vt8231.c
@@ -587,6 +587,7 @@ static DEVICE_ATTR(alarms, S_IRUGO, show
 
 static struct i2c_driver vt8231_driver = {
 	.driver = {
+		.owner	= THIS_MODULE,
 		.name	= "vt8231",
 	},
 	.attach_adapter	= vt8231_detect,
diff --git a/drivers/hwmon/w83627ehf.c b/drivers/hwmon/w83627ehf.c
index 40301bc..b21d6b9 100644
--- a/drivers/hwmon/w83627ehf.c
+++ b/drivers/hwmon/w83627ehf.c
@@ -903,6 +903,7 @@ static int w83627ehf_detach_client(struc
 
 static struct i2c_driver w83627ehf_driver = {
 	.driver = {
+		.owner	= THIS_MODULE,
 		.name	= "w83627ehf",
 	},
 	.attach_adapter	= w83627ehf_detect,
diff --git a/drivers/hwmon/w83627hf.c b/drivers/hwmon/w83627hf.c
index 79368d5..3029502 100644
--- a/drivers/hwmon/w83627hf.c
+++ b/drivers/hwmon/w83627hf.c
@@ -339,6 +339,7 @@ static void w83627hf_init_client(struct 
 
 static struct i2c_driver w83627hf_driver = {
 	.driver = {
+		.owner	= THIS_MODULE,
 		.name	= "w83627hf",
 	},
 	.attach_adapter	= w83627hf_detect,
diff --git a/drivers/hwmon/w83781d.c b/drivers/hwmon/w83781d.c
index 7be469e..95221b1 100644
--- a/drivers/hwmon/w83781d.c
+++ b/drivers/hwmon/w83781d.c
@@ -288,6 +288,7 @@ static struct i2c_driver w83781d_driver 
 
 static struct i2c_driver w83781d_isa_driver = {
 	.driver = {
+		.owner = THIS_MODULE,
 		.name = "w83781d-isa",
 	},
 	.attach_adapter = w83781d_isa_attach_adapter,
-- 
1.4.2.1


