From: grant_nospam@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:44 +0000
Subject: RFC PATCH update via686a DIV_TO_REG to return error
Message-Id: <i89t319e3nucsju81u8q8ibfq1p58njtjb@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <djas31ljne3adsttsb6819i1ijeut47js2@4ax.com>
In-Reply-To: <djas31ljne3adsttsb6819i1ijeut47js2@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 21 Mar 2005 10:35:29 +0100 (CET), "Jean Delvare" <khali@linux-fr.org> wrote:
. . .
>I don't think it is needed. It makes sense for conversions that cannot
>fail, as it makes the code more readable. But here, this is real code,
>called only once, so I would keep it in the parent function. Seems more
>readable to me, and more efficient as well (the way you did it adds a
>comparison and a local variable in the parent function.)
>
>> Adjust fan limits required?
>
>It's not required, in that your patch already does something we want per
>se; but definitely welcome, for example as a patch to apply after this
>one.
>
>Please don't name it "tmp". By nature, all local variables are
>temporary, so such a name doesn't help. That being said, there won't
>be no more variable needed if you merge DIV_TO_REG in there, so that's
>another way to solve the problem ;)

Actually I'm still playing with ideas, suggesting idea of bailing 
out if no change to divisor, saves accessing i2c for unnecessary 
read/modify/write cycle to chip.

>Strange indentation.
I'm a strange person  (o:

Okay, here's second attempt.  Compile tested, this source tree has all 
drivers selected as modules, so compiling is quick, let me know if I 
need to test compile-in as well, please.  

grant@peetoo:/usr/src/linux-2.6.11-mm4a$ cat /home/public/patch-update-DIV_TO_REG-via686a-2 |patch -p1
patching file drivers/i2c/chips/via686a.c
grant@peetoo:/usr/src/linux-2.6.11-mm4a$ make
  CHK     include/linux/version.h
make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
  CHK     include/linux/compile.h
  CHK     usr/initramfs_list
  CC [M]  drivers/i2c/chips/via686a.o
Kernel: arch/i386/boot/bzImage is ready
  Building modules, stage 2.
  MODPOST
  LD [M]  drivers/i2c/chips/via686a.ko
grant@peetoo:/usr/src/linux-2.6.11-mm4a$ cat /home/public/patch-update-DIV_TO_REG-via686a-2 |patch -p1
patching file drivers/i2c/chips/via686a.c
Reversed (or previously applied) patch detected!  Assume -R? [n] y
grant@peetoo:/usr/src/linux-2.6.11-mm4a$

I back out patch straight away so tree clean for next time.
Does it make a difference I'm running slackware-current with 
2.4.29-hf5 on the test box at the moment?

Cheers,
Grant.

--- linux-2.6.11-mm4/drivers/i2c/chips/via686a.c	2005-03-17 07:56:48.000000000 +1100
+++ linux-2.6.11-mm4x/drivers/i2c/chips/via686a.c	2005-03-21 21:38:59.000000000 +1100
@@ -297,7 +297,6 @@
 #define ALARMS_FROM_REG(val) (val)
 
 #define DIV_FROM_REG(val) (1 << (val))
-#define DIV_TO_REG(val) ((val)=8?3:(val)=4?2:(val)=1?0:1)
 
 /* For the VIA686A, we need to keep some data in memory.
    The structure is dynamically allocated, at the same time when a new
@@ -506,15 +505,43 @@
 	via686a_write_value(client, VIA686A_REG_FAN_MIN(nr+1), data->fan_min[nr]);
 	return count;
 }
+
+/*
+ * DIV_TO_REG subsumed into this function
+ * Add error reporting for invalid fan divisor input
+ * Skip updating when no change in divisor
+ * Adjust fan_min to match new divisor
+ */
+
 static ssize_t set_fan_div(struct device *dev, const char *buf, 
 		size_t count, int nr) {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct via686a_data *data = i2c_get_clientdata(client);
-	int val = simple_strtol(buf, NULL, 10);
+	int new, val = simple_strtol(buf, NULL, 10);
+
+	switch (val) {
+	case 1: new = 0; break;
+	case 2: new = 1; break;
+	case 4: new = 2; break;
+	case 8: new = 3; break;
+	default:
+		dev_err(&client->dev, "fan_div value %d not supported. "
+				"Choose one of 1, 2, 4, or 8!\n", val);
+		return -EINVAL;
+	}
+	if (new = data->fan_div[nr])
+		goto exit;
+	
 	int old = via686a_read_value(client, VIA686A_REG_FANDIV);
-	data->fan_div[nr] = DIV_TO_REG(val);
+	long min = FAN_FROM_REG(data->fan_min[nr], 
+					DIV_FROM_REG(data->fan_div[nr]));
+	data->fan_div[nr] = new;
 	old = (old & 0x0f) | (data->fan_div[1] << 6) | (data->fan_div[0] << 4);
 	via686a_write_value(client, VIA686A_REG_FANDIV, old);
+	data->fan_min[nr] = FAN_TO_REG(min, DIV_FROM_REG(data->fan_div[nr]));
+	via686a_write_value(client, VIA686A_REG_FAN_MIN(nr + 1),
+					data->fan_min[nr]);
+exit:
 	return count;
 }
 
