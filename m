From: tip-bot for Fenghua Yu <fenghua.yu@intel.com>
Date: Fri, 21 Jan 2011 15:37:10 +0000
Subject: [lm-sensors] [tip:x86/urgent] x86, mcheck,
Message-Id: <tip-f21bbec9ffcaf73e99938209e52b757d93f9133b@git.kernel.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110121041239.GB26954@linux-os.sc.intel.com>
In-Reply-To: <20110121041239.GB26954@linux-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-tip-commits@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, durgadoss.r@intel.com, hpa@zytor.com, mingo@redhat.com, lm-sensors@lm-sensors.org, fenghua.yu@intel.com, khali@linux-fr.org, tglx@linutronix.de, guenter.roeck@ericsson.com, mingo@elte.hu

Commit-ID:  f21bbec9ffcaf73e99938209e52b757d93f9133b
Gitweb:     http://git.kernel.org/tip/f21bbec9ffcaf73e99938209e52b757d93f9133b
Author:     Fenghua Yu <fenghua.yu@intel.com>
AuthorDate: Thu, 20 Jan 2011 20:12:40 -0800
Committer:  Ingo Molnar <mingo@elte.hu>
CommitDate: Fri, 21 Jan 2011 14:11:12 +0100

x86, mcheck, therm_throt.c: Export symbol platform_thermal_notify to allow coretemp to handler intr

In therm_throt.c, commit
9e76a97efd31a08cb19d0ba12013b8fb4ad3e474 patch doesn't export
the symbol platform_thermal_notify.

Other drivers (e.g. drivers/hwmon/coretemp.c) can not find the
symbol platform_thermal_notify when defining threshould
interrupt handler.

Please apply this patch to allow threshold interrupt handler in
coretemp.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Cc: R Durgadoss <durgadoss.r@intel.com>
Cc: khali@linux-fr.org <khali@linux-fr.org>
Cc: lm-sensors@lm-sensors.org <lm-sensors@lm-sensors.org>
Cc: Guenter Roeck <guenter.roeck@ericsson.com>
LKML-Reference: <20110121041239.GB26954@linux-os.sc.intel.com>
Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 arch/x86/kernel/cpu/mcheck/therm_throt.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/x86/kernel/cpu/mcheck/therm_throt.c b/arch/x86/kernel/cpu/mcheck/therm_throt.c
index e12246f..6f8c5e9 100644
--- a/arch/x86/kernel/cpu/mcheck/therm_throt.c
+++ b/arch/x86/kernel/cpu/mcheck/therm_throt.c
@@ -59,6 +59,7 @@ struct thermal_state {
 
 /* Callback to handle core threshold interrupts */
 int (*platform_thermal_notify)(__u64 msr_val);
+EXPORT_SYMBOL(platform_thermal_notify);
 
 static DEFINE_PER_CPU(struct thermal_state, thermal_state);
 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
