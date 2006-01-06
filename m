From: gregkh@suse.de (Greg KH)
Date: Fri, 06 Jan 2006 22:07:38 +0000
Subject: [lm-sensors] [PATCH] i2c: I2C_DF_NOTIFY removal comment cleanups
Message-Id: <11365852582508@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] i2c: I2C_DF_NOTIFY removal comment cleanups

The removal of I2C_DF_NOTIFY left some out of date comments in the
code. Drop them.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>

---
commit 3fb81a3df63e1900a7b3f496806a3f8d2b4295dd
tree ac8ae7f705d116aec60c32dfa5bfdb2d7f6adeb4
parent fb687d73fa7685ffeed1a6b24fadb5f4db817783
author Jean Delvare <khali at linux-fr.org> Sun, 18 Dec 2005 17:11:51 +0100
committer Greg Kroah-Hartman <gregkh at suse.de> Thu, 05 Jan 2006 22:16:27 -0800

 drivers/i2c/i2c-core.c |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index c23443e..52b7747 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -246,10 +246,6 @@ int i2c_del_adapter(struct i2c_adapter *
 	list_for_each_safe(item, _n, &adap->clients) {
 		client = list_entry(item, struct i2c_client, list);
 
-		/* detaching devices is unconditional of the set notify
-		 * flag, as _all_ clients that reside on the adapter
-		 * must be deleted, as this would cause invalid states.
-		 */
 		if ((res=client->driver->detach_client(client))) {
 			dev_err(&adap->dev, "detach_client failed for client "
 				"[%s] at address 0x%02x\n", client->name,
@@ -335,10 +331,6 @@ int i2c_del_driver(struct i2c_driver *dr
 	/* Have a look at each adapter, if clients of this driver are still
 	 * attached. If so, detach them to be able to kill the driver 
 	 * afterwards.
-	 *
-	 * Removing clients does not depend on the notify flag, else
-	 * invalid operation might (will!) result, when using stale client
-	 * pointers.
 	 */
 	list_for_each(item1,&adapters) {
 		adap = list_entry(item1, struct i2c_adapter, list);


