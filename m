From: grant_lkml@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:52 +0000
Subject: [PATCH 2.6.12-rc2-mm3] i2c: modify lm87 to use auto fan_div
Message-Id: <arl361t11j6m9r6e15ts7vhq06k01vev5e@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <t4uv511i3ntqtdblptvsko6tfvcm27k7hf@4ax.com>
In-Reply-To: <t4uv511i3ntqtdblptvsko6tfvcm27k7hf@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 17 Apr 2005 10:16:02 +1000, Grant Coady <grant_lkml@dodo.com.au> wrote:

>Hi Khali,
>On Sat, 16 Apr 2005 03:36:44 +1000, Grant Coady <grant_lkml@dodo.com.au> wrote:
>
>Here is round two, modified for most of your comments.

Oops, sorry, I included an untested function from elsewhere, please 
apply this fix over the second round patch.  I am testing other 
changes on adm9240 driver.


# lm87.c |    2 +-
# 1 files changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.12-rc2-mm3h/drivers/i2c/chips/lm87.c.2	2005-04-17 13:05:05.000000000 +1000
+++ linux-2.6.12-rc2-mm3h/drivers/i2c/chips/lm87.c	2005-04-17 13:25:12.000000000 +1000
@@ -414,7 +414,7 @@ static void lm87_write_fan_div(struct i2
 	reg = lm87_read_value(client, LM87_REG_VID_FAN_DIV);
 	old = (reg >> shift) & 3;
 	reg &= ~(3 << shift);
-	reg |= fan_div << shift;
+	reg |= (fan_div << shift);
 	lm87_write_value(client, LM87_REG_VID_FAN_DIV, reg);
 	dev_dbg(&client->dev, "fan%d clock divider changed from %u to %u\n",
 					nr + 1, 1 << old, 1 << fan_div);
