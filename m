From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 10 Feb 2011 09:43:45 +0000
Subject: Re: [lm-sensors] [PATCH 1/6] hwmon: (w83627ehf) Skip in6 and temp3
Message-Id: <20110210104345.3904c1f3@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1297308953-3479-2-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1297308953-3479-2-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 9 Feb 2011 19:35:47 -0800, Guenter Roeck wrote:
> temp3 and in6 are mutually exclusive only on W83667HG, not on W83667HG-B.

Hmm? The datasheet I have (version 1.3, 2009-12-15) for the W83667HG-B
lists pin 109 as VIN3 / AUXTIN, which correspond to in6 and temp3 in the
w83627ehf driver. The datasheet for the NCT5571D (which I think is the
same as W83667HG-B but in a different package) also shows VIN3 / AUXTIN
on the same pin (54). So this is the same as for the W83667HG.

With a single pin for both functions, I fail to see how you could have
both at the same time. What makes you think it is possible for the
W83667HG-B?

> All other chips support both at the same time.
> 
> Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> ---
>  drivers/hwmon/w83627ehf.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/hwmon/w83627ehf.c b/drivers/hwmon/w83627ehf.c
> index 073eabe..415c448 100644
> --- a/drivers/hwmon/w83627ehf.c
> +++ b/drivers/hwmon/w83627ehf.c
> @@ -1398,7 +1398,7 @@ static int __devinit w83627ehf_probe(struct platform_device *pdev)
>  			 || sio_data->kind = w83667hg_b) ? 3 : 4;
>  
>  	/* Check temp3 configuration bit for 667HG */
> -	if (sio_data->kind = w83667hg || sio_data->kind = w83667hg_b) {
> +	if (sio_data->kind = w83667hg) {
>  		data->temp3_disable = w83627ehf_read_value(data,
>  					W83627EHF_REG_TEMP_CONFIG[1]) & 0x01;
>  		data->in6_skip = !data->temp3_disable;


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
