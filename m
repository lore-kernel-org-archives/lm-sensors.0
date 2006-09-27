From: greg@kroah.com (Greg KH)
Date: Wed, 27 Sep 2006 01:01:51 +0000
Subject: [lm-sensors] [PATCH 20/30] i2c-isa: Fail adding driver on
Message-Id: <11593189913557-git-send-email-greg@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: David Hubbard <david.c.hubbard at gmail.com>

i2c-isa: Fail adding driver on attach_adapter error

Signed-off-by: David Hubbard <david.c.hubbard at gmail.com>
Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>
---
 drivers/i2c/busses/i2c-isa.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-isa.c b/drivers/i2c/busses/i2c-isa.c
index d7486e5..7a8d2c1 100644
--- a/drivers/i2c/busses/i2c-isa.c
+++ b/drivers/i2c/busses/i2c-isa.c
@@ -89,9 +89,14 @@ int i2c_isa_add_driver(struct i2c_driver
 	dev_dbg(&isa_adapter.dev, "Driver %s registered\n", driver->driver.name);
 
 	/* Now look for clients */
-	driver->attach_adapter(&isa_adapter);
-
-	return 0;
+	res = driver->attach_adapter(&isa_adapter);
+	if (res) {
+		dev_err(&isa_adapter.dev,
+			"Driver %s failed to attach adapter, unregistering\n",
+			driver->driver.name);
+		driver_unregister(&driver->driver);
+	}
+	return res;
 }
 
 int i2c_isa_del_driver(struct i2c_driver *driver)
-- 
1.4.2.1


