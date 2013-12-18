From: Anthony Olech <anthony.olech.opensource@diasemi.com>
Date: Wed, 18 Dec 2013 15:21:13 +0000
Subject: [lm-sensors] [PATCH V1] fix adc to voltage calculation in da9052 power driver
Message-Id: <201312181524.rBIFOv96017094@swsrvapps-02.lan>
List-Id: <lm-sensors.vger.kernel.org>
References: <201312181524.rBIFOhNp017016@swsrvapps-02.lan>
In-Reply-To: <201312181524.rBIFOhNp017016@swsrvapps-02.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Anton Vorontsov <anton@enomsg.org>, David Woodhouse <dwmw2@infradead.org>
Cc: "open list:HARDWARE MONITORING" <lm-sensors@lm-sensors.org>, open list <linux-kernel@vger.kernel.org>, David Dajun Chen <david.chen@diasemi.com>

The ADC resolution of the PMIC is 10-bits, this means that the maximum
possible value is 1023 and not the 1024 as in the code.

Signed-off-by: Anthony Olech <anthony.olech.opensource@diasemi.com>
---
This patch is relative to linux-next repository tag next-20131218

 drivers/power/da9052-battery.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/da9052-battery.c b/drivers/power/da9052-battery.c
index f8f4c0f..8f0f259 100644
--- a/drivers/power/da9052-battery.c
+++ b/drivers/power/da9052-battery.c
@@ -178,7 +178,7 @@ struct da9052_battery {
 
 static inline int volt_reg_to_mV(int value)
 {
-	return ((value * 1000) / 512) + 2500;
+	return DIV_ROUND_CLOSEST(value * 2000, 1023) + 2500;
 }
 
 static inline int ichg_reg_to_mA(int value)
-- 
end-of-patch for fix adc to voltage calculation in da9052 power driver V1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
