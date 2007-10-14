From: Jim Cromie <jim.cromie@gmail.com>
Date: Sun, 14 Oct 2007 23:20:50 +0000
Subject: Re: [lm-sensors] [patch 1/1] w83627hf push nr+1 offset into
Message-Id: <4712A452.1020609@gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------010109050704000605070207"
List-Id: <lm-sensors.vger.kernel.org>
References: <cfe85dfa0710121903r766b4b2ei69c81afab3c1e323@mail.gmail.com>
In-Reply-To: <cfe85dfa0710121903r766b4b2ei69c81afab3c1e323@mail.gmail.com>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------010109050704000605070207
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jean Delvare wrote:
> Hi Jim,
>
>
>   
again, respun per your comments.

>
>> -#define W83781D_REG_FAN_MIN(nr) (0x3a + (nr))
>> -#define W83781D_REG_FAN(nr) (0x27 + (nr))
>> +#define W83781D_REG_FAN_MIN(nr) (0x3b + (nr))
>> +#define W83781D_REG_FAN(nr) (0x28 + (nr))
>>     
>
> Here again, please rename these W83627HF_* while you're here. Maybe
> also tab-align the definitions for readability. I would also appreciate
> a comment giving the valid values of nr, just to clear up any possible
> confusion.
>
>   
Done.

>> +	for (i = 0; i <= 2; i++)
>> +		data->fan_min[i] =
>> +			w83627hf_read_value(data, W83781D_REG_FAN_MIN(i));
>>     
>
> At this point your patch conflicts with one I sent a few days ago:
> hwmon: (w83627hf) Fix setting fan min right after driver load
> http://lm-sensors.org/kernel?p=kernel/mhoffman/hwmon-2.6.git;a=commitdiff;h=c09c5184a26158da32801e89d5849d774605f0dd
>
> Please make sure you have this patch applied on your local tree before
> regenerating and resending your patch.
>
>   
Yup. done.
> Rest looks OK and testing is OK as well.
>
> Thanks,
>   



--------------010109050704000605070207
Content-Type: text/plain;
 name="diff.hwmon-w83627hf-fan-offset-into-macro"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="diff.hwmon-w83627hf-fan-offset-into-macro"

Binary files hwmon-hoist-temp/arch/i386/boot/setup.elf and hwmon-fan-push-offset/arch/i386/boot/setup.elf differ
diff -ruNp -X dontdiff -X exclude-diffs hwmon-hoist-temp/drivers/hwmon/w83627hf.c hwmon-fan-push-offset/drivers/hwmon/w83627hf.c
--- hwmon-hoist-temp/drivers/hwmon/w83627hf.c	2007-10-14 16:58:56.000000000 -0600
+++ hwmon-fan-push-offset/drivers/hwmon/w83627hf.c	2007-10-14 17:13:47.000000000 -0600
@@ -170,8 +170,9 @@ superio_exit(void)
 #define W83781D_REG_IN(nr)     ((nr < 7) ? (0x20 + (nr)) : \
 					   (0x550 + (nr) - 7))
 
-#define W83781D_REG_FAN_MIN(nr) (0x3a + (nr))
-#define W83781D_REG_FAN(nr) (0x27 + (nr))
+/* nr:0-2 for fans:1-3 */
+#define W83627HF_REG_FAN_MIN(nr)	(0x3b + (nr))
+#define W83627HF_REG_FAN(nr)		(0x28 + (nr))
 
 #define W83627HF_REG_TEMP2_CONFIG 0x152
 #define W83627HF_REG_TEMP3_CONFIG 0x252
@@ -582,7 +583,7 @@ store_fan_min(struct device *dev, struct
 
 	mutex_lock(&data->update_lock);
 	data->fan_min[nr] = FAN_TO_REG(val, DIV_FROM_REG(data->fan_div[nr]));
-	w83627hf_write_value(data, W83781D_REG_FAN_MIN(nr+1),
+	w83627hf_write_value(data, W83627HF_REG_FAN_MIN(nr),
 			     data->fan_min[nr]);
 
 	mutex_unlock(&data->update_lock);
@@ -814,7 +815,7 @@ store_fan_div(struct device *dev, struct
 
 	/* Restore fan_min */
 	data->fan_min[nr] = FAN_TO_REG(min, DIV_FROM_REG(data->fan_div[nr]));
-	w83627hf_write_value(data, W83781D_REG_FAN_MIN(nr+1), data->fan_min[nr]);
+	w83627hf_write_value(data, W83627HF_REG_FAN_MIN(nr), data->fan_min[nr]);
 
 	mutex_unlock(&data->update_lock);
 	return count;
@@ -1140,7 +1141,7 @@ static int __devinit w83627hf_probe(stru
 	struct w83627hf_sio_data *sio_data = dev->platform_data;
 	struct w83627hf_data *data;
 	struct resource *res;
-	int err;
+	int err, i;
 
 	static const char *names[] = {
 		"w83627hf",
@@ -1174,9 +1175,9 @@ static int __devinit w83627hf_probe(stru
 	w83627hf_init_device(pdev);
 
 	/* A few vars need to be filled upon startup */
-	data->fan_min[0] = w83627hf_read_value(data, W83781D_REG_FAN_MIN(1));
-	data->fan_min[1] = w83627hf_read_value(data, W83781D_REG_FAN_MIN(2));
-	data->fan_min[2] = w83627hf_read_value(data, W83781D_REG_FAN_MIN(3));
+	for (i = 0; i <= 2; i++)
+		data->fan_min[i] = w83627hf_read_value(
+					data, W83627HF_REG_FAN_MIN(i));
 	w83627hf_update_fan_div(data);
 
 	/* Register common device attributes */
@@ -1554,12 +1555,12 @@ static struct w83627hf_data *w83627hf_up
 			    w83627hf_read_value(data,
 					       W83781D_REG_IN_MAX(i));
 		}
-		for (i = 1; i <= 3; i++) {
-			data->fan[i - 1] =
-			    w83627hf_read_value(data, W83781D_REG_FAN(i));
-			data->fan_min[i - 1] =
+		for (i = 0; i <= 2; i++) {
+			data->fan[i] =
+			    w83627hf_read_value(data, W83627HF_REG_FAN(i));
+			data->fan_min[i] =
 			    w83627hf_read_value(data,
-					       W83781D_REG_FAN_MIN(i));
+					       W83627HF_REG_FAN_MIN(i));
 		}
 		for (i = 0; i <= 2; i++) {
 			u8 tmp = w83627hf_read_value(data,

--------------010109050704000605070207
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------010109050704000605070207--
