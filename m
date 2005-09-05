From: gregkh@suse.de (Greg KH)
Date: Mon, 05 Sep 2005 23:49:08 +0000
Subject: [lm-sensors] [PATCH] i2c: chips/ds1374.c fixup
Message-Id: <11259567712262@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] i2c: chips/ds1374.c fixup

The 'new_time' variable should be static.

Signed-off-by: Mark A. Greer <mgreer@mvista.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 8e14d6c173f8fff05a94e62669c87c26141766af
tree 1df28e8ce3deab3a3a9ebaa4d6a5846f0ab5c733
parent a44e40b4d8c2c6faa2158caf7114e1065fed3b34
author Mark A. Greer <mgreer@mvista.com> Thu, 01 Sep 2005 18:12:04 -0700
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 05 Sep 2005 09:26:53 -0700

 drivers/i2c/chips/ds1374.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/chips/ds1374.c b/drivers/i2c/chips/ds1374.c
--- a/drivers/i2c/chips/ds1374.c
+++ b/drivers/i2c/chips/ds1374.c
@@ -165,7 +165,7 @@ static void ds1374_set_tlet(ulong arg)
 			 "can't confirm time set from rtc chip\n");
 }
 
-ulong new_time;
+static ulong new_time;
 
 DECLARE_TASKLET_DISABLED(ds1374_tasklet, ds1374_set_tlet, (ulong) & new_time);
 

