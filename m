From: Alistair John Strachan <alistair@devzero.co.uk>
Date: Fri, 01 Aug 2008 18:16:58 +0000
Subject: [lm-sensors] [PATCH 1/2] abituguru3: update MAINTAINERS
Message-Id: <1217614619-29688-2-git-send-email-alistair@devzero.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hans passed maintainership of the abituguru3 hwmon driver onto me.
Add a new entry to the MAINTAINERS file for the abituguru3 driver
and assign it to me. Also update the existing UGURU entry to
indicate that Hans is only responsible for the abituguru driver.

Signed-off-by: Alistair John Strachan <alistair@devzero.co.uk>
Acked-by: Hans de Goede <j.w.r.degoede@hhs.nl>
Cc: Andrew Morton <akpm@linux-foundation.org>

---

 MAINTAINERS |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index deedc0d..9058be3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -175,12 +175,18 @@ M:	bcrl@kvack.org
 L:	linux-aio@kvack.org
 S:	Supported
 
-ABIT UGURU HARDWARE MONITOR DRIVER
+ABIT UGURU 1,2 HARDWARE MONITOR DRIVER
 P:	Hans de Goede
 M:	j.w.r.degoede@hhs.nl
 L:	lm-sensors@lm-sensors.org
 S:	Maintained
 
+ABIT UGURU 3 HARDWARE MONITOR DRIVER
+P:	Alistair John Strachan
+M:	alistair@devzero.co.uk
+L:	lm-sensors@lm-sensors.org
+S:	Maintained
+
 ACENIC DRIVER
 P:	Jes Sorensen
 M:	jes@trained-monkey.org

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
