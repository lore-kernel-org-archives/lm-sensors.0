From: Jiri Slaby <jirislaby@gmail.com>
Date: Fri, 30 Nov 2007 14:14:13 +0000
Subject: [lm-sensors] [PATCH 1/1] HWMON: coretemp, suspend fix
Message-Id: <661416096128474967.slaby@pripojeni.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Ok, I don't see it merged in the latest -mm (mmotm). Could you, Mark, Rafael,
sign off this version of the patch (Mark's + Rafael's fix)?

--

From: Mark M. Hoffman <mhoffman@lightlink.com>

coretemp, suspend fix

It's not permitted to unregister device/cpu if frozen and going to sleep.
It causes deadlock on systems, where coretemp hwmon is loaded. Do it only
in non-freezed states instead.

Cc: Rafael J. Wysocki <rjw@sisk.pl> (frozen fix)
Cc: Mark M. Hoffman <mhoffman@lightlink.com>
Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit 4f0e19b172ed18fb29e8006c4470fd37aa245a7a
tree bec1cc4f7a499efe94c5f9d2d208db325914f28e
parent 877dcc2ef6c7c17a64155cf201886c49622250e9
author Jiri Slaby <jirislaby@gmail.com> Tue, 27 Nov 2007 20:19:47 +0100
committer Jiri Slaby <ku@bellona.localdomain> Thu, 29 Nov 2007 23:41:11 +0100

 drivers/hwmon/coretemp.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index 5c82ec7..ce7457d 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -338,11 +338,13 @@ static int coretemp_cpu_callback(struct notifier_block *nfb,
 	switch (action) {
 	case CPU_ONLINE:
 	case CPU_ONLINE_FROZEN:
+	case CPU_DOWN_FAILED:
 		coretemp_device_add(cpu);
+	case CPU_DOWN_FAILED_FROZEN:
 		break;
-	case CPU_DEAD:
-	case CPU_DEAD_FROZEN:
+	case CPU_DOWN_PREPARE:
 		coretemp_device_remove(cpu);
+	case CPU_DOWN_PREPARE_FROZEN:
 		break;
 	}
 	return NOTIFY_OK;

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
