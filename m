From: Yong Zhang <yong.zhang0@gmail.com>
Date: Wed, 21 Sep 2011 09:28:57 +0000
Subject: [lm-sensors] [PATCH 56/57] hwmon: irq: Remove IRQF_DISABLED
Message-Id: <1316597339-29861-57-git-send-email-yong.zhang0@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1316597339-29861-1-git-send-email-yong.zhang0@gmail.com>
In-Reply-To: <1316597339-29861-1-git-send-email-yong.zhang0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, yong.zhang0@gmail.com, Jean Delvare <khali@linux-fr.org>, Guenter Roeck <guenter.roeck@ericsson.com>, lm-sensors@lm-sensors.org

Since commit [c58543c8: genirq: Run irq handlers with interrupts disabled],
We run all interrupt handlers with interrupts disabled
and we even check and yell when an interrupt handler
returns with interrupts enabled (see commit [b738a50a:
genirq: Warn when handler enables interrupts]).

So now this flag is a NOOP and can be removed.

Signed-off-by: Yong Zhang <yong.zhang0@gmail.com>
---
 drivers/hwmon/exynos4_tmu.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/exynos4_tmu.c b/drivers/hwmon/exynos4_tmu.c
index 0170c90..faa0884 100644
--- a/drivers/hwmon/exynos4_tmu.c
+++ b/drivers/hwmon/exynos4_tmu.c
@@ -394,7 +394,7 @@ static int __devinit exynos4_tmu_probe(struct platform_device *pdev)
 	}
 
 	ret = request_irq(data->irq, exynos4_tmu_irq,
-		IRQF_DISABLED | IRQF_TRIGGER_RISING,
+		IRQF_TRIGGER_RISING,
 		"exynos4-tmu", data);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to request irq: %d\n", data->irq);
-- 
1.7.4.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
