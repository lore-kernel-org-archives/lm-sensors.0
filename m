From: gardner.ben@gmail.com (Ben Gardner)
Date: Tue, 20 Dec 2005 23:03:42 +0000
Subject: [lm-sensors] [PATCH 7/7] i2c: scx200_acb - documentation update
Message-Id: <808c8e9d0512201503m350af76er247bd47f08df3b3b@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <808c8e9d0512191100jaa8005fjc8977a1268675e92@mail.gmail.com>
In-Reply-To: <808c8e9d0512191100jaa8005fjc8977a1268675e92@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

scx200_acb: Minimal documentation update

Signed-off-by: Ben Gardner <bgardner at wabtec.com>
---
This is the second version of the series.
-------------- next part --------------
 Documentation/i2c/busses/scx200_acb |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

--- linux-2.6.15-rc5-mm3.orig/Documentation/i2c/busses/scx200_acb
+++ linux-2.6.15-rc5-mm3/Documentation/i2c/busses/scx200_acb
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
