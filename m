From: Huang Rui <ray.huang@amd.com>
Date: Fri, 11 Mar 2016 02:17:47 +0000
Subject: [lm-sensors] [PATCH v4 3/6] hwmon: (fam15h_power) Add ptsc counter value for accumulated power
Message-Id: <1457662670-3354-4-git-send-email-ray.huang@amd.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1457662670-3354-1-git-send-email-ray.huang@amd.com>
In-Reply-To: <1457662670-3354-1-git-send-email-ray.huang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.de>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, spg_linux_kernel@amd.com, Aravind Gopalakrishnan <Aravind.Gopalakrishnan@amd.com>, Borislav Petkov <bp@alien8.de>, Huang Rui <ray.huang@amd.com>

PTSC is the performance timestamp counter value in a cpu core and the
cores in one compute unit have the fixed frequency. So it picks up the
performance timestamp counter value of the first core per compute unit
to measure the interval for average power per compute unit.

Signed-off-by: Huang Rui <ray.huang@amd.com>
Cc: Borislav Petkov <bp@alien8.de>
---
 drivers/hwmon/fam15h_power.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hwmon/fam15h_power.c b/drivers/hwmon/fam15h_power.c
index c5e2297..72aef47 100644
--- a/drivers/hwmon/fam15h_power.c
+++ b/drivers/hwmon/fam15h_power.c
@@ -50,6 +50,7 @@ MODULE_LICENSE("GPL");
 
 #define MSR_F15H_CU_PWR_ACCUMULATOR	0xc001007a
 #define MSR_F15H_CU_MAX_PWR_ACCUMULATOR	0xc001007b
+#define MSR_F15H_PTSC			0xc0010280
 
 #define PCI_DEVICE_ID_AMD_15H_M70H_NB_F4 0x15b4
 
@@ -65,6 +66,8 @@ struct fam15h_power_data {
 	u64 max_cu_acc_power;
 	/* accumulated power of the compute units */
 	u64 cu_acc_power[MAX_CUS];
+	/* performance timestamp counter */
+	u64 cpu_sw_pwr_ptsc[MAX_CUS];
 };
 
 static ssize_t show_power(struct device *dev,
@@ -141,6 +144,7 @@ static void do_read_registers_on_cu(void *_data)
 	cu = cpu / smp_num_siblings;
 
 	rdmsrl_safe(MSR_F15H_CU_PWR_ACCUMULATOR, &data->cu_acc_power[cu]);
+	rdmsrl_safe(MSR_F15H_PTSC, &data->cpu_sw_pwr_ptsc[cu]);
 }
 
 /*
-- 
1.9.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
