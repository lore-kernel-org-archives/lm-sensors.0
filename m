From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 26 Mar 2006 16:26:50 +0000
Subject: [lm-sensors] [PATCH] i2c: Prevent client usage count breakage
Message-Id: <20060326182650.770720a8.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

While working on the i2c chip probing stuff, I noticed the following
problem. Right now, no driver in the kernel tree seem to have hit it,
but let's fix it before any does. Can you please enqueue this patch for
2.6.17?

Thanks.

* * * * *
Content-Disposition: inline; filename=i2c-core-init-usage-count-before-calling-client-register.patch

The i2c clients usage count should be initialized before calling an
adapter's client_register method, else calling i2c_use_client from
within this method breaks the count.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
---
 drivers/i2c/i2c-core.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.16-git.orig/drivers/i2c/i2c-core.c	2006-03-26 18:10:42.000000000 +0200
+++ linux-2.6.16-git/drivers/i2c/i2c-core.c	2006-03-26 18:10:48.000000000 +0200
@@ -403,6 +403,8 @@
 	list_add_tail(&client->list,&adapter->clients);
 	mutex_unlock(&adapter->clist_lock);
 	
+	client->usage_count = 0;
+
 	if (adapter->client_register)  {
 		if (adapter->client_register(client))  {
 			dev_dbg(&adapter->dev, "client_register "
@@ -411,8 +413,6 @@
 		}
 	}
 
-	client->usage_count = 0;
-
 	client->dev.parent = &client->adapter->dev;
 	client->dev.driver = &client->driver->driver;
 	client->dev.bus = &i2c_bus_type;


-- 
Jean Delvare

