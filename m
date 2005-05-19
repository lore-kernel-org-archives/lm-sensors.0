From: grant_nospam@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:46 +0000
Subject: RFC PATCH add set_value locking
Message-Id: <kbg941pof4ufiov5cmt07tirgth7f7vc4b@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1uc941199l784l0uij33lhigg19qm366f3@4ax.com>
In-Reply-To: <1uc941199l784l0uij33lhigg19qm366f3@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Greetings,

On Sat, 26 Mar 2005 12:02:58 +1100, Grant Coady <grant_nospam@dodo.com.au> wrote:
>This patch adds locking around set operations that access 
>data->something and go out to the chip.

One more: adm1021

as separate files from: 
  http://scatter.mine.nu/lmsensors/lock-on-set/

Sign-off-by: Grant Coady <gcoady@gmail.com>


--- linux-2.6.12-rc1-mm3/drivers/i2c/chips/adm1021.c	2005-03-26 07:26:41.000000000 +1100
+++ linux-2.6.12-rc1-mm3x/drivers/i2c/chips/adm1021.c	2005-03-26 12:55:27.000000000 +1100
@@ -165,8 +165,10 @@
 	struct adm1021_data *data = i2c_get_clientdata(client);	\
 	int temp = simple_strtoul(buf, NULL, 10);		\
 								\
+	down(&data->update_lock);				\
 	data->value = TEMP_TO_REG(temp);			\
 	adm1021_write_value(client, reg, data->value);		\
+	up(&data->update_lock);					\
 	return count;						\
 }
 set(temp_max, ADM1021_REG_TOS_W);
