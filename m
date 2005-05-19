From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:52 +0000
Subject: [PATCH] I2C update for 2.6.5
Message-Id: <10819814501036@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <10819814502943@kroah.com>
References: <10819814492866@kroah.com>
In-Reply-To: <10819814492866@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1643.36.11, 2004/03/30 14:27:21-08:00, khali@linux-fr.org

[PATCH] I2C: Discard pointless comment in via686a

The simple patch below discards a comment in via686a referencing a file
that doesn't belong to the Linux tree. Now that I tell people not to do
that in my porting guide, we better follow our own advice.


 drivers/i2c/chips/via686a.c |    1 -
 1 files changed, 1 deletion(-)


diff -Nru a/drivers/i2c/chips/via686a.c b/drivers/i2c/chips/via686a.c
--- a/drivers/i2c/chips/via686a.c	Wed Apr 14 15:14:05 2004
+++ b/drivers/i2c/chips/via686a.c	Wed Apr 14 15:14:05 2004
@@ -27,7 +27,6 @@
 /*
     Supports the Via VT82C686A, VT82C686B south bridges.
     Reports all as a 686A.
-    See doc/chips/via686a for details.
     Warning - only supports a single device.
 */
 

