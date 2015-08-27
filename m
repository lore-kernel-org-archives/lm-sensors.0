From: Huang Rui <ray.huang@amd.com>
Date: Thu, 27 Aug 2015 08:07:33 +0000
Subject: [lm-sensors] [PATCH 02/15] hwmon, fam15h_power: rename fam15h_power_is_internal_node0 function
Message-Id: <1440662866-28716-3-git-send-email-ray.huang@amd.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1440662866-28716-1-git-send-email-ray.huang@amd.com>
In-Reply-To: <1440662866-28716-1-git-send-email-ray.huang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Borislav Petkov <bp@suse.de>, Jean Delvare <jdelvare@suse.de>, Guenter Roeck <linux@roeck-us.net>, Andy Lutomirski <luto@amacapital.net>, Andreas Herrmann <herrmann.der.user@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, John Stultz <john.stultz@linaro.org>, =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Weisbecker?= <fweisbec@gmail.com>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, x86@kernel.org, Andreas Herrmann <herrmann.der.user@googlemail.com>, Aravind Gopalakrishnan <Aravind.Gopalakrishnan@amd.com>, Borislav Petkov <bp@alien8.de>, Fengguang Wu <fengguang.wu@intel.com>, Aaron Lu <aaron.lu@intel.com>, Tony Li <tony.li@amd.com>, Huang Rui <ray.huang@amd.com>

We rename fam15h_power_is_internal_node0() function to
should_load_on_this_node(), because it may not be node0 from KV and
on, and they are single-node processors.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/hwmon/fam15h_power.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/fam15h_power.c b/drivers/hwmon/fam15h_power.c
index 0753810..820adf1 100644
--- a/drivers/hwmon/fam15h_power.c
+++ b/drivers/hwmon/fam15h_power.c
@@ -117,7 +117,7 @@ static const struct attribute_group fam15h_power_group = {
 };
 __ATTRIBUTE_GROUPS(fam15h_power);
 
-static bool fam15h_power_is_internal_node0(struct pci_dev *f4)
+static bool should_load_on_this_node(struct pci_dev *f4)
 {
 	u32 val;
 
@@ -214,7 +214,7 @@ static int fam15h_power_probe(struct pci_dev *pdev,
 	 */
 	tweak_runavg_range(pdev);
 
-	if (!fam15h_power_is_internal_node0(pdev))
+	if (!should_load_on_this_node(pdev))
 		return -ENODEV;
 
 	data = devm_kzalloc(dev, sizeof(struct fam15h_power_data), GFP_KERNEL);
-- 
1.9.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
