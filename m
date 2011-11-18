From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 18 Nov 2011 07:30:27 +0000
Subject: Re: [lm-sensors] [PATCH 32/32] Drivers: hwmon: adm1031: fixed a
Message-Id: <20111118083027.6d44d277@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1321596670-11365-1-git-send-email-zac.3.14159@gmail.com>
In-Reply-To: <1321596670-11365-1-git-send-email-zac.3.14159@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Zac Storer <zac.3.14159@gmail.com>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

Hi Zac,

On Thu, 17 Nov 2011 23:11:09 -0700, Zac Storer wrote:
> Fixed a brace coding style issue.
> 
> Signed-off-by: Zac Storer <zac.3.14159@gmail.com>
> ---
>  drivers/hwmon/adm1031.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/hwmon/adm1031.c b/drivers/hwmon/adm1031.c
> index 0683e6b..04e2adc 100644
> --- a/drivers/hwmon/adm1031.c
> +++ b/drivers/hwmon/adm1031.c
> @@ -299,7 +299,7 @@ set_fan_auto_channel(struct device *dev, struct device_attribute *attr,
>  	data->conf1 = FAN_CHAN_TO_REG(reg, data->conf1);
>  	if ((data->conf1 & ADM1031_CONF1_AUTO_MODE) ^
>  	    (old_fan_mode & ADM1031_CONF1_AUTO_MODE)) {
> -		if (data->conf1 & ADM1031_CONF1_AUTO_MODE){
> +		if (data->conf1 & ADM1031_CONF1_AUTO_MODE) {
>  			/* Switch to Auto Fan Mode
>  			 * Save PWM registers
>  			 * Set PWM registers to 33% Both */

This is correct. And the adm1031 driver suffers from several other style
issues reported by checkpatch:

ERROR: need consistent spacing around '<<' (ctx:VxW)
#178: FILE: hwmon/adm1031.c:178:
+#define AUTO_TEMP_RANGE_FROM_REG(reg)  (5000 * (1<< ((reg)&0x7)))
                                                  ^
ERROR: "foo * bar" should be "foo *bar"
#233: FILE: hwmon/adm1031.c:233:
+                    int chan, u8 val, u8 reg, u8 * new_reg)

WARNING: suspect code indent for conditional statements (8, 12)
#973: FILE: hwmon/adm1031.c:973:
+       if ((read_val | mask) != read_val) {
+           adm1031_write_value(client, ADM1031_REG_CONF2, read_val | mask);

WARNING: suspect code indent for conditional statements (8, 12)
#978: FILE: hwmon/adm1031.c:978:
+       if ((read_val | ADM1031_CONF1_MONITOR_ENABLE) != read_val) {
+           adm1031_write_value(client, ADM1031_REG_CONF1, read_val |

ERROR: spaces required around that '=' (ctx:VxV)
#1061: FILE: hwmon/adm1031.c:1061:
+               for (chan=0; chan<(data->chip_type = adm1030 ? 1 : 2); chan++) {
                         ^

ERROR: spaces required around that '<' (ctx:VxV)
#1061: FILE: hwmon/adm1031.c:1061:
+               for (chan=0; chan<(data->chip_type = adm1030 ? 1 : 2); chan++) {
                                 ^
As you are touching the file already, would you mind fixing the issues
above too?

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
