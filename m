From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:36 +0000
Subject: [PATCH] i2c driver fixes for 2.6.1
Message-Id: <10745567651848@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <10745567643254@kroah.com>
References: <1074556757661@kroah.com>
In-Reply-To: <1074556757661@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1474.98.20, 2004/01/19 12:49:37-08:00, khali@linux-fr.org

[PATCH] I2C: Fix lm90.c with DEBUG

The recent patch that fixes lm83.c with DEBUG also applies to lm90.c. No
wonder since I used the first as a template when porting the second.
Patch follows.


 drivers/i2c/chips/lm90.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff -Nru a/drivers/i2c/chips/lm90.c b/drivers/i2c/chips/lm90.c
--- a/drivers/i2c/chips/lm90.c	Mon Jan 19 15:29:26 2004
+++ b/drivers/i2c/chips/lm90.c	Mon Jan 19 15:29:26 2004
@@ -320,8 +320,8 @@
 
 		if ((reg_config1 & 0x2A) != 0x00
 		 || reg_convrate > 0x0A) {
-			dev_dbg(&client->dev,
-				"LM90 detection failed at 0x%02x.\n"
+			dev_dbg(&adapter->dev,
+				"LM90 detection failed at 0x%02x.\n",
 				address);
 			goto exit_free;
 		}

