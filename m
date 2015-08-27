From: Huang Rui <ray.huang@amd.com>
Date: Thu, 27 Aug 2015 08:07:35 +0000
Subject: [lm-sensors] [PATCH 04/15] hwmon, fam15h_power: update running_avg_capture bit field to 28
Message-Id: <1440662866-28716-5-git-send-email-ray.huang@amd.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1440662866-28716-1-git-send-email-ray.huang@amd.com>
In-Reply-To: <1440662866-28716-1-git-send-email-ray.huang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Borislav Petkov <bp@suse.de>, Jean Delvare <jdelvare@suse.de>, Guenter Roeck <linux@roeck-us.net>, Andy Lutomirski <luto@amacapital.net>, Andreas Herrmann <herrmann.der.user@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, John Stultz <john.stultz@linaro.org>, =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Weisbecker?= <fweisbec@gmail.com>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, x86@kernel.org, Andreas Herrmann <herrmann.der.user@googlemail.com>, Aravind Gopalakrishnan <Aravind.Gopalakrishnan@amd.com>, Borislav Petkov <bp@alien8.de>, Fengguang Wu <fengguang.wu@intel.com>, Aaron Lu <aaron.lu@intel.com>, Tony Li <tony.li@amd.com>, Huang Rui <ray.huang@amd.com>

On Carrizo and later platforms, running_avg_capture bit field is
extended to 4:31 (28 bits) from 4:25.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/hwmon/fam15h_power.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/fam15h_power.c b/drivers/hwmon/fam15h_power.c
index 65ffb06..3e9b3b9 100644
--- a/drivers/hwmon/fam15h_power.c
+++ b/drivers/hwmon/fam15h_power.c
@@ -61,8 +61,19 @@ static ssize_t show_power(struct device *dev,
 
 	pci_bus_read_config_dword(f4->bus, PCI_DEVFN(PCI_SLOT(f4->devfn), 5),
 				  REG_TDP_RUNNING_AVERAGE, &val);
-	running_avg_capture = (val >> 4) & 0x3fffff;
-	running_avg_capture = sign_extend32(running_avg_capture, 21);
+
+	/*
+	 * On Carrizo and later platforms, TdpRunAvgAccCap bit field
+	 * is extended to 4:31 from 4:25.
+	 */
+	if (boot_cpu_data.x86 = 0x15 && boot_cpu_data.x86_model >= 0x60) {
+		running_avg_capture = val >> 4;
+		running_avg_capture = sign_extend32(running_avg_capture, 27);
+	} else {
+		running_avg_capture = (val >> 4) & 0x3fffff;
+		running_avg_capture = sign_extend32(running_avg_capture, 21);
+	}
+
 	running_avg_range = (val & 0xf) + 1;
 
 	pci_bus_read_config_dword(f4->bus, PCI_DEVFN(PCI_SLOT(f4->devfn), 5),
-- 
1.9.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
