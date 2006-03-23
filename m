From: gregkh@suse.de (Greg KH)
Date: Thu, 23 Mar 2006 22:43:52 +0000
Subject: [lm-sensors] [PATCH 31/36] I2C: i2c-amd756-s4882: Improve static
Message-Id: <11431538322017-git-send-email-gregkh@suse.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Static mutexes can be initialized at declaration time.

Signed-off-by: Jean Delvare <khali at linux-fr.org>

---

 drivers/i2c/busses/i2c-amd756-s4882.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

d7d2fe384703f3f57dac94e8e6303a9f0d9a6239
diff --git a/drivers/i2c/busses/i2c-amd756-s4882.c b/drivers/i2c/busses/i2c-amd756-s4882.c
index f7b4cb4..08e9157 100644
--- a/drivers/i2c/busses/i2c-amd756-s4882.c
+++ b/drivers/i2c/busses/i2c-amd756-s4882.c
@@ -46,7 +46,7 @@ static struct i2c_adapter *s4882_adapter
 static struct i2c_algorithm *s4882_algo;
 
 /* Wrapper access functions for multiplexed SMBus */
-static struct mutex amd756_lock;
+static DEFINE_MUTEX(amd756_lock);
 
 static s32 amd756_access_virt0(struct i2c_adapter * adap, u16 addr,
 			       unsigned short flags, char read_write,
@@ -167,8 +167,6 @@ static int __init amd756_s4882_init(void
 	}
 
 	printk(KERN_INFO "Enabling SMBus multiplexing for Tyan S4882\n");
-	mutex_init(&amd756_lock);
-
 	/* Define the 5 virtual adapters and algorithms structures */
 	if (!(s4882_adapter = kzalloc(5 * sizeof(struct i2c_adapter),
 				      GFP_KERNEL))) {
-- 
1.2.4



