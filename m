From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 17 Oct 2005 23:14:11 +0000
Subject: [lm-sensors] [PATCH 13/14] i2c: kzalloc cleanups, 2 of 2
Message-Id: <20051017231431.05f69953.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Content-Disposition: inline; filename=kzalloc-05-i2c-amd756-s4882.patch

Use kzalloc instead of kmalloc in the S4882 SMBus multiplexing driver.
I guess it's safer that way.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

---
 drivers/i2c/busses/i2c-amd756-s4882.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.14-rc4.orig/drivers/i2c/busses/i2c-amd756-s4882.c	2005-10-13 22:55:48.000000000 +0200
+++ linux-2.6.14-rc4/drivers/i2c/busses/i2c-amd756-s4882.c	2005-10-13 23:04:50.000000000 +0200
@@ -169,12 +169,12 @@
 	init_MUTEX(&amd756_lock);
 
 	/* Define the 5 virtual adapters and algorithms structures */
-	if (!(s4882_adapter = kmalloc(5 * sizeof(struct i2c_adapter),
+	if (!(s4882_adapter = kzalloc(5 * sizeof(struct i2c_adapter),
 				      GFP_KERNEL))) {
 		error = -ENOMEM;
 		goto ERROR1;
 	}
-	if (!(s4882_algo = kmalloc(5 * sizeof(struct i2c_algorithm),
+	if (!(s4882_algo = kzalloc(5 * sizeof(struct i2c_algorithm),
 				   GFP_KERNEL))) {
 		error = -ENOMEM;
 		goto ERROR2;

-- 
Jean Delvare
