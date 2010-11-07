From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sun, 07 Nov 2010 16:53:28 +0000
Subject: Re: [lm-sensors] [PATCH 5/7] hwmon: (w83795) Read the intrusion
Message-Id: <20101107165328.GE18730@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101107164637.2b812eef@endymion.delvare>
In-Reply-To: <20101107164637.2b812eef@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Nov 07, 2010 at 10:46:37AM -0500, Jean Delvare wrote:
> We can't read the intrusion state from the real-time alarm registers
> as we do for all other alarm flags, because real-time alarm bits don't
> stick (by definition) and the intrusion state has to stick until
> explicitly cleared (otherwise it has little value.)
> 
> So we have to use the interrupt status register instead, which is read
> from the same address but with a configuration bit flipped in another
> register.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> ---
>  w83795.c |   23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
> 
> --- a/drivers/hwmon/w83795.c	2010-11-05 22:12:32.000000000 +0100
> +++ b/drivers/hwmon/w83795.c	2010-11-06 22:37:55.000000000 +0100
> @@ -165,10 +165,11 @@ static const u8 IN_LSB_SHIFT_IDX[][2] >  
>  #define W83795_REG_VID_CTRL		0x6A
>  
> +#define W83795_REG_ALARM_CTRL		0x40
> +#define ALARM_CTRL_RTSACS		(1 << 7)
>  #define W83795_REG_ALARM(index)		(0x41 + (index))
> -#define W83795_REG_BEEP(index)		(0x50 + (index))
> -
>  #define W83795_REG_CLR_CHASSIS		0x4D
> +#define W83795_REG_BEEP(index)		(0x50 + (index))
>  
>  
>  #define W83795_REG_FCMS1		0x201
> @@ -585,6 +586,7 @@ static struct w83795_data *w83795_update
>  	struct i2c_client *client = to_i2c_client(dev);
>  	struct w83795_data *data = i2c_get_clientdata(client);
>  	u16 tmp;
> +	u8 intrusion;
>  	int i;
>  
>  	mutex_lock(&data->update_lock);
> @@ -656,9 +658,24 @@ static struct w83795_data *w83795_update
>  		    w83795_read(client, W83795_REG_PWM(i, PWM_OUTPUT));
>  	}
>  
> -	/* update alarm */
> +	/* Update intrusion and alarms
> +	 * It is important to read intrusion first, because reading from
> +	 * register SMI STS6 clears the interrupt status temporarily. */
> +	tmp = w83795_read(client, W83795_REG_ALARM_CTRL);
> +	/* Switch to interrupt status for intrusion if needed */
> +	if (tmp & ALARM_CTRL_RTSACS)
> +		w83795_write(client, W83795_REG_ALARM_CTRL,
> +			     tmp & ~ALARM_CTRL_RTSACS);
> +	intrusion = w83795_read(client, W83795_REG_ALARM(5)) & (1 << 6);
> +	/* Switch to real-time alarms */
> +	w83795_write(client, W83795_REG_ALARM_CTRL, tmp | ALARM_CTRL_RTSACS);
>  	for (i = 0; i < ARRAY_SIZE(data->alarms); i++)

>  		data->alarms[i] = w83795_read(client, W83795_REG_ALARM(i));
> +	data->alarms[5] |= intrusion;
> +	/* Restore original configuration if needed */
> +	if (!(tmp & ALARM_CTRL_RTSACS))
> +		w83795_write(client, W83795_REG_ALARM_CTRL,
> +			     tmp & ~ALARM_CTRL_RTSACS);
>  
Does this make a difference, ie is it needed ?
If not, might be simpler to just switch back and forth w/o checking
if ALARM_CTRL_RTSACS is set.

Anyway,
	Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
