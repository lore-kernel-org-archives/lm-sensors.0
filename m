From: Huang Rui <ray.huang@amd.com>
Date: Thu, 27 Aug 2015 08:07:44 +0000
Subject: [lm-sensors] [PATCH 13/15] hwmon, fam15h_power: add documentation for previous TDP reporting
Message-Id: <1440662866-28716-14-git-send-email-ray.huang@amd.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1440662866-28716-1-git-send-email-ray.huang@amd.com>
In-Reply-To: <1440662866-28716-1-git-send-email-ray.huang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Borislav Petkov <bp@suse.de>, Jean Delvare <jdelvare@suse.de>, Guenter Roeck <linux@roeck-us.net>, Andy Lutomirski <luto@amacapital.net>, Andreas Herrmann <herrmann.der.user@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, John Stultz <john.stultz@linaro.org>, =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Weisbecker?= <fweisbec@gmail.com>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, x86@kernel.org, Andreas Herrmann <herrmann.der.user@googlemail.com>, Aravind Gopalakrishnan <Aravind.Gopalakrishnan@amd.com>, Borislav Petkov <bp@alien8.de>, Fengguang Wu <fengguang.wu@intel.com>, Aaron Lu <aaron.lu@intel.com>, Tony Li <tony.li@amd.com>, Huang Rui <ray.huang@amd.com>

This patch adds description to explain the TDP reporting mechanism of
fam15h_power driver.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 Documentation/hwmon/fam15h_power | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/hwmon/fam15h_power b/Documentation/hwmon/fam15h_power
index e2b1b69..42bf04e 100644
--- a/Documentation/hwmon/fam15h_power
+++ b/Documentation/hwmon/fam15h_power
@@ -10,14 +10,22 @@ Supported chips:
   Datasheets:
   BIOS and Kernel Developer's Guide (BKDG) For AMD Family 15h Processors
   BIOS and Kernel Developer's Guide (BKDG) For AMD Family 16h Processors
+  AMD64 Architecture Programmer's Manual Volume 2: System Programming
 
 Author: Andreas Herrmann <herrmann.der.user@googlemail.com>
 
 Description
 -----------
 
+1) Processor TDP (Thermal design power)
+
+Given a fixed frequency and voltage, the power consumption of a
+processor varies based on the workload being executed. Derated power
+is the power consumed when running a specific application. Thermal
+design power (TDP) is an example of derated power.
+
 This driver permits reading of registers providing power information
-of AMD Family 15h and 16h processors.
+of AMD Family 15h and 16h processors via TDP algorithm.
 
 For AMD Family 15h and 16h processors the following power values can
 be calculated using different processor northbridge function
-- 
1.9.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
