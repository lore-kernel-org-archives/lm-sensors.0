From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:43 +0000
Subject: [PATCH 2.6] I2C: Skip broken detection step in it87
Message-Id: <20050316121818.33094e7e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

One of the detection steps in the it87 chip driver was reported to be
broken for some revisions of the IT8712F chip [1] [2]. This detection
step is a legacy from the lm78 driver and the documentation available
for the IT8705F and IT8712F chips does not mention it at all. For this
reason, I propose to skip this detection step for Super-I/O chips.
Super-I/O chips have already been identified when we reach this step, so
it is redundant (additionally do being broken). This closes bug #4335.

Please apply,
thanks.

[1] http://bugzilla.kernel.org/show_bug.cgi?idC35
[2] http://archives.andrew.net.au/lm-sensors/msg29962.html

Signed-off-by: Jean Delvare <khali@linux-fr.org>

--- linux-2.6.11-mm3/drivers/i2c/chips/it87.c.orig	2005-03-13 20:03:28.000000000 +0100
+++ linux-2.6.11-mm3/drivers/i2c/chips/it87.c	2005-03-15 20:51:14.000000000 +0100
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



-- 
Jean Delvare
