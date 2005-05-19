From: grant_nospam@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:46 +0000
Subject: RFC PATCH add set_value locking
Message-Id: <0bj941h1lviujb2q2evu1ep72hk1r2e0ge@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1uc941199l784l0uij33lhigg19qm366f3@4ax.com>
In-Reply-To: <1uc941199l784l0uij33lhigg19qm366f3@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 26 Mar 2005 13:26:03 +1100, Grant Coady <grant_nospam@dodo.com.au> wrote:

>On Sat, 26 Mar 2005 12:02:58 +1100, Grant Coady <grant_nospam@dodo.com.au> wrote:
>
>>Greetings,
>>
>>This patch adds locking around set operations that access 
>>data->something and go out to the chip.
>>
>Lucky last: it87

it87 needs a small fixup, oops.  This applies over previous patch 
in this series.  Again, this time inline, enough for today  :o)

Sign-off-by: Grant Coady <gcoady@gmail.com>


--- linux-2.6.12-rc1-mm3x/drivers/i2c/chips/it87.c~	2005-03-26 13:20:03.000000000 +1100
+++ linux-2.6.12-rc1-mm3x/drivers/i2c/chips/it87.c	2005-03-26 13:43:30.000000000 +1100
@@ -442,8 +442,10 @@
 	    data->sensor |= 1 << nr;
 	else if (val = 2)
 	    data->sensor |= 8 << nr;
-	else if (val != 0)
+	else if (val != 0) {
+		up(&data->update_lock);
 		return -EINVAL;
+	}
 	it87_write_value(client, IT87_REG_TEMP_ENABLE, data->sensor);
 	up(&data->update_lock);
 	return count;
@@ -583,11 +585,11 @@
 	struct it87_data *data = i2c_get_clientdata(client);
 	int val = simple_strtol(buf, NULL, 10);
 
-	down(&data->update_lock);
-
 	if (val < 0 || val > 255)
 		return -EINVAL;
 
+	down(&data->update_lock);
+
 	data->manual_pwm_ctl[nr] = val;
 	if (data->fan_main_ctrl & (1 << nr))
 		it87_write_value(client, IT87_REG_PWM(nr),
