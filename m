From: gregkh@suse.de (Greg KH)
Date: Mon, 05 Sep 2005 23:47:17 +0000
Subject: [lm-sensors] [PATCH] i2c: chips/m41t00.c fixup
Message-Id: <11259567712456@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] i2c: chips/m41t00.c fixup

The 'new_time' variable should be static.

Signed-off-by: Mark A. Greer <mgreer@mvista.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit a44e40b4d8c2c6faa2158caf7114e1065fed3b34
tree 2ad3bac3e7ce7a64d91c9bba636a1f59372a83d7
parent b280dab6d62c8d0434cbc0aaeebf56d1fa4fcc19
author Mark A. Greer <mgreer@mvista.com> Thu, 01 Sep 2005 18:09:54 -0700
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 05 Sep 2005 09:26:53 -0700

 drivers/i2c/chips/m41t00.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/chips/m41t00.c b/drivers/i2c/chips/m41t00.c
--- a/drivers/i2c/chips/m41t00.c
+++ b/drivers/i2c/chips/m41t00.c
@@ -144,7 +144,7 @@ m41t00_set_tlet(ulong arg)
 	return;
 }
 
-ulong	new_time;
+static ulong	new_time;
 
 DECLARE_TASKLET_DISABLED(m41t00_tasklet, m41t00_set_tlet, (ulong)&new_time);
 

