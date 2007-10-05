From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Fri, 05 Oct 2007 07:33:09 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon/lm87: Fix a division by zero
Message-Id: <4705E8B5.2060807@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070926221656.6442f1b2@hyperion.delvare>
In-Reply-To: <20070926221656.6442f1b2@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi All,

In this post:
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-September/021288.html

Jean Delvare wrote:
--------------------------------------------
Missing parentheses in the definition of FAN_FROM_REG cause a division
by zero for a specific register value.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
---
  drivers/hwmon/lm87.c |    2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.23-rc8.orig/drivers/hwmon/lm87.c	2007-09-26 21:33:40.000000000 +0200
+++ linux-2.6.23-rc8/drivers/hwmon/lm87.c	2007-09-26 21:34:24.000000000 +0200
@@ -129,7 +129,7 @@ static u8 LM87_REG_TEMP_LOW[3] = { 0x3A,
  				 (((val) < 0 ? (val)-500 : (val)+500) / 1000))

  #define FAN_FROM_REG(reg,div)	((reg) = 255 || (reg) = 0 ? 0 : \
-				 1350000 + (reg)*(div) / 2) / ((reg)*(div))
+				 (1350000 + (reg)*(div) / 2) / ((reg)*(div)))
  #define FAN_TO_REG(val,div)	((val)*(div) * 255 <= 1350000 ? 255 : \
  				 (1350000 + (val)*(div) / 2) / ((val)*(div)))


--------------------------------------------
Looks good:
Acked-by: Hans de Goede <j.w.r.degoede@hhs.nl>

Regards,

Hans


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
