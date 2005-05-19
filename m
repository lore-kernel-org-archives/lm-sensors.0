From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:47 +0000
Subject: [PATCH] i2c driver fixes for 2.6.4
Message-Id: <10793913932181@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <10793913931477@kroah.com>
References: <10793913903814@kroah.com>
In-Reply-To: <10793913903814@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1608.74.3, 2004/03/09 14:58:25-08:00, rmk+lkml@arm.linux.org.uk

[PATCH] I2C: Fix i2c_use_client()

i2c_use_client() contains a bogosity.  If i2c_inc_use_client() returns
success, i2c_use_client() returns an error.  If i2c_inc_use_client()
fails, i2c_use_client() might succeed.

Fix it so that (a) we get the correct sense between these two functions,
and (b) propagate the error code from i2c_inc_use_client(), rather than
making our own one up.


 drivers/i2c/i2c-core.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)


diff -Nru a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
--- a/drivers/i2c/i2c-core.c	Mon Mar 15 14:35:07 2004
+++ b/drivers/i2c/i2c-core.c	Mon Mar 15 14:35:07 2004
@@ -437,8 +437,11 @@
 
 int i2c_use_client(struct i2c_client *client)
 {
-	if (!i2c_inc_use_client(client))
-		return -ENODEV;
+	int ret;
+
+	ret = i2c_inc_use_client(client);
+	if (ret)
+		return ret;
 
 	if (client->flags & I2C_CLIENT_ALLOW_USE) {
 		if (client->flags & I2C_CLIENT_ALLOW_MULTIPLE_USE)

