From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 08 Feb 2012 18:56:07 +0000
Subject: Re: [lm-sensors] [PATCH 3/4] hwmon: (f75375s) Fix bit shifting in f75375_write16
Message-Id: <1328727367.2261.323.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1328723771-22163-4-git-send-email-mail@microschulz.de>
In-Reply-To: <1328723771-22163-4-git-send-email-mail@microschulz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 2012-02-08 at 12:56 -0500, Nikolaus Schulz wrote:
> From: Nikolaus Schulz <schulz@macnetix.de>
> 
> In order to extract the high byte of the 16-bit word, shift the word to
> the right, not to the left.
> 
> Signed-off-by: Nikolaus Schulz <mail@microschulz.de>
> Cc: stable@kernel.org
> ---
>  drivers/hwmon/f75375s.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/hwmon/f75375s.c b/drivers/hwmon/f75375s.c
> index b3eef44..0aabaaf 100644
> --- a/drivers/hwmon/f75375s.c
> +++ b/drivers/hwmon/f75375s.c
> @@ -172,7 +172,7 @@ static inline void f75375_write8(struct i2c_client *client, u8 reg,
>  static inline void f75375_write16(struct i2c_client *client, u8 reg,
>  		u16 value)
>  {
> -	int err = i2c_smbus_write_byte_data(client, reg, (value << 8));
> +	int err = i2c_smbus_write_byte_data(client, reg, (value >> 8));
>  	if (err)
>  		return;
>  	i2c_smbus_write_byte_data(client, reg + 1, (value & 0xFF));

Again, nice catch. A bit puzzling, though, that this wasn't caught
earlier.

Thanks, applied.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
