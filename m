From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 05 Feb 2006 22:17:34 +0000
Subject: [lm-sensors] [PATCH 03/11] w83627hf: Document the reset module
Message-Id: <20060205231734.3ec8f2e6.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Content-Disposition: inline; filename=hwmon-w83627hf-document-reset-param.patch

Document the reset module parameter which was recently added to the
w83627hf driver.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
---
 Documentation/hwmon/w83627hf |    4 ++++
 1 file changed, 4 insertions(+)

--- linux-2.6.16-rc2.orig/Documentation/hwmon/w83627hf	2006-02-05 21:09:40.000000000 +0100
+++ linux-2.6.16-rc2/Documentation/hwmon/w83627hf	2006-02-05 21:10:21.000000000 +0100
@@ -36,6 +36,10 @@
   (default is 1)
   Use 'init=0' to bypass initializing the chip.
   Try this if your computer crashes when you load the module.
+* reset: int
+  (default is 0)
+  The driver used to reset the chip on load, but does no more. Use
+  'reset=1' to restore the old behavior. Report if you need to do this.
 
 Description
 -----------

-- 
Jean Delvare

