From: gregkh@suse.de (Greg KH)
Date: Sat, 29 Oct 2005 00:15:24 +0000
Subject: [lm-sensors] [PATCH] i2c: kzalloc cleanups, 2 of 2
Message-Id: <1130533663623@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] i2c: kzalloc cleanups, 2 of 2

Use kzalloc instead of kmalloc in the S4882 SMBus multiplexing driver.
I guess it's safer that way.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit deb875c7ff2ef417a2daff41ee4b357098b7ab10
tree aad952c341d91e9c6bda7653d73bb8f2624dd8a0
parent 078d9fe4fe8dada13e37d2e2790b0ad780324097
author Jean Delvare <khali@linux-fr.org> Mon, 17 Oct 2005 23:14:31 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 28 Oct 2005 14:02:12 -0700

 drivers/i2c/busses/i2c-amd756-s4882.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-amd756-s4882.c b/drivers/i2c/busses/i2c-amd756-s4882.c
index 4e553e8..f51ab65 100644
--- a/drivers/i2c/busses/i2c-amd756-s4882.c
+++ b/drivers/i2c/busses/i2c-amd756-s4882.c
@@ -169,12 +169,12 @@ static int __init amd756_s4882_init(void
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

