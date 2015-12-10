From: Huang Rui <ray.huang@amd.com>
Date: Thu, 10 Dec 2015 03:56:11 +0000
Subject: [lm-sensors] [PATCH 2/2] MAINTAINERS: change the maintainer of fam15h_power driver
Message-Id: <1449719771-12837-3-git-send-email-ray.huang@amd.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1449719771-12837-1-git-send-email-ray.huang@amd.com>
In-Reply-To: <1449719771-12837-1-git-send-email-ray.huang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.de>, Andreas Herrmann <herrmann.der.user@gmail.com>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, Andreas Herrmann <herrmann.der.user@googlemail.com>, Aravind Gopalakrishnan <Aravind.Gopalakrishnan@amd.com>, Borislav Petkov <bp@alien8.de>, Huang Rui <ray.huang@amd.com>

Andreas Herrmann won't take the maintainer of fam15h_power driver. I
will take it and appreciate him for the great contributions on this
driver.

Signed-off-by: Huang Rui <ray.huang@amd.com>
Acked-by: Andreas Herrmann <herrmann.der.user@googlemail.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Aravind Gopalakrishnan <Aravind.Gopalakrishnan@amd.com>
---
 CREDITS     | 8 ++++++++
 MAINTAINERS | 4 ++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/CREDITS b/CREDITS
index 8207cc6..30bdce8 100644
--- a/CREDITS
+++ b/CREDITS
@@ -1507,6 +1507,14 @@ S: 312/107 Canberra Avenue
 S: Griffith, ACT 2603 
 S: Australia
 
+N: Andreas Herrmann
+E: herrmann.der.user@gmail.com
+E: herrmann.der.user@googlemail.com
+D: Key developer of x86/AMD64
+D: Author of AMD family 15h processor power monintoring driver
+D: Maintainer of AMD Athlon 64 and Opteron processor frequency driver
+S: Germany
+
 N: Sebastian Hetze
 E: she@lunetix.de
 D: German Linux Documentation,
diff --git a/MAINTAINERS b/MAINTAINERS
index cba790b..c99dd93 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -614,9 +614,9 @@ F:	drivers/crypto/ccp/
 F:	include/linux/ccp.h
 
 AMD FAM15H PROCESSOR POWER MONITORING DRIVER
-M:	Andreas Herrmann <herrmann.der.user@googlemail.com>
+M:	Huang Rui <ray.huang@amd.com>
 L:	lm-sensors@lm-sensors.org
-S:	Maintained
+S:	Supported
 F:	Documentation/hwmon/fam15h_power
 F:	drivers/hwmon/fam15h_power.c
 
-- 
1.9.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
