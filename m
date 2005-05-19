From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:23:56 +0000
Subject: [PATCH] Yet more i2c driver changes for 2.5.69
Message-Id: <1053385947386@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <1053385947756@kroah.com>
References: <20030323081431.GF26145@kroah.com>
In-Reply-To: <20030323081431.GF26145@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1093.2.3, 2003/05/19 10:37:20-07:00, warp@mercury.d2dc.net

[PATCH] I2C: And yet another it87 patch.

Trivial, but important.

Somehow in the patching the bk tree somehow got two memset's to clear
new_client in it87_detect, normally while this would be bad, it would
not be critical.

However one of the two happens BEFORE the variable is set, and thus
things go badly.


 drivers/i2c/chips/it87.c |    1 -
 1 files changed, 1 deletion(-)


diff -Nru a/drivers/i2c/chips/it87.c b/drivers/i2c/chips/it87.c
--- a/drivers/i2c/chips/it87.c	Mon May 19 15:58:52 2003
+++ b/drivers/i2c/chips/it87.c	Mon May 19 15:58:52 2003
@@ -630,7 +630,6 @@
 			}
 		}
 	}
-	memset (new_client, 0x00, sizeof(struct i2c_client) + sizeof(struct it87_data));
 
 	/* OK. For now, we presume we have a valid client. We now create the
 	   client structure, even though we cannot fill it completely yet.

