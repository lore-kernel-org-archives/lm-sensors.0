From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 11 Dec 2013 14:33:25 +0000
Subject: Re: [lm-sensors] w83l786ng driver bug, questions, and 1st round patch
Message-Id: <20131211153325.15cbeee8@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CABhEY3OZAkB=NxDj-QSjWATQAPG-Akhr2a0CHTB7wahLJVH6aQ@mail.gmail.com>
In-Reply-To: <CABhEY3OZAkB=NxDj-QSjWATQAPG-Akhr2a0CHTB7wahLJVH6aQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Brian,

On Mon, 2 Dec 2013 10:17:56 +0100, Jean Delvare wrote:
> If I'm not mistaken, the following minimal fix should work:
> 
> From: Jean Delvare <khali@linux-fr.org>
> Subject: hwmon: (w83l768ng) Fix fan speed control range
> 
> The W83L786NG stores the fan speed on 4 bits while the sysfs interface
> uses a 0-255 range. Thus the driver should scale the user input down
> to map it to the device range, and scale up the value read from the
> device before presenting it to the user.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: stable@vger.kernel.org
> ---
>  drivers/hwmon/w83l786ng.c |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> --- linux-3.13-rc2.orig/drivers/hwmon/w83l786ng.c	2013-12-02 09:14:56.247009803 +0100
> +++ linux-3.13-rc2/drivers/hwmon/w83l786ng.c	2013-12-02 10:07:49.718037923 +0100
> @@ -481,6 +481,7 @@ store_pwm(struct device *dev, struct dev
>  	if (err)
>  		return err;
>  	val = clamp_val(val, 0, 255);
> +	val = DIV_ROUND_CLOSEST(val, 0x11);
>  
>  	mutex_lock(&data->update_lock);
>  	data->pwm[nr] = val;
> @@ -777,8 +778,9 @@ static struct w83l786ng_data *w83l786ng_
>  			    ? 0 : 1;
>  			data->pwm_enable[i] >  			    ((pwmcfg >> W83L786NG_PWM_ENABLE_SHIFT[i]) & 3) + 1;
> -			data->pwm[i] = w83l786ng_read_value(client,
> -			    W83L786NG_REG_PWM[i]);
> +			data->pwm[i] > +			    (w83l786ng_read_value(client, W83L786NG_REG_PWM[i])
> +			     & 0x0f) * 0x11;
>  		}
>  
>  
> Please test and confirm.

I was actually mistaken, my patch had a minor flaw that caused the
driver to temporarily return the wrong pwmN value right after setting
it. Additionally it was overwriting reserved bits in registers
W83L786NG_REG_PWM, which is bad. Patch V2 below fixes both issues:

From: Jean Delvare <khali@linux-fr.org>
Subject: hwmon: (w83l768ng) Fix fan speed control range

The W83L786NG stores the fan speed on 4 bits while the sysfs interface
uses a 0-255 range. Thus the driver should scale the user input down
to map it to the device range, and scale up the value read from the
device before presenting it to the user. The reserved register nibble
should be left unchanged.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: stable@vger.kernel.org
---
Changes in v2:
 * Scale data->pwm[nr] up when writing a new value to the
   W83L786NG_REG_PWM[nr] register.
 * Don't overwrite the 4 MSB of W83L786NG_REG_PWM.

 drivers/hwmon/w83l786ng.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- linux-3.13-rc3.orig/drivers/hwmon/w83l786ng.c	2013-12-11 15:01:33.162221180 +0100
+++ linux-3.13-rc3/drivers/hwmon/w83l786ng.c	2013-12-11 15:22:36.004771774 +0100
@@ -481,9 +481,11 @@ store_pwm(struct device *dev, struct dev
 	if (err)
 		return err;
 	val = clamp_val(val, 0, 255);
+	val = DIV_ROUND_CLOSEST(val, 0x11);
 
 	mutex_lock(&data->update_lock);
-	data->pwm[nr] = val;
+	data->pwm[nr] = val * 0x11;
+	val |= w83l786ng_read_value(client, W83L786NG_REG_PWM[nr]) & 0xf0;
 	w83l786ng_write_value(client, W83L786NG_REG_PWM[nr], val);
 	mutex_unlock(&data->update_lock);
 	return count;
@@ -777,8 +779,9 @@ static struct w83l786ng_data *w83l786ng_
 			    ? 0 : 1;
 			data->pwm_enable[i]  			    ((pwmcfg >> W83L786NG_PWM_ENABLE_SHIFT[i]) & 3) + 1;
-			data->pwm[i] = w83l786ng_read_value(client,
-			    W83L786NG_REG_PWM[i]);
+			data->pwm[i] +			    (w83l786ng_read_value(client, W83L786NG_REG_PWM[i])
+			     & 0x0f) * 0x11;
 		}
 
Again, testing would be appreciated.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
