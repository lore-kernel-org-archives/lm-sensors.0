From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:19 +0000
Subject: [PATCH] i2c driver fixes for 2.6.0-test5
Message-Id: <1064273428551@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <10642734271572@kroah.com>
References: <1064273416272@kroah.com>
In-Reply-To: <1064273416272@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1315.1.25, 2003/09/22 15:11:24-07:00, greg@kroah.com

[PATCH] I2C: remove check_region usage and warning from i2c-sensor


 drivers/i2c/i2c-sensor.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)


diff -Nru a/drivers/i2c/i2c-sensor.c b/drivers/i2c/i2c-sensor.c
--- a/drivers/i2c/i2c-sensor.c	Mon Sep 22 16:11:52 2003
+++ b/drivers/i2c/i2c-sensor.c	Mon Sep 22 16:11:52 2003
@@ -50,8 +50,9 @@
 		return -1;
 
 	for (addr = 0x00; addr <= (is_isa ? 0xffff : 0x7f); addr++) {
-		/* XXX: WTF is going on here??? */
-		if ((is_isa && check_region(addr, 1)) ||
+		void *region_used = request_region(addr, 1, "foo");
+		release_region(addr, 1);
+		if ((is_isa && (region_used = NULL)) ||
 		    (!is_isa && i2c_check_addr(adapter, addr)))
 			continue;
 

