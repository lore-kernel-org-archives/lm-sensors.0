From: gardner.ben@gmail.com (Ben Gardner)
Date: Mon, 19 Dec 2005 19:00:39 +0000
Subject: [lm-sensors] [PATCH 7/7] i2c: scx200_acb - documentation update
Message-Id: <808c8e9d0512191100jaa8005fjc8977a1268675e92@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Added mention of the CS5535 and CS5536 and noted that the 'base'
module parameter is only used for the scx200 and sc1100.

Signed-off-by: Ben Gardner <bgardner at wabtec.com>
-------------- next part --------------
 Documentation/i2c/busses/scx200_acb |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

--- linux-2.6.15-rc5-mm1.orig/Documentation/i2c/busses/scx200_acb
+++ linux-2.6.15-rc5-mm1/Documentation/i2c/busses/scx200_acb
@@ -6,9 +6,10 @@ Module Parameters
 -----------------
 
 * base: int
-  Base addresses for the ACCESS.bus controllers
+  Base addresses for the ACCESS.bus controllers on SCx200 and SC1100 devices
 
 Description
 -----------
 
-Enable the use of the ACCESS.bus controllers of a SCx200 processor.
+Enable the use of the ACCESS.bus controllers of SCx200, SC1100, CS5535, and
+CS5536 Geode CPU companion devices.
