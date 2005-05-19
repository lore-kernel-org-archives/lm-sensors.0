From: grant_lkml@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:52 +0000
Subject: RFC PATCH adm1026: add auto-fan_div
Message-Id: <0vm361t3o4ui9ov38lvpdrv069um9e37ic@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <rgou519s7v8cpfb3rvr7lpk7vhd932mbom@4ax.com>
In-Reply-To: <rgou519s7v8cpfb3rvr7lpk7vhd932mbom@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Philip,

On Fri, 15 Apr 2005 16:42:52 +1000, Grant Coady <grant_lkml@dodo.com.au> wrote:

>On Thu, 14 Apr 2005 21:03:31 -0700, Philip Pokorny <ppokorny@penguincomputing.com> wrote:
>
>>Go ahead and work up the patch for the adm1026.  I'd like to review it, 
>>but since it's fresh in your mind, have at it.

I owe you a pair of paranthesis, sorry about that, please apply this 
fix over the patch.

Cheers,
Grant.


# adm1026.c |    8 ++++----
# 1 files changed, 4 insertions(+), 4 deletions(-)

--- linux-2.6.12-rc2-mm3i/drivers/i2c/chips/adm1026.c.orig	2005-04-17 13:41:33.000000000 +1000
+++ linux-2.6.12-rc2-mm3i/drivers/i2c/chips/adm1026.c	2005-04-17 13:43:25.000000000 +1000
@@ -959,12 +959,12 @@ static void adm1026_write_fan_div(struct
 {
 	u8 reg, old;
 	u8 sel = (nr >> 2) & 1;
-	u8 shf = (nr & 3) * 2;
+	u8 shift = (nr & 3) * 2;
 
 	reg = adm1026_read_value(client, ADM1026_REG_FAN_DIV(sel));
-	old = (reg >> shf) & 3;
-	reg &= ~(0x03 << shf);
-	reg |= fan_div << shf;
+	old = (reg >> shift) & 3;
+	reg &= ~(0x03 << shift);
+	reg |= (fan_div << shift);
 	adm1026_write_value(client, ADM1026_REG_FAN_DIV(sel), reg);
 	dev_dbg(&client->dev, "autoX fan%u old %u new %u   fan_div changed\n",
 			nr + 1, 1 << old, 1 << fan_div);
