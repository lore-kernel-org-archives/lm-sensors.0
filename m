From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:19 +0000
Subject: [PATCH] More i2c driver fixes for 2.6.0-test5
Message-Id: <10645266091820@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <20030925214838.GA30072@kroah.com>
References: <1064526609700@kroah.com>
In-Reply-To: <1064526609700@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1325.4.1, 2003/09/23 13:54:31-07:00, greg@kroah.com

[PATCH] I2C: remove the isa address check alltogether.


 drivers/i2c/i2c-sensor.c |    5 +----
 1 files changed, 1 insertion(+), 4 deletions(-)


diff -Nru a/drivers/i2c/i2c-sensor.c b/drivers/i2c/i2c-sensor.c
--- a/drivers/i2c/i2c-sensor.c	Thu Sep 25 14:50:07 2003
+++ b/drivers/i2c/i2c-sensor.c	Thu Sep 25 14:50:07 2003
@@ -50,10 +50,7 @@
 		return -1;
 
 	for (addr = 0x00; addr <= (is_isa ? 0xffff : 0x7f); addr++) {
-		void *region_used = request_region(addr, 1, "foo");
-		release_region(addr, 1);
-		if ((is_isa && (region_used = NULL)) ||
-		    (!is_isa && i2c_check_addr(adapter, addr)))
+		if (!is_isa && i2c_check_addr(adapter, addr))
 			continue;
 
 		/* If it is in one of the force entries, we don't do any

