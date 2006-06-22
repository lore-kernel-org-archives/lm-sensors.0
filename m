From: greg@kroah.com (Greg KH)
Date: Thu, 22 Jun 2006 18:28:00 +0000
Subject: [lm-sensors] [PATCH 34/44] [PATCH] scx200_acb: Documentation update
Message-Id: <11510010301085-git-send-email-greg@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Jean Delvare <khali at linux-fr.org>

Documentation update for the scx200_acb driver. Hopefully this will
help future users.

References:

[lm-sensors] Support of i2c-nscacb (April, May 2005)
  http://lists.lm-sensors.org/pipermail/lm-sensors/2005-April/011756.html
  http://lists.lm-sensors.org/pipermail/lm-sensors/2005-May/012043.html

[lm-sensors] making a geode i2c slave driver (April 2006)
  http://lists.lm-sensors.org/pipermail/lm-sensors/2006-April/015998.html

Kernel bug #6445
  http://bugzilla.kernel.org/show_bug.cgi?idd45

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>
---
 Documentation/i2c/busses/scx200_acb |   19 ++++++++++++++++++-
 1 files changed, 18 insertions(+), 1 deletions(-)

diff --git a/Documentation/i2c/busses/scx200_acb b/Documentation/i2c/busses/scx200_acb
index f50e699..7c07883 100644
--- a/Documentation/i2c/busses/scx200_acb
+++ b/Documentation/i2c/busses/scx200_acb
@@ -2,14 +2,31 @@ Kernel driver scx200_acb
 
 Author: Christer Weinigel <wingel at nano-system.com>
 
+The driver supersedes the older, never merged driver named i2c-nscacb.
+
 Module Parameters
 -----------------
 
-* base: int
+* base: up to 4 ints
   Base addresses for the ACCESS.bus controllers on SCx200 and SC1100 devices
 
+  By default the driver uses two base addresses 0x820 and 0x840.
+  If you want only one base address, specify the second as 0 so as to
+  override this default.
+
 Description
 -----------
 
 Enable the use of the ACCESS.bus controller on the Geode SCx200 and
 SC1100 processors and the CS5535 and CS5536 Geode companion devices.
+
+Device-specific notes
+---------------------
+
+The SC1100 WRAP boards are known to use base addresses 0x810 and 0x820.
+If the scx200_acb driver is built into the kernel, add the following
+parameter to your boot command line:
+  scx200_acb.base=0x810,0x820
+If the scx200_acb driver is built as a module, add the following line to
+the file /etc/modprobe.conf instead:
+  options scx200_acb base=0x810,0x820
-- 
1.4.0


