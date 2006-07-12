From: greg@kroah.com (Greg KH)
Date: Wed, 12 Jul 2006 23:27:18 +0000
Subject: [lm-sensors] [PATCH 6/13] [PATCH] i2c-ite: Plan for removal
Message-Id: <11527468621546-git-send-email-greg@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Jean Delvare <khali at linux-fr.org>

Plan the i2c-ite and i2c-algo-ite drivers for removal.
These drivers never compiled since they were added to the kernel
tree 5 years ago. Also see:
http://marc.theaimsgroup.com/?l=linux-mips&m5040510817448

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>
---
 Documentation/feature-removal-schedule.txt |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/Documentation/feature-removal-schedule.txt b/Documentation/feature-removal-schedule.txt
index ee28798..ffa4d6c 100644
--- a/Documentation/feature-removal-schedule.txt
+++ b/Documentation/feature-removal-schedule.txt
@@ -255,3 +255,14 @@ Why:	The interrupt related SA_* flags ar
 Who:	Thomas Gleixner <tglx at linutronix.de>
 
 ---------------------------
+
+What:	i2c-ite and i2c-algo-ite drivers
+When:	September 2006
+Why:	These drivers never compiled since they were added to the kernel
+	tree 5 years ago. This feature removal can be reevaluated if
+	someone shows interest in the drivers, fixes them and takes over
+	maintenance.
+	http://marc.theaimsgroup.com/?l=linux-mips&m5040510817448
+Who:	Jean Delvare <khali at linux-fr.org>
+
+---------------------------
-- 
1.4.1


