From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:23:55 +0000
Subject: [PATCH] i2c driver changes for 2.5.69
Message-Id: <10522676153273@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <1052267615125@kroah.com>
References: <10522676142536@kroah.com>
In-Reply-To: <10522676142536@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1085, 2003/05/06 17:18:27-07:00, greg@kroah.com

[PATCH] i2c: fix compile error due to previous patches.


 drivers/i2c/i2c-core.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff -Nru a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
--- a/drivers/i2c/i2c-core.c	Tue May  6 17:24:28 2003
+++ b/drivers/i2c/i2c-core.c	Tue May  6 17:24:28 2003
@@ -309,8 +309,8 @@
 		}
 	}
 
-	DEB(dev_dbg(&adapter->dev, "client [%s] registered to adapter "
-			"(pos. %d).\n", client->dev.name, i));
+	DEB(dev_dbg(&adapter->dev, "client [%s] registered to adapter\n",
+			client->dev.name));
 
 	if (client->flags & I2C_CLIENT_ALLOW_USE)
 		client->usage_count = 0;

