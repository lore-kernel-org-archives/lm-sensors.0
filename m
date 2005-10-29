From: gregkh@suse.de (Greg KH)
Date: Sat, 29 Oct 2005 01:03:02 +0000
Subject: [lm-sensors] [PATCH] i2c-viapro: New maintainer
Message-Id: <11305336582278@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] i2c-viapro: New maintainer

I am taking over the maintenance of the i2c-viapro SMBus driver.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

 MAINTAINERS |    6 ++++++
 1 file changed, 6 insertions(+)

---
commit 32c0a520f506c046f241de2a3a9b02a395ef76d2
tree 4af8da918c808be2d0dc444cf96df0a829c5ccf6
parent 5c50d1885981537ff3b8df6433951de6c9cb72cb
author Jean Delvare <khali@linux-fr.org> Thu, 22 Sep 2005 21:47:58 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 28 Oct 2005 14:02:07 -0700

 MAINTAINERS |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 248b93b..3928dc7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2736,6 +2736,12 @@ P:	Roger Luethi
 M:	rl@hellgate.ch
 S:	Maintained
 
+VIAPRO SMBUS DRIVER
+P:	Jean Delvare
+M:	khali@linux-fr.org
+L:	lm-sensors@lm-sensors.org
+S:	Maintained
+
 UCLINUX (AND M68KNOMMU)
 P:	Greg Ungerer
 M:	gerg@uclinux.org

