From: greg@kroah.com (Greg KH)
Date: Wed, 12 Jul 2006 23:27:23 +0000
Subject: [lm-sensors] [PATCH 11/13] [PATCH] hwmon: New maintainer for w83791d
Message-Id: <11527468773894-git-send-email-greg@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Charles Spirakis <bezaur at gmail.com>

Add Charles Spirakis as the maintainer for the w83791d sensor chip
driver.

Signed-off-by: Charles Spirakis <bezaur at gmail.com>
Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>
---
 MAINTAINERS |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6699394..d4bc293 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3183,6 +3183,12 @@ M:	johnpol at 2ka.mipt.ru
 L:	lm-sensors at lm-sensors.org
 S:	Maintained
 
+W83791D HARDWARE MONITORING DRIVER
+P:	Charles Spirakis
+M:	bezaur at gmail.com
+L:	lm-sensors at lm-sensors.org
+S:	Maintained
+
 W83L51xD SD/MMC CARD INTERFACE DRIVER
 P:	Pierre Ossman
 M:	drzeus-wbsd at drzeus.cx
-- 
1.4.1


