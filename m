From: grant_nospam@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:45 +0000
Subject: RFC PATCH Trivial: add update_lock to ds1621
Message-Id: <ce1741hg93uojbblailcvngler9t57mmdg@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Greetings,

This patch adds update_lock to be held during temp update

Compile tested only

Signed-off-by: Grant Coady <gcoady@gmail.com>


--- linux-2.6.12-rc1-mm2/drivers/i2c/chips/ds1621.c	2005-03-23 06:34:25.000000000 +1100
+++ linux-2.6.12-rc1-mm2x/drivers/i2c/chips/ds1621.c	2005-03-25 14:28:32.000000000 +1100
@@ -153,8 +153,10 @@
 {									\
 	struct i2c_client *client = to_i2c_client(dev);			\
 	struct ds1621_data *data = ds1621_update_client(dev);		\
+	down(&data->update_lock);					\
 	data->value = LM75_TEMP_TO_REG(simple_strtoul(buf, NULL, 10));	\
 	ds1621_write_value(client, reg, data->value);			\
+	up(&data->update_lock);						\
 	return count;							\
 }
 
