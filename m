From: greg@kroah.com (Greg KH)
Date: Thu, 22 Jun 2006 18:27:42 +0000
Subject: [lm-sensors] [PATCH 16/44] [PATCH] HWMON: lm83: Documentation update
Message-Id: <1151000946127-git-send-email-greg@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Jean Delvare <khali at linux-fr.org>

One more motherboard confirmed to have an LM83 temperature sensor chip.
Thanks to Steven Hardy for reporting.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>
---
 Documentation/hwmon/lm83 |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/Documentation/hwmon/lm83 b/Documentation/hwmon/lm83
index 74aa7ee..f7aad14 100644
--- a/Documentation/hwmon/lm83
+++ b/Documentation/hwmon/lm83
@@ -35,6 +35,7 @@ contact us. Note that the LM90 can easil
 
 Confirmed motherboards:
     SBS         P014
+    SBS         PSL09
 
 Unconfirmed motherboards:
     Gigabyte    GA-8IK1100
-- 
1.4.0


