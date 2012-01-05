From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 05 Jan 2012 17:55:54 +0000
Subject: Re: [lm-sensors] [PATCH v2 2/2] lm80.c: reinitialize client if data
Message-Id: <20120105175554.GC9257@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1325770914-23620-2-git-send-email-fransmeulenbroeks@gmail.com>
In-Reply-To: <1325770914-23620-2-git-send-email-fransmeulenbroeks@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Jan 05, 2012 at 08:41:54AM -0500, Frans Meulenbroeks wrote:
> if data->valid = 0 when asking for an update reinitialize
> the client.
> This is done for the case that the device got disconnected
> as without reinitialisation it will not give any sensible
> readings.
> 
> Signed-off-by: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
> ---
> 
> Tested with actual system and unplugging and replugging the device
> 
>  drivers/hwmon/lm80.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/hwmon/lm80.c b/drivers/hwmon/lm80.c
> index 616f470..1d86912 100644
> --- a/drivers/hwmon/lm80.c
> +++ b/drivers/hwmon/lm80.c
> @@ -583,6 +583,11 @@ static struct lm80_data *lm80_update_device(struct device *dev)
>  
>  	mutex_lock(&data->update_lock);
>  
> +    /* If the data is not valid it might be the device was temporarily
> +       disconnected. In order to keep things running re-initialize the lm80 */
> +	if (!data->valid)
> +		lm80_init_client(client);
> +

Problem with this is that it results in double initialization for everyone,
since data->valid will initially be false.

I would prefer if you add an error flag and set it if an error actually occurs, and use it
to determine if you want/need to re-initialize the chip.

Also,  think it would be better if you modify lm80_init_client() to return an error
if chip initialization fails, and bail out if that happens. After all, it doesn't
make sense to try to re-initialize the chip while is not there, or to try reading
from it if chip initialization failed. So you would have something like

	if (data->error) {
		rv = lm80_init_client(client);
		if (rv)
			goto abort;
		data->error = 0;
	}

	...
abort:
	ret = ERR_PTR(rv);
	data->error = 1;
	data->valid = 0;
	...

With the added error checking, you should probably bail out in the _probe function
if lm80_init_client() fails.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
