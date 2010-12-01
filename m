From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 01 Dec 2010 13:59:06 +0000
Subject: Re: [lm-sensors] [PATCH] adm1026: fix setting fan_div (2nd try)
Message-Id: <20101201145906.5f81c66e@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101201005717.GE30973@penguintown.net>
In-Reply-To: <20101201005717.GE30973@penguintown.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Gabriele,

On Tue, 30 Nov 2010 16:57:17 -0800, Gabriele Gorla wrote:
> Prevent setting fan_div from stomping on other fans that share the same i2c register.
> 
> Signed-off-by: Gabriele Gorla <gorlik at penguintown.net>
> ---
> 
> diff -r -U 5 linux-source-2.6.26_orig/drivers/hwmon/adm1026.c linux-source-2.6.26/drivers/hwmon/adm1026.c
> --- linux-source-2.6.26_orig/drivers/hwmon/adm1026.c	2008-07-13 14:51:29.000000000 -0700
> +++ linux-source-2.6.26/drivers/hwmon/adm1026.c	2010-11-30 16:35:27.000000000 -0800
> @@ -918,34 +918,36 @@
>  {
>  	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
>  	int nr = sensor_attr->index;
>  	struct i2c_client *client = to_i2c_client(dev);
>  	struct adm1026_data *data = i2c_get_clientdata(client);
> -	int val, orig_div, new_div, shift;
> +	int val, orig_div, new_div;
>  
>  	val = simple_strtol(buf, NULL, 10);
>  	new_div = DIV_TO_REG(val);
>  	if (new_div = 0) {
>  		return -EINVAL;
>  	}
>  	mutex_lock(&data->update_lock);
>  	orig_div = data->fan_div[nr];
> -	data->fan_div[nr] = DIV_FROM_REG(new_div);
> +	if (orig_div != DIV_FROM_REG(new_div)) {
> +		data->fan_div[nr] = DIV_FROM_REG(new_div);
>  
> -	if (nr < 4) { /* 0 <= nr < 4 */
> -		shift = 2 * nr;
> -		adm1026_write_value(client, ADM1026_REG_FAN_DIV_0_3,
> -			((DIV_TO_REG(orig_div) & (~(0x03 << shift))) |
> -			(new_div << shift)));
> -	} else { /* 3 < nr < 8 */
> -		shift = 2 * (nr - 4);
> -		adm1026_write_value(client, ADM1026_REG_FAN_DIV_4_7,
> -			((DIV_TO_REG(orig_div) & (~(0x03 << (2 * shift)))) |
> -			(new_div << shift)));
> -	}
> +		if (nr < 4) { /* 0 <= nr < 4 */
> +			adm1026_write_value(client, ADM1026_REG_FAN_DIV_0_3,
> +				    (DIV_TO_REG(data->fan_div[0]) << 0) |
> +				    (DIV_TO_REG(data->fan_div[1]) << 2) |
> +				    (DIV_TO_REG(data->fan_div[2]) << 4) |
> +				    (DIV_TO_REG(data->fan_div[3]) << 6));
> +		} else { /* 3 < nr < 8 */
> +			adm1026_write_value(client, ADM1026_REG_FAN_DIV_4_7,
> +				    (DIV_TO_REG(data->fan_div[4]) << 0) |
> +				    (DIV_TO_REG(data->fan_div[5]) << 2) |
> +				    (DIV_TO_REG(data->fan_div[6]) << 4) |
> +				    (DIV_TO_REG(data->fan_div[7]) << 6));
> +		}
>  
> -	if (data->fan_div[nr] != orig_div) {
>  		fixup_fan_min(dev, nr, orig_div);
>  	}
>  	mutex_unlock(&data->update_lock);
>  	return count;
>  }

Your patch is correct. However, in order to get the fix in stable
kernel series, I would prefer an even more minimalist fix, only
addressing the actual bug. The two minor optimizations (skipping the
register write if the value is the same and skipping the call to
fixup_fan_min if the value is different but resulted in the same
register encoding) would rather be left out at this time.

This would result in the following patch:

---
 drivers/hwmon/adm1026.c |   16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

--- linux-2.6.37-rc4.orig/drivers/hwmon/adm1026.c	2010-12-01 13:48:13.000000000 +0100
+++ linux-2.6.37-rc4/drivers/hwmon/adm1026.c	2010-12-01 14:20:14.000000000 +0100
@@ -916,7 +916,7 @@ static ssize_t set_fan_div(struct device
 	int nr = sensor_attr->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adm1026_data *data = i2c_get_clientdata(client);
-	int val, orig_div, new_div, shift;
+	int val, orig_div, new_div;
 
 	val = simple_strtol(buf, NULL, 10);
 	new_div = DIV_TO_REG(val);
@@ -928,15 +928,17 @@ static ssize_t set_fan_div(struct device
 	data->fan_div[nr] = DIV_FROM_REG(new_div);
 
 	if (nr < 4) { /* 0 <= nr < 4 */
-		shift = 2 * nr;
 		adm1026_write_value(client, ADM1026_REG_FAN_DIV_0_3,
-			((DIV_TO_REG(orig_div) & (~(0x03 << shift))) |
-			(new_div << shift)));
+				    (DIV_TO_REG(data->fan_div[0]) << 0) |
+				    (DIV_TO_REG(data->fan_div[1]) << 2) |
+				    (DIV_TO_REG(data->fan_div[2]) << 4) |
+				    (DIV_TO_REG(data->fan_div[3]) << 6));
 	} else { /* 3 < nr < 8 */
-		shift = 2 * (nr - 4);
 		adm1026_write_value(client, ADM1026_REG_FAN_DIV_4_7,
-			((DIV_TO_REG(orig_div) & (~(0x03 << (2 * shift)))) |
-			(new_div << shift)));
+				    (DIV_TO_REG(data->fan_div[4]) << 0) |
+				    (DIV_TO_REG(data->fan_div[5]) << 2) |
+				    (DIV_TO_REG(data->fan_div[6]) << 4) |
+				    (DIV_TO_REG(data->fan_div[7]) << 6));
 	}
 
 	if (data->fan_div[nr] != orig_div) {

As you can see, it's more compact and immediately obviously correct. So
backporting it to kernels 2.6.36, 2.6.32, 2.6.27 and maybe even
2.6.16 will be trivial. Is this OK with you? You retain patch
authorship, of course.

Regarding the optimizations, I'm not even sure if we need them.

The first optimization (skipping the register write if the value is the
same) looks nice but OTOH it is not something hwmon drivers are
supposed to do. Drivers should do what the user tells them, so if the
user says "write divider value 4 to the chip", it should just do so. If
you look at all other similar functions in the driver (e.g.
set_fan_min) you'll see it doesn't do any test and unconditionally
writes the value. As Guenter underlined before, "set" operations are
rare enough that there is little point in optimizing them.

As for the second optimization (skipping the call to fixup_fan_min if
the value is different but resulted in the same register encoding), if
we do strict checking of input values, it will become a no-op because
the cases it optimizes will no longer possibly happen.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
