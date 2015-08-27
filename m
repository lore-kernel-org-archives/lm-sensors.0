From: Huang Rui <ray.huang@amd.com>
Date: Thu, 27 Aug 2015 08:07:46 +0000
Subject: [lm-sensors] [PATCH 15/15] MAINTAINERS: change the maintainer of fam15h_power driver
Message-Id: <1440662866-28716-16-git-send-email-ray.huang@amd.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1440662866-28716-1-git-send-email-ray.huang@amd.com>
In-Reply-To: <1440662866-28716-1-git-send-email-ray.huang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Borislav Petkov <bp@suse.de>, Jean Delvare <jdelvare@suse.de>, Guenter Roeck <linux@roeck-us.net>, Andy Lutomirski <luto@amacapital.net>, Andreas Herrmann <herrmann.der.user@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, John Stultz <john.stultz@linaro.org>, =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Weisbecker?= <fweisbec@gmail.com>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, x86@kernel.org, Andreas Herrmann <herrmann.der.user@googlemail.com>, Aravind Gopalakrishnan <Aravind.Gopalakrishnan@amd.com>, Borislav Petkov <bp@alien8.de>, Fengguang Wu <fengguang.wu@intel.com>, Aaron Lu <aaron.lu@intel.com>, Tony Li <tony.li@amd.com>, Huang Rui <ray.huang@amd.com>

Andreas Herrmann won't take the maintainer of fam15h_power driver. I
will take it and appreciate him for the great contributions on this
driver.

Signed-off-by: Huang Rui <ray.huang@amd.com>
Cc: Andreas Herrmann <herrmann.der.user@googlemail.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 941d7b7..241d45e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -601,9 +601,9 @@ F:	drivers/crypto/ccp/
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
