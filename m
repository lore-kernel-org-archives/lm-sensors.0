From: gregkh@suse.de (Greg KH)
Date: Thu, 19 May 2005 06:25:47 +0000
Subject: [PATCH] I2C: Skip broken detection step in it87
Message-Id: <1112311391247@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <1112311390208@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Cc: khali@linux-fr.org

ChangeSet 1.2329, 2005/03/31 14:07:24-08:00, khali@linux-fr.org

[PATCH] I2C: Skip broken detection step in it87

One of the detection steps in the it87 chip driver was reported to be
broken for some revisions of the IT8712F chip [1] [2]. This detection
step is a legacy from the lm78 driver and the documentation available
for the IT8705F and IT8712F chips does not mention it at all. For this
reason, I propose to skip this detection step for Super-I/O chips.
Super-I/O chips have already been identified when we reach this step, so
it is redundant (additionally do being broken). This closes bug #4335.

[1] http://bugzilla.kernel.org/show_bug.cgi?idC35
[2] http://archives.andrew.net.au/lm-sensors/msg29962.html

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 drivers/i2c/chips/it87.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)


diff -Nru a/drivers/i2c/chips/it87.c b/drivers/i2c/chips/it87.c
--- a/drivers/i2c/chips/it87.c	2005-03-31 15:18:29 -08:00
+++ b/drivers/i2c/chips/it87.c	2005-03-31 15:18:29 -08:00
@@ -734,10 +734,9 @@
 			goto ERROR0;
 
 	/* Probe whether there is anything available on this address. Already
-	   done for SMBus clients */
+	   done for SMBus and Super-I/O clients */
 	if (kind < 0) {
-		if (is_isa) {
-
+		if (is_isa && !chip_type) {
 #define REALLY_SLOW_IO
 			/* We need the timeouts for at least some IT87-like chips. But only
 			   if we read 'undefined' registers. */

