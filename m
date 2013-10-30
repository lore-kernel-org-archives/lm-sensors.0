From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 30 Oct 2013 15:53:15 +0000
Subject: Re: [lm-sensors] [PATCH v4 2/3] hwmon: (lm90) add support to handle IRQ
Message-Id: <20131030165315.077703b3@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1375856306-14415-1-git-send-email-wni@nvidia.com>
	<1375856306-14415-3-git-send-email-wni@nvidia.com>
In-Reply-To: <1375856306-14415-3-git-send-email-wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Wed, 7 Aug 2013 14:18:25 +0800, Wei Ni wrote:
> When the temperature exceed the limit range value,
> the driver can handle the interrupt.
> 
> Signed-off-by: Wei Ni <wni@nvidia.com>
> ---
>  drivers/hwmon/lm90.c |   23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> (...)

This one looks good now, thanks, with just one minor change I'd do
before committing:

> +			dev_err(dev, "cannot request IRQ: %d\n", client->irq);

The ":" isn't really needed, I'll remove it.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
