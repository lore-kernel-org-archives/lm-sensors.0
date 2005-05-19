From: grant_lkml@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:52 +0000
Subject: [PATCH 2.6.12-rc2-mm3] i2c: new adm9240 driver
Message-Id: <82a8615210tic9fkbtdhi4op2to2qor994@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1v4861l0755o0ghph0dmb0rv5u69q45r52@4ax.com>
In-Reply-To: <1v4861l0755o0ghph0dmb0rv5u69q45r52@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 19 Apr 2005 06:27:41 +1000, Grant Coady <grant_lkml@dodo.com.au> wrote:

>Hi Khali, Greg,
>
>Another update of new adm9240 driver, completing Michiel Rook's port 
>to 2.6.  This driver adds auto new fan clock divider that is set by 
>the driver in response to fan speed limit and adjusted on fan measurement 
>overflow to always display fan speeds within measurement range without 
>further user intervention.
>
This small fixup applies over the current patch and adds bidirectional 
fan clock divider control when fan_min is disabled.  Tested at great 
risk of personal injury by sticking my finger into the fan to slow it 
down :o) 

The bidirectional adjust will not 'hunt' for a value as one switchpoint 
is < 96 underrange, the other is =255 overrange.

Signed-Off-By: Grant Coady <gcoady@gmail.com>


---
 adm9240.c |   25 ++++++++++++++++++-------
 1 files changed, 18 insertions(+), 7 deletions(-)

--- linux-2.6.12-rc2-mm3k/drivers/i2c/chips/adm9240.c.old	2005-04-19 07:30:57.000000000 +1000
+++ linux-2.6.12-rc2-mm3k/drivers/i2c/chips/adm9240.c	2005-04-19 07:31:33.000000000 +1000
@@ -649,24 +649,35 @@ static struct adm9240_data *adm9240_upda
 			data->fan[i] = adm9240_read_value(client,
 					ADM9240_REG_FAN(i));
 
-			/* adjust fan clock divider when:
+			/* adjust fan clock divider upwards when:
 			 * - measurement overflows, and
-			 * - auto fan_div enabled, and
 			 * - fan_div < max value
-			 * also adjust fan_min to suit new fan_div,
-			 * but do not let fan_min go to zero */
-			if (data->fan[i] = 255 && data->fan_min[i] < 255
-					&& data->fan_div[i] < 3) {
+			 * also adjust fan_min to suit new fan_div if:
+			 * - fan_min is active, and
+			 * - fan_min > 1 to prevent value going to zero */
+			if (data->fan[i] = 255 && data->fan_div[i] < 3) {
 
 				data->fan_div[i]++;
 				adm9240_write_fan_div(client, i,
 						data->fan_div[i]);
 
-				if (data->fan_min[i] > 1) {
+				if (data->fan_min[i] < 255
+						&& data->fan_min[i] > 1) {
 					data->fan_min[i]++;
 					data->fan_min[i] >>= 1;
 				}
 			}
+			/* adjust fan clock divider downwards when:
+			 * - measurement underflows resolution, and
+			 * - fan_min is disabled, and
+			 * - fan_div > min value */
+			if (data->fan[i] < 96 && data->fan_div[i] > 0
+					&& data->fan_min[i] = 255) {
+				data->fan_div[i]--;
+				adm9240_write_fan_div(client, i,
+						data->fan_div[i]);
+			}
+
 			data->alarms[i] = adm9240_read_value(client,
 					ADM9240_REG_INT(i));
 		}
