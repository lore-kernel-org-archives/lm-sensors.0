From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 27 Feb 2013 09:35:48 +0000
Subject: Re: [lm-sensors] [PATCH 4/7] hwmon: (pmbus/ltc2978) Use detected chip ID to select supported functio
Message-Id: <20130227103548.66e126e3@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1361585975-5604-4-git-send-email-linux@roeck-us.net>
In-Reply-To: <1361585975-5604-4-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 22 Feb 2013 18:19:32 -0800, Guenter Roeck wrote:
> We read the chip ID from the chip, use it to determine if the chip ID provided
> to the driver is correct, and report it if wrong. We should also use the
> correct chip ID to select supported functionality.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> Candidate for -stable.
> 
>  drivers/hwmon/pmbus/ltc2978.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/pmbus/ltc2978.c b/drivers/hwmon/pmbus/ltc2978.c
> index eec294a..14f96ae 100644
> --- a/drivers/hwmon/pmbus/ltc2978.c
> +++ b/drivers/hwmon/pmbus/ltc2978.c
> @@ -326,7 +326,7 @@ static int ltc2978_probe(struct i2c_client *client,
>  	data->temp_min = 0x7bff;
>  	data->temp_max = 0x7c00;
>  
> -	switch (id->driver_data) {
> +	switch (data->id) {
>  	case ltc2978:
>  		info->read_word_data = ltc2978_read_word_data;
>  		info->pages = 8;

Because it makes things consistent:

Acked-by: Jean Delvare <khali@linux-fr.org>

That being said, probe() isn't supposed to do device detection in the
first place. If you want devices to be auto-detected, there is the
detect() function for that. Right now there is no way for the user to
instantiate a device if it doesn't have exactly the expected ID. This
could happen though, if using a compatible part from a different
manufacturer, or a recent part with a new ID, for example.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
