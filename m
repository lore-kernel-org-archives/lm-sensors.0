From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 13 Mar 2012 07:42:21 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon: (w83627ehf) Add support for temperature offset registers
Message-Id: <20120313084221.7cdfc468@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1328807876-26409-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1328807876-26409-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Thu, 9 Feb 2012 09:17:56 -0800, Guenter Roeck wrote:
> Add support for temperature offset registers for CPUTIN, SYSTIN,
> and AUXTIN temperatures.
> 
> Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> ---
>  drivers/hwmon/w83627ehf.c |   73 +++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 73 insertions(+), 0 deletions(-)

I can't test that, overall it looks good, except one thing:

> diff --git a/drivers/hwmon/w83627ehf.c b/drivers/hwmon/w83627ehf.c
> index 57a31a0..5273fff 100644
> --- a/drivers/hwmon/w83627ehf.c
> +++ b/drivers/hwmon/w83627ehf.c
> (...)
> @@ -2204,6 +2265,11 @@ static int __devinit w83627ehf_probe(struct platform_device *pdev)
>  		data->in6_skip = 1;			/* No VIN3 */
>  
>  		data->temp_label = w83667hg_b_temp_label;
> +		data->have_temp_offset = data->have_temp & 0x03;
> +		for (i = 0; i < 2; i++) {
> +			if (data->temp_src[i] > 1)
> +				data->have_temp_offset &= ~(1 << i);
> +		}

This is the W83627UHG case, and while it has only two analog
temperature inputs, it can have up to 3 temperature channels. temp1 is
hard-coded to SYSTIN, temp2 can be set to PECI and temp3 to CPUTIN, in
which case temp3 would support temperature offset. So you should loop
up to i < 3, not 2.

Once this is fixed, you can add:

Acked-by: Jean Delvare <khali@linux-fr.org>

While reviewing this patch, I found that the code which sets the source
for temp2 is broken (for W83627UHG only), I'll send a fix now.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
