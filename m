From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 08 Aug 2013 19:43:48 +0000
Subject: Re: [lm-sensors] [PATCH 1/1] hwmon: (adt7470) Fix incorrect return code check
Message-Id: <20130808194348.GA16138@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1375989063-24337-1-git-send-email-curt@cumulusnetworks.com>
In-Reply-To: <1375989063-24337-1-git-send-email-curt@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Aug 08, 2013 at 12:11:03PM -0700, curt@cumulusnetworks.com wrote:
> From: Curt Brune <curt@cumulusnetworks.com>
> 
> In adt7470_write_word_data(), which writes two bytes using
> i2c_smbus_write_byte_data(), the return codes are incorrectly AND-ed
> together when they should be OR-ed together.
> 
> The return code of i2c_smbus_write_byte_data() is zero for success.
> 
> The upshot is only the first byte was ever written to the hardware.
> The 2nd byte was never written out.
> 
> I noticed that trying to set the fan speed limits was not working
> correctly on my system.  Setting the fan speed limits is the only
> code that uses adt7470_write_word_data().  After making the change
> the limit settings work and the alarms work also.
> 
> Signed-off-by: Curt Brune <curt@cumulusnetworks.com>
> ---
>  drivers/hwmon/adt7470.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/adt7470.c b/drivers/hwmon/adt7470.c
> index 0f34bca..6099f50 100644
> --- a/drivers/hwmon/adt7470.c
> +++ b/drivers/hwmon/adt7470.c
> @@ -215,7 +215,7 @@ static inline int adt7470_write_word_data(struct i2c_client *client, u8 reg,
>  					  u16 value)
>  {
>  	return i2c_smbus_write_byte_data(client, reg, value & 0xFF)
> -	       && i2c_smbus_write_byte_data(client, reg + 1, value >> 8);
> +	       || i2c_smbus_write_byte_data(client, reg + 1, value >> 8);
>  }

Good catch, though it the code should really check for and return the error code
instead (or return nothing). But we can handle that in a separate cleanup patch.

Applied.

Thanks,
Guenter

>  
>  static void adt7470_init_client(struct i2c_client *client)
> -- 
> 1.7.10.4
> 
> 
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
> 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
