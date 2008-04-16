From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 16 Apr 2008 13:30:43 +0000
Subject: Re: [lm-sensors] lm75: Convert to new-style I2C driver
Message-Id: <20080416153043.02f89554@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <200804161434.54335.laurentp@cse-semaphore.com>
In-Reply-To: <200804161434.54335.laurentp@cse-semaphore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Laurent,

On Wed, 16 Apr 2008 14:34:53 +0200, Laurent Pinchart wrote:
> This patch converts the lm75 driver into a new-style I2C driver.
> 
> Signed-off-by: Laurent Pinchart <laurent@pclaurent.belgium.cse-semaphore.com>
> ---
>  drivers/hwmon/lm75.c |  292 +++++++++++++++++++++-----------------------------
>  1 files changed, 124 insertions(+), 168 deletions(-)
> 
> diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
> index d7a22a5..7c17611 100644
> --- a/drivers/hwmon/lm75.c
> +++ b/drivers/hwmon/lm75.c
> @@ -29,14 +29,6 @@
>  #include <linux/mutex.h>
>  #include "lm75.h"
>  
> -
> -/* Addresses to scan */
> -static const unsigned short normal_i2c[] = { 0x48, 0x49, 0x4a, 0x4b, 0x4c,
> -					0x4d, 0x4e, 0x4f, I2C_CLIENT_END };
> -
> -/* Insmod parameters */
> -I2C_CLIENT_INSMOD_1(lm75);
> -

What about all the (PC) systems where the LM75 devices were probed
successfully so far? You're breaking them!

Adding support for new-style devices is fine. Dropping support for
legacy devices is not. Please see the f75375s driver for an example of
driver supporting both legacy and new-style i2c devices.

Note that David Brownell (Cc'd) had been working on this back in
September 2007:
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-September/021270.html
Unfortunately he never got around to addressing all my comments, so his
patch didn't go anywhere. Maybe you can work with David on getting
something in shape that would be suitable for upstream submission.

>  /* Many LM75 constants specified below */
>  
>  /* The LM75 registers */
> @@ -49,34 +41,61 @@ static const u8 LM75_REG_TEMP[3] = {
>  
>  /* Each client has this additional data */
>  struct lm75_data {
> -	struct i2c_client	client;
> -	struct device *hwmon_dev;
> -	struct mutex		update_lock;
> -	char			valid;		/* !=0 if following fields are valid */
> -	unsigned long		last_updated;	/* In jiffies */
> -	u16			temp[3];	/* Register values,
> -						   0 = input
> -						   1 = max
> -						   2 = hyst */
> +	struct device	*hwmon_dev;
> +	struct mutex	update_lock;
> +	char		valid;		/* !=0 if following fields are valid */
> +	unsigned long	last_updated;	/* In jiffies */
> +	u16		temp[3];	/* Register values,
> +					   0 = input
> +					   1 = max
> +					   2 = hyst */
>  };

And please do NOT mix coding style cleanups with real code changes.
Each patch should do just one thing, so that it is easy to test and
review.

<snip>

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
