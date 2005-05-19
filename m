From: grant_lkml@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:54 +0000
Subject: [PATCH 2.6] I2C: New hardware monitoring driver: w83627ehf (2nd
Message-Id: <nlgo611jkoevf3cu1v4idrd5fuei8hv52k@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050416201701.7e4a5e74.khali@linux-fr.org>
In-Reply-To: <20050416201701.7e4a5e74.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Khali, All,
On Sun, 24 Apr 2005 11:01:52 +0200, Jean Delvare <khali@linux-fr.org> wrote:

This is a small change to the fan clock divider adjustment performed 
in the fan speed measuring code.

Fan max clock divider check changed to be defensive.

Prevent fan low limit becoming active if it is set to sentinel 255 value 
(low limit alarm inactive) and prevent fan low limit going to zero.

Compile tested.



Signed-off-by: Grant Coady <gcoady@gmail.com>

---
 w83627ehf.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

--- linux-2.6.12-rc3b/drivers/i2c/chips/w83627ehf.c.orig	2005-04-25 10:56:49.000000000 +1000
+++ linux-2.6.12-rc3b/drivers/i2c/chips/w83627ehf.c	2005-04-25 11:01:18.000000000 +1000
@@ -358,15 +358,17 @@
 			   divider can be increased, let's try that for next
 			   time */
 			if (data->fan[i] = 0xff
-			 && data->fan_div[i] != 0x07) {
+			 && data->fan_div[i] < 0x07) {
 			 	dev_dbg(&client->dev, "Increasing fan %d "
 					"clock divider from %u to %u\n",
 					i, div_from_reg(data->fan_div[i]),
 					div_from_reg(data->fan_div[i] + 1));
 				data->fan_div[i]++;
 				w83627ehf_write_fan_div(client, i);
-				/* Preserve min limit */
-				w83627ehf_write_value(client,
+				/* Preserve min limit if limit active */
+				if (data->fan_min[i] > 1 /* keep > 0 */
+						&& data->fan_min[i] < 255)
+					w83627ehf_write_value(client,
 						      W83627EHF_REG_FAN_MIN[i],
 						      (data->fan_min[i] /= 2));
 			}
