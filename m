From: Huang Rui <ray.huang@amd.com>
Date: Thu, 27 Aug 2015 08:07:42 +0000
Subject: [lm-sensors] [PATCH 11/15] hwmon, fam15h_power: add ptsc counter value for accumulated power
Message-Id: <1440662866-28716-12-git-send-email-ray.huang@amd.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1440662866-28716-1-git-send-email-ray.huang@amd.com>
In-Reply-To: <1440662866-28716-1-git-send-email-ray.huang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Borislav Petkov <bp@suse.de>, Jean Delvare <jdelvare@suse.de>, Guenter Roeck <linux@roeck-us.net>, Andy Lutomirski <luto@amacapital.net>, Andreas Herrmann <herrmann.der.user@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, John Stultz <john.stultz@linaro.org>, =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Weisbecker?= <fweisbec@gmail.com>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, x86@kernel.org, Andreas Herrmann <herrmann.der.user@googlemail.com>, Aravind Gopalakrishnan <Aravind.Gopalakrishnan@amd.com>, Borislav Petkov <bp@alien8.de>, Fengguang Wu <fengguang.wu@intel.com>, Aaron Lu <aaron.lu@intel.com>, Tony Li <tony.li@amd.com>, Huang Rui <ray.huang@amd.com>

PTSC is the performance timestamp counter value in a cpu core and the
cores in one compute unit have the fixed frequency. So it picks up the
performance timestamp counter value of the first core per compute unit
to measure the interval for average power per compute unit.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 arch/x86/include/asm/msr-index.h | 1 +
 drivers/hwmon/fam15h_power.c     | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 9ebc3d0..5566360 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -293,6 +293,7 @@
 #define MSR_F15H_PERF_CTR		0xc0010201
 #define MSR_F15H_NB_PERF_CTL		0xc0010240
 #define MSR_F15H_NB_PERF_CTR		0xc0010241
+#define MSR_F15H_PTSC			0xc0010280
 
 /* Fam 10h MSRs */
 #define MSR_FAM10H_MMIO_CONF_BASE	0xc0010058
diff --git a/drivers/hwmon/fam15h_power.c b/drivers/hwmon/fam15h_power.c
index f5ff48f..d529e4b 100644
--- a/drivers/hwmon/fam15h_power.c
+++ b/drivers/hwmon/fam15h_power.c
@@ -58,6 +58,8 @@ struct fam15h_power_data {
 	u64 max_cu_acc_power;
 	/* accumulated power of the compute units */
 	u64 cu_acc_power[MAX_CUS];
+	/* performance timestamp counter */
+	u64 cpu_sw_pwr_ptsc[MAX_CUS];
 };
 
 static ssize_t show_power(struct device *dev,
@@ -267,6 +269,13 @@ static int fam15h_power_init_data(struct pci_dev *f4,
 			       cpu);
 			return -ENODEV;
 		}
+
+		if (rdmsrl_safe_on_cpu(cpu, MSR_F15H_PTSC,
+				       &data->cpu_sw_pwr_ptsc[cu])) {
+			pr_err("Failed to read performance timestamp counter MSR on core%d\n",
+			       cpu);
+			return -ENODEV;
+		}
 	}
 
 	return 0;
-- 
1.9.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
