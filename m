From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 18 Dec 2005 15:51:55 +0000
Subject: [lm-sensors] [PATCH 07/11] i2c: update i2c_driver.command
Message-Id: <20051218165155.7d51c135.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Content-Disposition: inline; filename=i2c-update-command-documentation.patch

Document i2c_driver.command as being deprecated, and don't suggest an
empty implementation of this callback as it doesn't make any sense.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
---
 Documentation/i2c/writing-clients |   10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

--- linux-2.6.15-rc5.orig/Documentation/i2c/writing-clients	2005-12-14 21:04:28.000000000 +0100
+++ linux-2.6.15-rc5/Documentation/i2c/writing-clients	2005-12-14 21:14:18.000000000 +0100
@@ -492,17 +492,13 @@
 by `__init_data'.  Hose functions and structures can be removed after
 kernel booting (or module loading) is completed.
 
+
 Command function
 ========
 
 A generic ioctl-like function call back is supported. You will seldom
-need this. You may even set it to NULL.
-
-  /* No commands defined */
-  int foo_command(struct i2c_client *client, unsigned int cmd, void *arg)
-  {
-    return 0;
-  }
+need this, and its use is deprecated anyway, so newer design should not
+use it. Set it to NULL.
 
 
 Sending and receiving

-- 
Jean Delvare

