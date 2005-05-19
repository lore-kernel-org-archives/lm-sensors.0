From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:36 +0000
Subject: [PATCH] i2c driver fixes for 2.6.1
Message-Id: <10745567653998@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <10745567651848@kroah.com>
References: <1074556757661@kroah.com>
In-Reply-To: <1074556757661@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1474.98.21, 2004/01/19 12:49:57-08:00, khali@linux-fr.org

[PATCH] I2C: Fix i2c-core.c with DEBUG

At the moment, i2c-core.c fails compiling with DEBUG. Following patch
should fix that.


 drivers/i2c/i2c-core.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
--- a/drivers/i2c/i2c-core.c	Mon Jan 19 15:29:13 2004
+++ b/drivers/i2c/i2c-core.c	Mon Jan 19 15:29:13 2004
@@ -373,7 +373,7 @@
 	}
 
 	DEB(dev_dbg(&adapter->dev, "client [%s] registered to adapter\n",
-			client->dev.name));
+			client->name));
 
 	if (client->flags & I2C_CLIENT_ALLOW_USE)
 		client->usage_count = 0;

