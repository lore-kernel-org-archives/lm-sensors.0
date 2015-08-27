From: Huang Rui <ray.huang@amd.com>
Date: Thu, 27 Aug 2015 08:07:41 +0000
Subject: [lm-sensors] [PATCH 10/15] hwmon, fam15h_power: add compute unit accumulated power
Message-Id: <1440662866-28716-11-git-send-email-ray.huang@amd.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1440662866-28716-1-git-send-email-ray.huang@amd.com>
In-Reply-To: <1440662866-28716-1-git-send-email-ray.huang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Borislav Petkov <bp@suse.de>, Jean Delvare <jdelvare@suse.de>, Guenter Roeck <linux@roeck-us.net>, Andy Lutomirski <luto@amacapital.net>, Andreas Herrmann <herrmann.der.user@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, John Stultz <john.stultz@linaro.org>, =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Weisbecker?= <fweisbec@gmail.com>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, x86@kernel.org, Andreas Herrmann <herrmann.der.user@googlemail.com>, Aravind Gopalakrishnan <Aravind.Gopalakrishnan@amd.com>, Borislav Petkov <bp@alien8.de>, Fengguang Wu <fengguang.wu@intel.com>, Aaron Lu <aaron.lu@intel.com>, Tony Li <tony.li@amd.com>, Huang Rui <ray.huang@amd.com>

This patch adds a member in fam15h_power_data which specifies the
compute unit accumulated power.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/hwmon/fam15h_power.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/fam15h_power.c b/drivers/hwmon/fam15h_power.c
index fdfa18e..f5ff48f 100644
--- a/drivers/hwmon/fam15h_power.c
+++ b/drivers/hwmon/fam15h_power.c
@@ -43,7 +43,9 @@ MODULE_LICENSE("GPL");
 #define REG_TDP_LIMIT3			0xe8
 
 #define FAM15H_MIN_POWER_GROUPS		2
+#define MAX_CUS				8
 
+#define MSR_F15H_CU_PWR_ACCUMULATOR	0xc001007a
 #define MSR_F15H_CU_MAX_PWR_ACCUMULATOR	0xc001007b
 
 struct fam15h_power_data {
@@ -54,6 +56,8 @@ struct fam15h_power_data {
 	unsigned int cpu_pwr_sample_ratio;
 	/* maximum accumulated power of a compute unit */
 	u64 max_cu_acc_power;
+	/* accumulated power of the compute units */
+	u64 cu_acc_power[MAX_CUS];
 };
 
 static ssize_t show_power(struct device *dev,
@@ -207,6 +211,7 @@ static int fam15h_power_resume(struct pci_dev *pdev)
 static int fam15h_power_init_data(struct pci_dev *f4,
 				  struct fam15h_power_data *data)
 {
+	int cu_num, cores_per_cu, cpu, cu;
 	u32 val, eax, ebx, ecx, edx;
 	u64 tmp;
 
@@ -249,6 +254,21 @@ static int fam15h_power_init_data(struct pci_dev *f4,
 
 	data->max_cu_acc_power = tmp;
 
+	cores_per_cu = amd_get_cores_per_cu();
+	cu_num = boot_cpu_data.x86_max_cores / cores_per_cu;
+
+	WARN_ON_ONCE(cu_num > MAX_CUS);
+
+	for (cpu = 0; cpu < cu_num * cores_per_cu; cpu += cores_per_cu) {
+		cu = cpu / cores_per_cu;
+		if (rdmsrl_safe_on_cpu(cpu, MSR_F15H_CU_PWR_ACCUMULATOR,
+				       &data->cu_acc_power[cu])) {
+			pr_err("Failed to read compute unit power accumulator MSR on core%d\n",
+			       cpu);
+			return -ENODEV;
+		}
+	}
+
 	return 0;
 }
 
@@ -258,6 +278,7 @@ static int fam15h_power_probe(struct pci_dev *pdev,
 	struct fam15h_power_data *data;
 	struct device *dev = &pdev->dev;
 	struct device *hwmon_dev;
+	int ret;
 
 	/*
 	 * though we ignore every other northbridge, we still have to
@@ -273,11 +294,13 @@ static int fam15h_power_probe(struct pci_dev *pdev,
 	if (!data)
 		return -ENOMEM;
 
-	if (fam15h_power_init_attrs(pdev))
-		return -ENOMEM;
+	ret = fam15h_power_init_attrs(pdev);
+	if (ret)
+		return ret;
 
-	if (fam15h_power_init_data(pdev, data))
-		return -ENODEV;
+	ret = fam15h_power_init_data(pdev, data);
+	if (ret)
+		return ret;
 
 	data->pdev = pdev;
 
-- 
1.9.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
