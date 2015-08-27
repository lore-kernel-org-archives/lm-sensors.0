From: Huang Rui <ray.huang@amd.com>
Date: Thu, 27 Aug 2015 08:07:38 +0000
Subject: [lm-sensors] [PATCH 07/15] hwmon, fam15h_power: add ratio of Tsample to the PTSC period
Message-Id: <1440662866-28716-8-git-send-email-ray.huang@amd.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1440662866-28716-1-git-send-email-ray.huang@amd.com>
In-Reply-To: <1440662866-28716-1-git-send-email-ray.huang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Borislav Petkov <bp@suse.de>, Jean Delvare <jdelvare@suse.de>, Guenter Roeck <linux@roeck-us.net>, Andy Lutomirski <luto@amacapital.net>, Andreas Herrmann <herrmann.der.user@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, John Stultz <john.stultz@linaro.org>, =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Weisbecker?= <fweisbec@gmail.com>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, x86@kernel.org, Andreas Herrmann <herrmann.der.user@googlemail.com>, Aravind Gopalakrishnan <Aravind.Gopalakrishnan@amd.com>, Borislav Petkov <bp@alien8.de>, Fengguang Wu <fengguang.wu@intel.com>, Aaron Lu <aaron.lu@intel.com>, Tony Li <tony.li@amd.com>, Huang Rui <ray.huang@amd.com>

This patch adds a member (cpu_pwr_sample_ratio) of fam15h_power_data,
that represents the ratio of compute unit power accumulator sample
period to the PTSC counter period.

Tsample: compute unit power accumulator sample period
Tref: the performance timestamp counter period
PTSC: performance timestamp counter

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/hwmon/fam15h_power.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/fam15h_power.c b/drivers/hwmon/fam15h_power.c
index 55b25ef..d6efcf6 100644
--- a/drivers/hwmon/fam15h_power.c
+++ b/drivers/hwmon/fam15h_power.c
@@ -48,6 +48,7 @@ struct fam15h_power_data {
 	unsigned int tdp_to_watts;
 	unsigned int base_tdp;
 	unsigned int processor_pwr_watts;
+	unsigned int cpu_pwr_sample_ratio;
 };
 
 static ssize_t show_power(struct device *dev,
@@ -201,7 +202,7 @@ static int fam15h_power_resume(struct pci_dev *pdev)
 static void fam15h_power_init_data(struct pci_dev *f4,
 					     struct fam15h_power_data *data)
 {
-	u32 val;
+	u32 val, eax, ebx, ecx, edx;
 	u64 tmp;
 
 	pci_read_config_dword(f4, REG_PROCESSOR_TDP, &val);
@@ -222,6 +223,19 @@ static void fam15h_power_init_data(struct pci_dev *f4,
 
 	/* convert to microWatt */
 	data->processor_pwr_watts = (tmp * 15625) >> 10;
+
+	cpuid(0x80000007, &eax, &ebx, &ecx, &edx);
+
+	/* CPUID Fn8000_0007:EDX[12] indicates to support accumulated power */
+	if (!(edx & BIT(12)))
+		return;
+
+	/*
+	 * detemine the ratio of the compute unit power accumulator
+	 * sample period to the PTSC counter period by executing CPUID
+	 * Fn8000_0007:ECX
+	 */
+	data->cpu_pwr_sample_ratio = ecx;
 }
 
 static int fam15h_power_probe(struct pci_dev *pdev,
-- 
1.9.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
