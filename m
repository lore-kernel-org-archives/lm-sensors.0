From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 10 Aug 2011 17:05:05 +0000
Subject: Re: [lm-sensors] [PATCH 2/3] hwmon: Fix applesmc temperature
Message-Id: <1312995905.2214.8.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1312906483-3046-2-git-send-email-mjg@redhat.com>
In-Reply-To: <1312906483-3046-2-git-send-email-mjg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 2011-08-09 at 12:14 -0400, Matthew Garrett wrote:
> The temperature registers in the applesmc hardware are signed. It's likely
> that a negative value is invalid, so trigger on that and return an error
> rather than an erroneous value.
> 
> Signed-off-by: Matthew Garrett <mjg@redhat.com>
> ---
>  drivers/hwmon/applesmc.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/hwmon/applesmc.c b/drivers/hwmon/applesmc.c
> index 62e2493..4540bb1 100644
> --- a/drivers/hwmon/applesmc.c
> +++ b/drivers/hwmon/applesmc.c
> @@ -781,6 +781,10 @@ static ssize_t applesmc_show_temperature(struct device *dev,
>  		return ret;
>  
>  	if (entry->len = 2) {
> +		if (buffer[0] >= 0x80) {
> +			/* The two byte format is signed - ignore negative */
> +			return -EINVAL;
> +		}

Kind of unusual. Do you have evidence that such an error is in fact
seen ? If there is no such evidence, I'd rather keep the original code.
We don't usually return errors for negative temperature readings just
because we assume that the readings might be erroneous.

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
